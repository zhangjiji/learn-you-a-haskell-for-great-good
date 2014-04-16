import Control.Monad

main = do
  line <- getLine
  when (not (null line)) $ do
    (putStrLn $ unwords . map reverse . words $ line)
    main
