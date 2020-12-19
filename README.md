# dev

a wip environment on aws

currently a vpc with a private subnet with a nat gateway and an instance in

terraform 0.14.3

## requirements

docker

AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY set as env vars

## about

this repo uses a build environment configured via `Dockerfile`

use `make` commands configured in `Makefile` to build infrastructure in a Dockerized environment:

```bash
# open the repo in dockerized environment:
$ make shell
# then run other make commands
$# make apply
$# make destroy
# exit docker
$# exit

```

## setup

one time setup:

*produces S3 bucket and Dynamo Lock Table which manage all other terraform state*

*produces local state file which should be backed up*

*otherwise this is pretty set-and-forget*

```bash
# enter docker env
$ make shell
# initialize state mgmt terraform
$# make state-init
# create state mgmt infra
$# make state-apply

```

## general use

create and destroy vpc architecture:

```bash
# enter docker env
$ make shell
# initialize dev terraform
$# make init
# create dev infra
$# make apply
# destroy dev infra
$# make destroy

```
