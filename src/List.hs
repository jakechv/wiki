-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Content.List
-- Copyright   :  © 2014 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for org-mode markups and paragraphs.
----------------------------------------------------------------------------

{-# LANGUAGE ScopedTypeVariables #-}


module List
(
  parseList
)
where

import           Control.Monad                                   (guard)
import           Data.Attoparsec.Text                            (Parser, char,
                                                                  digit,
                                                                  isHorizontalSpace,
                                                                  many1')
import           Data.Functor                                    (($>))
import           Data.Maybe                                      (isNothing)

-- import           Data.OrgMode.Parse.Attoparsec.Content.Paragraph (parseParagraph)
import           ParseLinesTill                         (parseLinesContextuallyTill,
                                                                  parseLinesTill,
                                                                  takeContentBreak)
import           ParseTypes                                             (Content (..), Item (..))

import qualified Data.Attoparsec.Text                            as Attoparsec.Text
import qualified Data.Text                                       as Text
import Markup (parseMarkupContent)

type TokenParser = Parser ([Item] -> Content)

-- | Parser will success when the parser position is in a new item or break out from the list
--
--  The Bool determines that whether it is in the first line and therefore ignore the preceding space checks
breakout :: forall b. Int -> Bool -> (Bool, Parser (Either () b))
breakout n isInFirstLine = (False, result isInFirstLine)
  where
    -- fail will take the following text in the same line into the
    -- Item content see details in parseLinesTill of
    -- Util/ParseLinesTill.hs
    result x= guard (not x) *> do
      z <-  Attoparsec.Text.takeWhile isHorizontalSpace
      -- If not enough space in the new line, then it shall be another
      -- item or a new list
      guard (Text.compareLength z n  == LT) $> Left ()

takeHorizontalSpaces :: Int -> Parser ()
takeHorizontalSpaces n = Attoparsec.Text.take n >>= assertSpaces
  where
    assertSpaces t = guard (isNothing (Text.find (not . isHorizontalSpace) t))

parseItemTokens :: [TokenParser]
parseItemTokens = ordered ++ unordered
  where
    ordered      = [many1' digit $> OrderedList]
    unordered    = map parseToken ['*', '-']
    parseToken x = char x $> UnorderedList

data ItemTerm = ItemTerm
  { parseNext     :: Parser Item
  , toListContent :: [Item] -> Content
  , item          :: Item
  }

-- | Create a Parser to Parse Item
parseItemTermVia :: TokenParser -> Parser ItemTerm
parseItemTermVia p = result
  where
    result :: Parser ItemTerm
    result = do
      n <- Text.length <$> Attoparsec.Text.takeWhile1 isHorizontalSpace
      ItemTerm (parseItem n) <$> p <*> (takeHorizontalSpaces 1*> parseItemCore n)

    parseItem ::  Int -> Parser Item
    parseItem n = takeHorizontalSpaces n *> p *> takeHorizontalSpaces 1*> parseItemCore n

    parseItemCore :: Int -> Parser Item
    parseItemCore n =  Item . concat <$> parseLinesContextuallyTill parseContents (breakout (n+1)) True

    parseContents :: Parser [Content]
    parseContents = concat <$> Attoparsec.Text.many' (parseLinesTill parseParagraph (Attoparsec.Text.eitherP takeContentBreak parseList))

parseItemTerm :: Parser ItemTerm
parseItemTerm = Attoparsec.Text.choice (map parseItemTermVia parseItemTokens)

parseList :: Parser Content
parseList = do
  term  <- parseItemTerm
  items <- Attoparsec.Text.many' (parseNext term)
  return $ toListContent term (item term:items)

-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Content.Paragraph
-- Copyright   :  © 2014 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for org-mode markup and paragraphs.
----------------------------------------------------------------------------


-- import           Data.Attoparsec.Text                         (Parser)

-- import           Data.OrgMode.Parse.Attoparsec.Content.Markup (parseMarkupContent)
-- import           Data.OrgMode.Types                           (Content (..))

-- | If a chunk of text cannot be parsed as other blocks, parse the chunk of text as a paragraph
parseParagraph :: Parser Content
parseParagraph = Paragraph <$> parseMarkupContent
