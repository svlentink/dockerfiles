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
