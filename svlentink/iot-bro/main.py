#!/usr/bin/env python3

from brologparse import parse_log
from glob import glob
from fnmatch import fnmatch
import json
import collections

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

#debug()



def get_bro_fields(filename):
  """
  This function returns the fields we parse per file.
  """
  relevantfields = {
    "*.log" : [ 'id_resp_h', 'id_orig_h' ],
    "dns.log" : [ 'query', 'answers', 'qtype_name' ],
    "conn.log" : [ 'resp_bytes', 'orig_bytes', 'id_resp_p', 'service', 'proto' ]
  }
  if filename not in relevantfields:
    return None
  result = []
  for key in relevantfields:
    if fnmatch(filename,key):
      result += relevantfields[key]
  return result

def filter_bro_log(filename):
  fields = get_bro_fields(filename)
  if not fields:
    return None
  result = []
  for fileline in parse_log(file):
    logline = fileline._asdict() #convert tuple to dict
    line = {}
    for f in fields: # get the relevant fields
      line[f] = logline[f]
    result.append(line)
  return result

def filter_on_index(data):
  indices_tree = {
    "*.log" : [ 'id_orig_h' ],
    "dns.log" : [ 'answers' ]
  }
  
  def addval(filename,indx,indx_id,line):
    if indx_id in result[filename][indx]:
      result[filename][indx][indx_id].append(line)
    else:
      result[filename][indx][indx_id] = [line]
  result = {}
  for filename in data:
    if data[filename] and len(data[filename]):
      for fileid in indices_tree: #     for every filename in data
        if fnmatch(filename, fileid): # check if we found a match in indices_tree
          if filename not in result:
            result[filename] = {}
          for indx in indices_tree[fileid]:
            result[filename][indx] = {}
            for line in data[filename]:
              indx_id = line[indx]
              if isinstance(indx_id, str):
                addval(filename,indx,indx_id,line)
              elif isinstance(indx_id, collections.Iterable):
                for i in indx_id:
                  addval(filename,indx,i,line)
              else: # just cast it to str
                addval(filename,indx,str(indx_id),line)
              
  return result
          

data = {}
for file in glob("*.log"):
  data[file] = filter_bro_log(file)

indexed_data = filter_on_index(data)

with open(OUTPUTDIR + '/blob.json', 'w') as fp:
  json.dump(indexed_data, fp, default=str)










print('Python finished')

