#!/bin/bash

# Change to the working directory
cd $(System.DefaultWorkingDirectory)/terraform

# Initialize Terraform
terraform init

# Create a plan file
terraform plan -out=tfplan

# Apply the plan
terraform apply -auto-approve tfplan
