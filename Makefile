aws-bootstrap:
	cd infrastructure/aws/bootstrap &&\
	terraform init &&\
	terraform plan -var-file=../../../vars.txt &&\
	terraform apply -var-file=../../../vars.txt &&\
	terraform output > ../vars.tfvars

aws-configure:
	cd infrastructure/aws/configure &&\
	terraform init -backend-config=../vars.tfvars  &&\
	terraform plan -var-file=../vars.tfvars &&\
	terraform apply -var-file=../vars.tfvars &&\
	terraform output > ../vars.tfvars

aws-deploy:
	cd infrastructure/aws/deploy &&\
	terraform init -backend-config=../vars.tfvars  &&\
	terraform plan -var-file=../vars.tfvars &&\
	terraform apply -var-file=../vars.tfvars