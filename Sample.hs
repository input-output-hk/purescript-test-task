{-# LANGUAGE MultiParamTypeClasses #-}

module Sample where

import Data.Semigroup (Semigroup())

class Track e  where
    extract
        :: (Foldable b, Semigroup (t (b a)), Traversable t)
        => e -> t (b a)

class Report d r  where
    produce
        :: (Semigroup (t d), Traversable t)
        => (t d -> r)
