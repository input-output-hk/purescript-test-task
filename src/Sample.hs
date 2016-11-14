{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}

module Sample
  (Track(extract)
  ,Report(produce)
  ,Input()
  ,Output()
  ,rawData
  ,trackingExample)
  where

import           Data.Text             (Text ())
import           Data.Time.Clock       (NominalDiffTime ())
import           Data.Time.Clock.POSIX (POSIXTime ())

class Track e t b a where
    extract
        :: (Foldable b, Monoid (t (b a)), Traversable t)
        => e -> t (b a) -> t (b a)

class Report d r  where
    produce
        :: (Monoid (t d), Traversable t)
        => (t d -> r)

type Input = (Text, POSIXTime)

type Output = (Text, NominalDiffTime)

instance Track [Input] [] [] Output where
    extract xs ds = ds `mappend` fst (foldl f ([], undefined) xs)
      where
        f ([ys], (yu, v0)) (u,v) = ([((yu, v - v0) : ys)], (u, v))
        f _                (u,v) = ([[]],                  (u, v))

speakers :: [Text]
speakers = ["Jonn", "Charles", "Arseniy", "Jonn", "George", "Meeting Ended"]

timeStamps :: [Integer]
timeStamps =
    [1479081309, 1479081429, 1479081666, 1479082000, 1479083307, 1479085307]

rawData :: [Input]
rawData = zipWith (\x y -> (x, fromIntegral y)) speakers timeStamps

trackingExample :: [[Output]]
trackingExample = extract rawData []

