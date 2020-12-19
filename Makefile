export AWS_DEFAULT_REGION=us-east-2

# open shell at $PWD in dockerized environment

shell:
	./scripts/docker_shell.sh

# vpc with a private subnet

init: vpc-init

apply: vpc-apply

destroy: vpc-destroy

vpc-init:
	cd tf/vpc/; terraform init;

vpc-apply:
	cd tf/vpc/; terraform apply;

vpc-destroy:
	cd tf/vpc; terraform destroy;

vpc-output:
	cd tf/vpc; terraform output;

# s3 state and dynamoDB lock table

state-init:
	cd tf/state; terraform init;

state-apply:
	cd tf/state; terraform apply;

state-destroy:
	cd tf/state; terraform destroy;
