import sys
import os
from extract_sepolicy import SEPolicy
from extract_sepolicy import SEFileParser

# BEGIN CLASS SEPolicyParser
class SEPolicyParser:
  def __init__(self,typename):
    self.__typename = typename

  def parseFolder(self,folder):                                                          # Parse the whole folder
    sepolicy = SEPolicy(self.__typename,False)
    sefileparser = SEFileParser(sepolicy)
    sefileparser.parseFolder(folder+"system_ext_*")
    sepolicy.optimize()
    outputfolder = folder[:-1]+"_system_ext"+os.path.sep
    if not os.path.exists(outputfolder):
      os.makedirs(outputfolder)
    sepolicy.outputFile(outputfolder)

# END CLASS SEPolicyParser

def main():
  if len(sys.argv) != 2:
    print("Wrong parameter count")
    return
  setypeparser = SEPolicyParser(sys.argv[1])
  setypeparser.parseFolder("."+os.path.sep+"stock"+os.path.sep)
  setypeparser.parseFolder("."+os.path.sep+"lineage"+os.path.sep)

if __name__ == '__main__':
    main()
