import glob
from pathlib import Path
from extract_sepolicy_system_ext import SEPolicyParser

def main():
  files = glob.glob("./lineage_system_ext/*.te")
  for file in files:
    type = Path(file).stem
    setypeparser = SEPolicyParser(type)
    setypeparser.parseFolder("./stock/")
    setypeparser.parseFolder("./lineage/")

if __name__ == '__main__':
    main()
