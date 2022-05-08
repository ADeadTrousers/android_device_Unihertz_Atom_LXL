import sys
import re
import os
import glob

# BEGIN CLASS SEPolicy
class SEPolicyMapping:
  def __init__(self):
    self.__types = []
    self.__typeattributes = []
    self.__attributes = []
    self.__expandattributes = []
    self.__patternline = re.compile("(?:[ (]?(\w+)[ )]?)")
    self.__patternversion = re.compile("_[0-9]+_[0-9]+$")
      
  def parseLine(self,line):
    if line.startswith("#"):
     return
    elif line.startswith(";;"):
     return
    matches = self.__patternline.findall(line)
    if len(matches) <= 0:
      print(f"Wrong line found: {line}")
    elif matches[0] == "typeattributeset":
      if len(matches) == 3:
        self.__addTypeAttribute(matches[2],matches[1])
    elif matches[0] == "expandtypeattribute":
      if len(matches) == 3:
        self.__addExpandAttribute(matches[1],matches[2])
    elif matches[0] == "typeattribute":
      if len(matches) == 2:
        self.__addAttribute(matches[1])
    elif matches[0] == "type":
      if len(matches) == 2:
        self.__addType(matches[1])
    else:
      print(f"Wrong command found: {matches[0]}")
        
  def optimize(self):
    self.__attributes = sorted(list(dict.fromkeys(self.__attributes)))          # Optimize all lists and remove duplicates
    self.__types = sorted(list(dict.fromkeys(self.__types)))           
    self.__typeattributes = sorted(list(dict.fromkeys(self.__typeattributes)))           
    self.__expandattributes = sorted(list(dict.fromkeys(self.__expandattributes)))           
       
  def outputFiles(self,path):
    file = open(path+"attributes","wt")
    self.__outputArray(file,self.__attributes)
    file.close()
    file = open(path+"types.te","wt")
    self.__outputArray(file,self.__types)
    file.write('\n')
    self.__outputArray(file,self.__typeattributes)
    file.write('\n')
    self.__outputArray(file,self.__expandattributes)
    file.close()
  
  def __addType(self,type):
    self.__types.append(f"type {self.__removeVersion(type)};")

  def __addTypeAttribute(self,type,attribute):
    self.__typeattributes.append(f"typeattribute {self.__removeVersion(attribute)} {type};")
  
  def __addExpandAttribute(self,attribute,expanding):
    self.__expandattributes.append(f"expandtypeattribute {{{ self.__removeVersion(attribute) }}} {expanding};")

  def __addAttribute(self,attribute):
    self.__attributes.append(f"attribute {self.__removeVersion(attribute)};")
  
  def __removeVersion(self,text):
    return self.__patternversion.sub("",text)

  def __outputArray(self,file,array):
    if len(array) == 0:
      return
    for line in array:
      file.write(line+'\n')
# END CLASS SEPolicyMappig

# BEGIN CLASS SEFileMappingParser
class SEFileMappingParser:
  def __init__(self,outputfolder):
    self.__pattern = re.compile(f"(?:[^\{os.path.sep}]*[\{os.path.sep}])*([0-9]+\.[0-9]+)\.cil")
    self.__outputfolder = outputfolder

  def parseFile(self,name):
    match = self.__pattern.search(name)
    if match == None:                                                           # Parse one file
      return
    print(f"File: {name}")
    file = open(name,"rt")
    sepolicy = SEPolicyMapping()
    for line in file:
       sepolicy.parseLine(line)
    file.close();
    sepolicy.optimize()
    outputfolder = self.__outputfolder+match.group(1)+os.path.sep
    if not os.path.exists(outputfolder):
      os.makedirs(outputfolder)
    sepolicy.outputFiles(outputfolder)

  def parseFolder(self,name):                                                   # Parse all files in the folder
    files = glob.glob(name)
    for file in files:
      if os.path.isfile(file):
        self.parseFile(file)
# END CLASS SEFileMappingParser

# BEGIN CLASS SEFolderMappingParser
class SEFolderMappingParser:
  def __init__(self):
    pass

  def parseFolder(self,folder):                                                 # Parse the whole folder
    outputFolder = folder[:-1]+"_mapping"+os.path.sep
    if not os.path.exists(outputFolder):
      os.makedirs(outputFolder)
    sefileparser = SEFileMappingParser(outputFolder)
    sefileparser.parseFolder(folder+"*.cil")
# END CLASS SEFolderMappingParser

def main():
  semappingparser = SEFolderMappingParser()
  semappingparser.parseFolder("."+os.path.sep+"lineage"+os.path.sep)
  semappingparser.parseFolder("."+os.path.sep+"stock"+os.path.sep)

if __name__ == '__main__':
    main()
