type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
  | (abs (n + left - right)) < 4 = Just (left + n, right)
  | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
  | (abs (n + right - left)) < 4 = Just (left, right + n)
  | otherwise = Nothing

x -: f = f x

banana :: Pole -> Maybe Pole
banana _ = Nothing

