data Tree a = Empty | Node a (Tree a) (Tree a)
            deriving(Show)

data Direction = L | R
               deriving (Show)

-- type Breadcrumbs = [Direction]

-- goLeft :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
-- goLeft (Node _ l _, bs) = (l, L:bs)

-- goRight :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
-- goRight (Node _ _ r, bs) = (r, R:bs)

freeTree :: Tree Char
freeTree =
  Node 'P'
  (Node 'O'
   (Node 'L'
    (Node 'N' Empty Empty)
    (Node 'T' Empty Empty)
   )
   (Node 'Y'
    (Node 'S' Empty Empty)
    (Node 'A' Empty Empty)
   )
  )
  (Node 'L'
   (Node 'W'
    (Node 'C' Empty Empty)
    (Node 'R' Empty Empty)
   )
   (Node 'A'
    (Node 'A' Empty Empty)
    (Node 'C' Empty Empty)
   )
  )

(-:) = flip ($)

data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a)
             deriving (Show)

type Breadcrumbs a = [Crumb a]

goLeft :: (Tree a, Breadcrumbs a) -> (Tree a, Breadcrumbs a)
goLeft (Node x l r, bs) = (l, LeftCrumb x r : bs)

goRight :: (Tree a, Breadcrumbs a) -> (Tree a, Breadcrumbs a)
goRight (Node x l r, bs) = (r, RightCrumb x l : bs)

goUp :: (Tree a, Breadcrumbs a) -> (Tree a, Breadcrumbs a)
goUp (n, LeftCrumb x r : bs) = (Node x n r, bs)
goUp (n, RightCrumb x l : bs) = (Node x l n, bs)

type Zipper a = (Tree a, Breadcrumbs a)

modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r , bs) = (Node (f x) l r , bs)
modify f (Empty, bs) = (Empty, bs)

attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

topMost :: Zipper a -> Zipper a
topMost (t, []) = (t, [])
topMost z = topMost (goUp z)
