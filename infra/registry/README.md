# AWS ECR Container Registry

This directory contains Terraform configuration for AWS ECR (Elastic Container Registry) repositories.

## Prerequisites

1. AWS CLI installed and configured
2. AWS credentials with ECR permissions
3. Terraform >= 1.0

## Setup

### 1. Configure AWS Credentials

```bash
# Option 1: Using AWS CLI
aws configure

# Option 2: Using environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Initialize and Apply

```bash
cd infra/registry
terraform init
terraform plan
terraform apply
```

## Created Resources

- `mission-control-backend` - ECR repository for backend Docker images
- `mission-control-frontend` - ECR repository for frontend Docker images
- Lifecycle policies to keep only the last 10 images
- Image scanning enabled on push

## Docker Login

After Terraform apply, use the login command from outputs:

```bash
# Get the login command
terraform output -raw ecr_login_command

# Or manually
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
```

## GitHub Actions Setup

Add these secrets to your GitHub repository:

1. **AWS_ACCESS_KEY_ID** - Your AWS access key
2. **AWS_SECRET_ACCESS_KEY** - Your AWS secret key
3. **ECR_REGISTRY** - From `terraform output backend_repository_url` (just the registry part)
4. **AWS_REGION** - `us-east-1` (or your chosen region)

Example:
```
ECR_REGISTRY=123456789012.dkr.ecr.us-east-1.amazonaws.com
```

## Pushing Images

```bash
# Tag your image
docker tag mission-control-backend:latest \
  ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/mission-control-backend:latest

# Push to ECR
docker push ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/mission-control-backend:latest
```

## Cleanup

```bash
# Delete all images first (ECR repositories must be empty)
aws ecr batch-delete-image \
  --repository-name mission-control-backend \
  --image-ids imageTag=latest

# Then destroy Terraform resources
terraform destroy
```
