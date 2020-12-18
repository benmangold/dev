export AWS_DEFAULT_REGION=us-east-2

# vpc with a private subnet

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
