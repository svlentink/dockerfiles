FROM svlentink/installatron

RUN ./installatron-server.sh -f \
  --db-host=db \
  --db-user=testing \
  --db-pass=$ITRON_DBPWD \
  --db-name=$ITRON_DBNAME \
  --key PASTE_YOUR_KEY_HERE
WORKDIR /usr/local/installatron/

ENTRYPOINT ["/usr/local/installatron/installatron"]
