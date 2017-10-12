#!/usr/bin/env python3

from brologparse import parse_log
from glob import glob

INPUT='/input'
OUTPUTDIR='/output'

def debug():
  """This function loops through all log files and shows you what data could be expected"""
  for file in glob("./*.log"):
    i=0
    try:
      print('showing',file)
      for entry in parse_log(file):
        # entry._fields: Tuple of strings listing the field names
        # entry._asdict(): Return a new OrderedDict which maps field names to their corresponding values
        print(entry)
        i += 1
        if i == 2:
          break
    except Exception as e:
      print('ERROR content of file was not displayed:',e)

debug()

print('Python finished')
