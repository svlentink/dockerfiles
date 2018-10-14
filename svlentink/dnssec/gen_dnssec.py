#!/usr/bin/env python3

import os
from glob import glob
import subprocess
from shutil import copyfile

outp = os.getenv('GENERATED_FILES_DIR')
keydir = '/keys'
zonefiles = '/zonefiles'
stype = os.getenv('SERVERTYPE').lower()
mip = os.getenv('IPV4MASTER') or '1.2.3.4'
sip = os.getenv('IPV4SLAVE') or mip


if stype not in ['primary','secondary','master','slave']:
  print('Please set SERVERTYPE as env. variable.')
  exit(1)


def gen_key(zone,ksk=False):
  cmd = 'cd ' + keydir + '; dnssec-keygen -n ZONE -a NSEC3RSASHA1 -L 600 '
  if ksk:
    cmd += '-b 4096 -f KSK '
  else:
    cmd += '-b 2048 '
  cmd += zone
  print(cmd)
  subprocess.call(cmd, shell=True)

def zonefile2zonename(zonefile):
  fn = os.path.basename(zonefile)
  zonename = fn[:-4] # filename - 'zone'
  return zonename

def sign_zone(zonefile,zskf):
  print('We let bind do this by itself')
  return
  fn = os.path.basename(zonefile)
  dest = outp + '/' + fn + '.signed'
  cmd = 'dnssec-signzone -A -t -o ' + fn[:-4]
  cmd += '-f ' + dest + ' ' + zonefile
  print(cmd)
  subprocess.call(cmd, shell=True)


def gen_conf(zonefile):
  zonename = zonefile2zonename(zonefile)
  conf = 'zone "' + zonename[:-1] + '" IN {\n'
  conf += 'type ' + stype + ';\n'
  # no manual sigining anymore
  #conf += 'file "' + outp + '/' + fn + '.signed";\n'
  conf += 'file "' + zonefile + '";\n'
  if '.arpa.' not in zonename:
    conf += 'auto-dnssec maintain;\n'
    conf += 'dnssec-update-mode maintain;\n'
    conf += 'dnssec-dnskey-kskonly false;\n'
    conf += 'inline-signing yes;\n'
  if stype in ['master','primary']:
    conf += 'allow-transfer {' + sip + ';};\n'
  if stype in ['secondary','slave']:
    conf += 'masters {' + mip + ';};\nallow-notify {' + mip + ';};\n'
  conf += '};\n'
  return conf

kskf = {}
zskf = {}
for f in glob(keydir + '/K*.key'):
  zone = os.path.basename(f)[1:].split('+')[0]
  if '; This is a key-signing key' in open(f).read():
    kskf[z] = f
  if '; This is a zone-signing key' in open(f).read():
    zskf[z] = f


outpf = outp + '/named.conf'
copyfile('/etc/named.conf',outpf)
#for loop over all .zone files
for f in glob(zonefiles + '/*.zone'):
  conf = gen_conf(f)
  with open(outpf, "a") as dest:
    dest.write(conf)
  zn = zonefile2zonename(f)
  if zn not in kskf:
    gen_key(zn,ksk=True)
  if zn not in zskf:
    gen_key(zn)

print('You need to insert the DS records at your Domain registrar.')
print('from host: dig @127.0.0.1 dnskey example.com | dnssec-dsfromkey -f - example.com')
print('inside container: dnssec-dsfromkey -a SHA-( 1 | 256 ) /keys/Kexample.net.+008+50707.key')
