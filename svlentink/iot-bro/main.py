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

def filter_on_index(data, indices_tree):
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
          #print('Found a match', filename, fileid)
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



      
# first we parse all the log files
logfilesdata = {}
for file in glob("*.log"):
  logfilesdata[file] = filter_bro_log(file)




# Then we do the first indexing
# based on original address and the answers for the dns queries
indx01 = {
    "*.log" : [ 'id_orig_h' ],
    "dns.log" : [ 'answers' ]
  }

firstindexing = filter_on_index(logfilesdata,indx01)




# Next we get it sorted by which ip connects to which one
indx02 = {
  "*" : [ 'id_resp_h'] #, 'id_resp_p' ]
}

sortedbyip = filter_on_index(firstindexing['conn.log']['id_orig_h'],indx02)




# Now we will sort the traffic per port for every host it connects to
sortedbyport = {}
for ip in sortedbyip:
  sortedbyport[ip] = filter_on_index(sortedbyip[ip]['id_resp_h'], { "*" : ["id_resp_p"] } )
#  for host in sortedbyip[ip]['id_resp_h']:
#    sortedbyport[ip][host] = filter_on_index(sortedbyip[ip]['id_resp_h'][host], { "*" : ["id_resp_p"] } )


# Next we replace all hostnames which have a DNS mapping
dnsmapped = {}
for ip in sortedbyport:
  dnsmapped[ip] = {}
  for host in sortedbyport[ip]:
    requests_to_host = sortedbyport[ip][host]
    if host in firstindexing["dns.log"]["answers"]:
      key = firstindexing["dns.log"]["answers"][host][0]['query']
      dnsmapped[ip][key] = requests_to_host
    else:
      dnsmapped[ip][host] = requests_to_host

outp = {
  "devices_hosts_ports" : sortedbyport,
  "dns": firstindexing["dns.log"]["answers"],
  "dnsmapped" : dnsmapped
}

with open(OUTPUTDIR + '/blob.json', 'w') as fp:
  json.dump(outp, fp, default=str)










print('Python finished')

