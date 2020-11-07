# Terraform scheduled via Google or Icloud calendar

This container checks if an event is active at this current moment.
If this is the case, the environment will run with `terraform apply`

Scheduling is done by running this container on an interval.
An example of this in k8s can be found [here](https://github.com/svlentink/myinfra/blob/master/namespaces/dev-machine-job/cron.yml).

