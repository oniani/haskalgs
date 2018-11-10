{- |
Module      :  DiatomicGenerator.hs
Description :  Module implements the Stern's diatomic sequence generation algorithm
Copyright   :  (c) David Oniani
License     :  MIT

Maintainer  :  onianidavid@gmail.com
Stability   :  provisional
Portability :  portable

For more information, follow the link below.
http://www-math.mit.edu/~rstan/papers/stern.pdf
-}

module DiatomicGenerator where


-- | Stern's diatomic sequence generator function
diatomicGenerator :: Int -> [Int]
diatomicGenerator n = take n [diatomicHelper i | i <- [0..]]
    where
        diatomicHelper :: Int -> Int
        diatomicHelper k
            | k < 2 = k
            | even k = diatomicHelper (div k 2)
            | odd k = diatomicHelper (div (k - 1) 2) + diatomicHelper (div (k + 1) 2)


main = do
    putStr "The first [lazily evaluated] 100 elements of the Stern's diatomic sequence are "
    print (diatomicGenerator 100)