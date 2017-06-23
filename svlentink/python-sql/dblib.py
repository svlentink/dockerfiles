#!/usr/bin/env python

#specify this line in your own script before importing
#usingMYSQLinsteadOfPOSTGRES = True

if usingMYSQLinsteadOfPOSTGRES:
  import MySQLdb
else:
  import psycopg2
import yaml
from os import getenv

dbconfloc = getenv('DB_CONFIG_LOC') or '/proj/config.yml'
with open(dbconfloc, 'r') as ymlfile:
  global cfg
  cfg = yaml.load(ymlfile)

def db_con():
  "Get DB connection"
  host = cfg['db']['host']
  usr = cfg['db']['user']
  pwd = cfg['db']['password']
  db = cfg['db']['database']
  if usingMYSQLinsteadOfPOSTGRES:
    conn = MySQLdb.connect(host=host,
                           user=usr,
                           passwd=pwd,
                           db=db)
  else:
    conn = psycopg2.connect(host=host,
                            user=usr,
                            password=pwd,
                            database=db)

  return conn

def db_sp(name, args=[]):
  "Run a stored procedure"
  conn = db_con()
  cur = conn.cursor()
  cur.callproc(name, args)
  cur.close()
  conn.commit()
  conn.close()

def db_sql(sql, data=()):
  print('Entering db_sql with:',sql,data)
  conn = db_con()
  cur = conn.cursor()
  cur.execute(sql,data)
  result = []
  # if it is a select statement, we can fetch the results
  if sql[0:6].lower() == 'select':
    result = cur.fetchall()
  cur.close()
  conn.commit()
  conn.close()
  return result
