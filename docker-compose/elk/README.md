# ELK stack

Since I encountered some docker specific problems,
I posted this docker-compose online.

When you get this
[error](https://github.com/docker-library/elasticsearch/issues/111)
message:
"max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]"
run the following on the host machine;
```shell
echo "vm.max_map_count=262144" >> /etc/sysctl.conf # after reboot
sysctl -w vm.max_map_count=262144 # real time
```

## AWS S3 backup

To run the ELK with the S3 snapshot plugin:
`docker-compose -f s3-snap.yml up`

Now go to the Dev Tools tab in the Kibana WebUI
(/app/kibana#/dev_tools).

Now enter something like:

```json
PUT /_snapshot/s3backup?pretty
{
  "type": "s3",
  "settings": {
    "bucket": "elastic-backup",
    "access_key": "AKIA1337SECRET",
    "secret_key": "Please3nterYour5ecretKeyHere",
    "compress": "true",
    "base_path" : "eg_production"
  }
}
```
Now verify that is has been added: `GET /_snapshot/_all`

To see the backups: `GET /_snapshot/s3backup/_all`

More info can be found
[here](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html#_snapshot).
