#!/bin/sh
set -v

if [ ! -f /bin/terraform ]; then
  echo 'This should be run inside the hashicorp/terraform:light container'
  echo 'see https://github.com/hashicorp/terraform/blob/d4ac68423c4998279f33404db46809d27a5c2362/scripts/docker-release/Dockerfile-release'
  exit 1
else
  terraform=/bin/terraform
fi

if [ -z "$CALENDAR_URL" ]; then
  echo "ERROR: CALENDAR_URL not set"
  exit 1
fi

# Debug info
date
pwd
ls -al

/check-calendar.py /tmp/state.txt "$CALENDAR_URL"

if [ ! -f /tmp/state.txt ]; then
  echo "ERROR: Python failed, is the calendar available and do we have internet?"
  exit 1
fi
if grep -q ^0 /tmp/state.txt; then
  ACTION='destroy'
else
  ACTION='apply'
fi

terraform init
terraform "$ACTION" -refresh=true -input=false -auto-approve

