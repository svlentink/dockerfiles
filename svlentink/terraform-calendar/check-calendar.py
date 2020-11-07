#!/usr/bin/env python3

from icalevents.icalevents import events
from datetime import datetime
from sys import argv

if len(argv) < 3:
  exampleurl = 'https://calendar.google.com/calendar/ical/REDACTED%40group.calendar.google.com/private-REDACTED/basic.ics'
  print('USAGE:',argv[0],'/output.file',exampleurl,'optional_default_value')
  print('      Either Google or Icloud calendar link.')
  print('      The URL on Google Calendar is called; "Secret address in iCal format"')
  exit(1)
else:
  path = argv[1]
  URL = argv[2]
if len(argv) > 3:
  default = argv[3]
else:
  default = 0

if '.icloud.com' in URL:
  print('Using an Icloud calendar')
  kwargs={"fix_apple":True}
elif 'google.com' in URL:
  print('Using a Google calender')
  kwargs={}
else:
  print('ERROR use either Google or Icloud calendar')
  exit(1)

es  = events(URL,**kwargs)
now = datetime.now()
for e in es:
  # use string comparison, otherwise;
  # TypeError: can't compare offset-naive and offset-aware datetimes
  if str(e.start) < str(now) < str(e.end):
    val = e.summary
    with open(path, 'w') as f:
      f.write(val)
    print('Value set to',val)
    exit()

print('Nothing found, using default',default)
with open(path, 'w') as f:
  f.write(str(default))

