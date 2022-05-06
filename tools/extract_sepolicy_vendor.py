import sys
import os
from extract_sepolicy import SEPolicy
from extract_sepolicy import SEFileParser

# BEGIN CLASS SEPolicyParser
class SEPolicyParser:
  def __init__(self,typename):
    self.__typename = typename

  def parseFolder(self,folder):                                                          # Parse the whole folder
    sepolicy = SEPolicy(self.__typename,True)
    sefileparser = SEFileParser(sepolicy)
    sefileparser.parseFolder(folder+"v*")
    sepolicy.optimize()
    if not os.path.exists(folder[:-1]+"_vendor/"):
      os.makedirs(folder[:-1]+"_vendor/")
    sepolicy.outputFile(folder[:-1]+"_vendor/")

# END CLASS SEPolicyParser

def main():
  if len(sys.argv) != 2:
    print("Wrong parameter count")
    return
  setypeparser = SEPolicyParser(sys.argv[1])
  setypeparser.parseFolder("./stock/")

if __name__ == '__main__':
    main()
