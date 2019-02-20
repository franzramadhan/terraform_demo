NAME=terraform_demo
TF_VERSION=v0.11.11
TF_DIR=terraform
TF_STATE_FILE=terraform.tfstate
TF_VARS_FILE=terraform.tfvars
TF_OUTPUT_FILE=output.txt

init:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform init -force-copy $(TF_DIR)/$$providers/;done

remote_state_plan:
	TF_DATA_DIR=$(TF_DIR)/state/.terraform terraform plan -state=$(TF_DIR)/state/$(TF_STATE_FILE) $(TF_DIR)/state/

remote_state_apply:
	TF_DATA_DIR=$(TF_DIR)/state/.terraform terraform apply --auto-approve -state=$(TF_DIR)/state/$(TF_STATE_FILE) --var-file=$(TF_DIR)/state/$(TF_VARS_FILE) $(TF_DIR)/state/

plan:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform plan -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done

apply:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform apply --auto-approve -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done

destroy:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform destroy --auto-approve -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done;rm -f $(TF_OUTPUT_FILE);

init_all: init

plan_all:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform plan -var-file=$(TF_DIR)/$$providers/$(TF_VARS_FILE) -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done

apply_all:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform apply --auto-approve -var-file=$(TF_DIR)/$$providers/$(TF_VARS_FILE) -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done

destroy_all:
	for providers in `ls $(TF_DIR)`; do TF_DATA_DIR=$(TF_DIR)/$$providers/.terraform terraform destroy --auto-approve -var-file=$(TF_DIR)/$$providers/$(TF_VARS_FILE) -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) $(TF_DIR)/$$providers;done;rm -f $(TF_OUTPUT_FILE);

output_all:
	true > $(TF_OUTPUT_FILE); for providers in `ls $(TF_DIR)`; do terraform output -state=$(TF_DIR)/$$providers/$(TF_STATE_FILE) | tee -a $(TF_OUTPUT_FILE);done

output: output_all

test: init remote_state_plan remote_state_apply plan