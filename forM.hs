import Control.Monad

main = do
  colors <- forM [1,2,3,4] (\a -> do
                               putStrLn $ "input color with " ++ show a
                               color <- getLine
                               return color)
  putStrLn "result:"
  mapM_ putStrLn colors
  
                               
