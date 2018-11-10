{- |
Module      :  ColatzGenerator.hs
Description :  Module implements the Collatz number series generation algorithm
Copyright   :  (c) David Oniani
License     :  MIT

Maintainer  :  onianidavid@gmail.com
Stability   :  provisional
Portability :  portable

For more information, follow the link below.
https://en.wikipedia.org/wiki/Catalan_number
-}

module CollatzGenerator where


-- | The Collatz sequence generator function
collatzGenerator :: Int -> [Int]
collatzGenerator n = collatzHelper n []
    where
        collatzHelper :: Int -> [Int] -> [Int]
        collatzHelper n x
            | n == 1 = x ++ [n]
            | even n = collatzHelper (div n 2) (x ++ [n])
            | odd n = collatzHelper (3 * n + 1) (x ++ [n])


main = do
    putStr "The Collatz sequence for the number 100 is "
    print (collatzGenerator 100)