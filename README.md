# AWS Networking Infrastructure Setup

## Overview

This project uses **Terraform** to set up a networking infrastructure on **AWS**. The goal is to create a **Virtual Private Cloud (VPC)** with three public and three private subnets, each in a different availability zone within the same region. The setup also includes an **Internet Gateway**, **Route Tables**, and proper routing for both public and private subnets.

## Requirements

- **Terraform**
- An active **AWS** account
- AWS CLI configured with a **dev** and **demo** profile

## Setup

Follow the steps below to set up and deploy the AWS networking infrastructure.

### 1. Clone the repository

Clone the repository to your local machine:

```bash
git clone git@github.com:csye6225cloud-spring25/tf-aws-infra.git

cd tf-aws-infra
```

## Install Terraform

Ensure that you have **Terraform** installed on your machine. If not, follow the installation instructions to install Terraform.

## Initialize Terraform

Initialize the Terraform configuration by running:

```bash
terraform init
```

## Configure AWS Credentials

Make sure your AWS credentials are configured. You can configure them using the AWS CLI:

```bash
aws configure --profile dev
aws configure --profile demo
```

Alternatively, set the environment variables for AWS credentials if you prefer:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Customize Configuration (Optional)

You can customize the variables for VPC, subnets, and region as needed:

- Open the `variables.tf` file to adjust values like the **region**, **VPC name**, **CIDR block**, etc.

## Deploy Infrastructure

Once the configuration is set up, you can deploy the networking infrastructure by running:

```bash
terraform plan
```

Review the changes that Terraform will apply, then execute:

```bash
terraform apply
```

Confirm the action by typing `yes` when prompted.

## View the Infrastructure

After the infrastructure is deployed, you can go to the **AWS Management Console** to view your newly created VPC, subnets, and other networking resources.

## Importing SSL Certificate for Demo Environment

To import the Namecheap SSL certificate for `demo.onerahul.me` into AWS Certificate Manager:

```bash
aws acm import-certificate \
  --certificate fileb://demo_onerahul_me.crt \
  --private-key fileb://demo_onerahul_me.key \
  --certificate-chain fileb://demo_onerahul_me.ca-bundle \
  --region us-east-1
```
