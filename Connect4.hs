import Prelude
import Data.List
import Data.Char

-- Setting up our board and starting the game
main = do
  let board = ["-------","-------","-------","-------","-------","-------"]
  putStrLn "-------Begin Game------"
  printMaze(formatColumn board)
  print "Enter Column: Player 1"
  moves <- getLine
  connectFourT board (head moves) 1

-- Acts as a while loop till one of the gameOverClauses is true and then game is done
connectFourT :: [[Char]] -> Char -> Int -> IO ()
connectFourT ma m p
 | p == 3 = connectFourT ma m 1
 | otherwise = do
             let board = (startGame ma m p)
             printMaze(formatColumn board)
             let player
                  | p == 1 = 2
                  | otherwise = 1
             if gameOverClauses board
                then
                  do
                    printMaze(formatColumn board)
                    let b = "Congratulations Player " ++ (show (p)) ++ ", you have won!"
                    print b
             else if isDraw board
                then
                  do
                    printMaze(formatColumn board)
                    let c = "It's a draw "
                    print c
                else
                  do
                   let a = "Enter Column: Player " ++ (show player)
                   print a
                   n <- getLine
                   connectFourT board (head n) (p + 1)

-- mo represents move and if '1' then it work through column 1
-- tranpose to make column into row so because it's easier work on things horizontally
-- algorithm
-- 1. Tranpose the maze so column become row
-- 2. getRow fetches the row corresponding with the move
-- 3. put the piece in horizontally till it hits another piece or the end
-- 4. setRow puts the row you just updated back into the 2d list
-- 5. Tranpose the 2d list so that the row become column and column becomes row again

startGame :: [[Char]] -> Char -> Int -> [[Char]]
startGame ma mo n
 | mo == '1' =  transpose(setRow (moveRight (getRow(tma) 0 0) p) (tma) 0 0)
 | mo == '2' =  transpose(setRow (moveRight (getRow(tma) 1 0) p) (tma) 1 0)
 | mo == '3' =  transpose(setRow (moveRight (getRow(tma) 2 0) p) (tma) 2 0)
 | mo == '4' =  transpose(setRow (moveRight (getRow(tma) 3 0) p) (tma) 3 0)
 | mo == '5' =  transpose(setRow (moveRight (getRow(tma) 4 0) p) (tma) 4 0)
 | mo == '6' =  transpose(setRow (moveRight (getRow(tma) 5 0) p) (tma) 5 0)
 | mo == '7' =  transpose(setRow (moveRight (getRow(tma) 6 0) p) (tma) 6 0)
 where
   p = intToDigit n
   tma = transpose ma

-- gameOverClauses: checks for if the board is full and for any 4 in a row
gameOverClauses :: [[Char]] -> Bool
gameOverClauses ma
 | isGameOver ma = True
 | isGameOver (transpose ma) = True
 | isGameOver (getDiagonals ma) = True
 | isGameOver (getDiagonals (reverse ma)) = True
 | otherwise = False

-- checks to see if it's draw
isDraw :: [[Char]] -> Bool
isDraw ma
 | (countSpaces ma 0) == 42 = True
 | otherwise = False

-- Since it's a 2d list isGameOver cycles through each row
isGameOver :: [[Char]] -> Bool
isGameOver [] = False
isGameOver (x:xs)
    | checkHorizontal x = True
    | otherwise = isGameOver xs

 -- looks for 4 in a row matchs in a 1d list
checkHorizontal :: [Char] -> Bool
checkHorizontal ma
    | (length ma) < 4 = False
checkHorizontal (a:b:c:d:xs)
    | (a == b && a == b && a == c && a == d && ( a == 'X'|| a == 'O')) = True
    | otherwise = checkHorizontal (b:c:d:xs)

-- returns how many moves have been done
countSpaces :: [[Char]] -> Int -> Int
countSpaces [] n = n
countSpaces (x:xs) n =  countSpaces xs (length(intersect x "XO") + n)

-- replaces a row in a 2d list after being updated
setRow :: [Char] -> [[Char]] -> Int -> Int ->[[Char]]
setRow r (x:xs) n m
 | n == m = (r:xs)
 | otherwise = x:(setRow r xs n (m+1))

-- grabs a row in a 2d list
getRow :: [[Char]] -> Int -> Int -> [Char]
getRow [] _ _ = []
getRow (row:rows) n m
 | n == m = row
 | otherwise = getRow rows n (m + 1)

-- grabs the diagonals in a 2d list
getDiagonals :: [[Char]] -> [[Char]]
getDiagonals = map concat
              . transpose
              . zipWith (\ns xs -> ns ++ map (:[]) xs)
                        (iterate ([]:) [])

-- it's called move right because when you tranpose a 2d list, the column becomes row
-- and you just need to move your pieces horizontal toward the right
moveRight :: [Char] -> Char -> [Char]
moveRight [] p = []
moveRight [x] p = [x]
moveRight (x:y:xs) p
 | (x == '-' && y == '-') =  moveRight (formatPlayer p:y:xs) (formatPlayer p)
 | (x == '-' && y /= '-') =  (formatPlayer p:y:xs)
 | (x == p  && y == '-') =  '-':(moveRight (formatPlayer p:xs) (formatPlayer p))
 | otherwise = (x:y:xs)

-- adds spacing to make reading the board easier
formatColumn :: [[Char]] -> [[Char]]
formatColumn [] = []
formatColumn (x:xs) = formatRow x : formatColumn xs

formatRow :: [Char] -> [Char]
formatRow [] = []
formatRow (x:xs) = ' ':(x:' ':formatRow xs)

-- makes player X or O
formatPlayer :: Char -> Char
formatPlayer a
 | a == '1' = 'X'
 | a == 'X' = 'X'
 | otherwise = 'O'

-- prints the maze
printMaze :: [[Char]] -> IO ()
printMaze [] = putStrLn "----------End----------\n"
printMaze (ro:ros) =
                    do
                      print (ro)
                      printMaze ros
