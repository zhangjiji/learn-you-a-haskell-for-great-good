import System.Environment (getArgs)
import System.Directory (removeFile, renameFile)
import System.IO (hClose, openTempFile)
import Control.Exception (bracketOnError)
import qualified Data.ByteString.Lazy as B(readFile, hPutStr)

main = do
  (fileName1:fileName2:_) <- getArgs
  copyFile fileName1 fileName2

copyFile source dest = do
  contents <- B.readFile source
  bracketOnError (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
      hClose tempHandle
      removeFile tempName)
    (\(tempName, tempHandle) -> do
        B.hPutStr tempHandle contents
        hClose tempHandle
        renameFile tempName dest)
