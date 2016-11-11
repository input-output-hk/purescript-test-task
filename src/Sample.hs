{-# LANGUAGE MultiParamTypeClasses #-}

module Sample where

class Track e  where
    extract
        :: (Foldable b, Monoid (t (b a)), Traversable t)
        => e -> t (b a)

class Report d r  where
    produce
        :: (Monoid (t d), Traversable t)
        => (t d -> r)
