import os
import glob
from pathlib import Path
from extract_sepolicy_system_ext import SEPolicyParser

def main():
  files = glob.glob("."+os.path.sep+"stock_vendor"+os.path.sep+"*.te")
  for file in files:
    type = Path(file).stem
    setypeparser = SEPolicyParser(type)
    setypeparser.parseFolder("."+os.path.sep+"stock"+os.path.sep)

if __name__ == '__main__':
    main()
