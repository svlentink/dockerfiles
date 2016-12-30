FROM svlentink/installatron

RUN ./installatron-server.sh -f --key PASTE_YOUR_KEY_HERE
WORKDIR /usr/local/installatron/

ENTRYPOINT ["/usr/local/installatron/installatron"]
CMD [ "--db-host=db", \
      "--db-user=$ITRON_DBUSER", \
      "--db-pass=$ITRON_DBPWD", \
      "--db-name=$ITRON_DBNAME" ]
