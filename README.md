# Connect4UsingHaskell
I made this as an opportunity to understand Haskell more in-depth

To Run
1. Download the file
2. Locate the file in Terminal
3. Run the file using your Haskell Compiler

How to play

* After launching the game, you get this image and a prompt

-------Begin Game------
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
-----------------------
"Enter Column: Player 1"
-- Inputs here are [1..7] 

For Example: After entering 1, we see X has been placed in column 1 and a prompt for player 2 is invoked

"Enter Column: Player 1"
1
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" X  -  -  -  -  -  - "
-----------------------

"Enter Column: Player 2"

-- Follow this format to play the game

* After winning the game, you are given the final board and congratulations message. 

" -  -  -  -  -  -  - "
" -  -  -  -  -  -  - "
" X  -  -  -  -  -  - "
" X  O  -  -  -  -  - "
" X  O  -  -  -  -  - "
" X  O  -  -  -  -  - "
-----------------------

"Congratulations Player 1, you have won!"
