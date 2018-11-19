{- |
Module      :  BinarySearchTree.hs
Description :  Module implements the binary search tree data structure
Copyright   :  (c) David Oniani
License     :  MIT

Maintainer  :  onianidavid@gmail.com
Stability   :  provisional
Portability :  portable

For more information, follow the link below.
https://en.wikipedia.org/wiki/Binary_search_tree
-}

module BinarySearchTree
    ( rootInitialize
    , insertNode
    , preorderTraversal
    , inorderTraversal
    , postorderTraversal
    , searchNode
    , fromList
    , getLeftmostNode
    , getRightmostNode
    , deleteNode
    , isNullTree
    ) where

import BinaryTreeNode


-- | Initialize the root of the binary search tree
rootInitialize :: TreeNode
rootInitialize = NULL

-- | Insert a node into the binary search tree
insertNode :: TreeNode -> Integer -> TreeNode
insertNode NULL insertValue = newNode insertValue
insertNode (TreeNode nodeValue leftChild rightChild) insertValue
    | nodeValue > insertValue = TreeNode nodeValue (insertNode leftChild insertValue) rightChild
    | nodeValue < insertValue = TreeNode nodeValue leftChild (insertNode rightChild insertValue)
    | otherwise = error "Binary search tree does not allow duplicates!"

-- | The preorder traversal of the binary search tree
preorderTraversal :: TreeNode -> [Integer]
preorderTraversal NULL = []
preorderTraversal (TreeNode nodeValue leftChild rightChild) = [nodeValue] ++ preorderTraversal leftChild ++ preorderTraversal rightChild

-- | The inorder traversal of the binary search tree
inorderTraversal :: TreeNode -> [Integer]
inorderTraversal NULL = []
inorderTraversal (TreeNode nodeValue leftChild rightChild) = inorderTraversal leftChild ++ [nodeValue] ++ inorderTraversal rightChild

-- | The postorder traversal of the binary search tree
postorderTraversal :: TreeNode -> [Integer]
postorderTraversal NULL = []
postorderTraversal (TreeNode nodeValue leftChild rightChild) = postorderTraversal leftChild ++ postorderTraversal rightChild ++ [nodeValue]

-- | Check if the node is in the binary search tree
searchNode :: TreeNode -> Integer -> Bool
searchNode NULL _ = False
searchNode (TreeNode nodeValue leftChild rightChild) searchValue
    | nodeValue == searchValue = True
    | nodeValue > searchValue = searchNode leftChild searchValue
    | nodeValue < searchValue = searchNode rightChild searchValue

-- | Get the leftmost node of the binary search tree
getLeftmostNode :: TreeNode -> Integer
getLeftmostNode (TreeNode nodeValue NULL rightChild) = nodeValue
getLeftmostNode (TreeNode nodeValue leftChild rightChild) = getLeftmostNode leftChild

-- | Get the rightmost node of the binary search tree
getRightmostNode :: TreeNode -> Integer
getRightmostNode (TreeNode nodeValue leftChild NULL) = nodeValue
getRightmostNode (TreeNode nodeValue leftChild rightChild) = getRightmostNode rightChild

-- | Delete a node of the binary search tree
deleteNode :: TreeNode -> Integer -> TreeNode
deleteNode NULL _ = NULL
deleteNode (TreeNode nodeValue leftChild rightChild) deleteValue
    | nodeValue > deleteValue = TreeNode nodeValue (deleteNode leftChild deleteValue) rightChild
    | nodeValue < deleteValue = TreeNode nodeValue leftChild (deleteNode rightChild deleteValue)
    | nodeValue == deleteValue && leftChild == NULL && rightChild == NULL = NULL
    | nodeValue == deleteValue && leftChild == NULL = rightChild
    | nodeValue == deleteValue && rightChild == NULL = leftChild
    | otherwise = TreeNode (getLeftmostNode rightChild) leftChild (deleteNode rightChild (getLeftmostNode rightChild))

-- | Build a binary search tree from a list of integers
fromList :: [Integer] -> TreeNode
fromList [] = nullNode
fromList (x:xs) = fromListHelper (TreeNode x NULL NULL) xs
    where
        fromListHelper y [] = y
        fromListHelper y xs = foldl insertNode y xs

-- | Check if the tree is empty
isNullTree :: TreeNode -> Bool
isNullTree NULL = True
isNullTree _ = False


main = do
    let bst = rootInitialize
    print bst
    let bst1 = insertNode bst 1
    let bst2 = insertNode bst1 3
    let bst3 = insertNode bst2 6
    let bst4 = insertNode bst3 2
    print bst1
    print bst2
    print bst3
    print bst4
    putStr "\n"
    putStrLn "Traversals"
    print (preorderTraversal bst4)
    print (inorderTraversal bst4)
    print (postorderTraversal bst4)
    putStr "\n"
    putStrLn "Node existence"
    print (searchNode bst1 1)
    print (searchNode bst1 3)
    print (searchNode bst1 6)
    print (searchNode bst1 2)
    putStr "\n"
    print (searchNode bst2 1)
    print (searchNode bst2 3)
    print (searchNode bst2 6)
    print (searchNode bst3 2)
    putStr "\n"
    print (searchNode bst3 1)
    print (searchNode bst3 3)
    print (searchNode bst3 6)
    print (searchNode bst3 2)
    putStr "\n"
    print (searchNode bst4 1)
    print (searchNode bst4 3)
    print (searchNode bst4 6)
    print (searchNode bst4 2)
    putStr "\n"
    putStrLn "Constructing the binary search tree from a list"
    let bst5 = fromList [0,10,6,7,19]
    let bst6 = fromList [12,7,14,6]
    let bst7 = fromList [20,10,22,18,25]
    print bst5
    print bst6
    print bst7
    putStr "\n"
    putStrLn "Getting the leftmost and rightmost nodes"
    print (getLeftmostNode bst4)
    print (getRightmostNode bst4)
    putStr "\n"
    putStrLn "Deleting the nodes from the binary search tree"
    print (deleteNode bst6 10)
    print (deleteNode bst6 7)
    print (deleteNode bst5 10)
    putStr "\n"
    putStrLn "Checking the emptiness of the binary search tree"
    print (isNullTree nullNode)
    print (isNullTree bst1)
    print (isNullTree bst2)
