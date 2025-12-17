# Phase 3 & 4 Setup Guide

## Phase 3: Container Registry Setup (AWS ECR)

### Prerequisites
- AWS Account with ECR permissions
- AWS CLI installed and configured
- Terraform installed

### Step 1: Configure AWS Credentials

```bash
# Configure AWS CLI
aws configure
```

Enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region: `us-east-1`
- Default output format: `json`

### Step 2: Deploy ECR Repositories

```bash
cd infra/registry

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

### Step 3: Save Outputs

After `terraform apply`, save these outputs:

```bash
# Get repository URLs
terraform output backend_repository_url
terraform output frontend_repository_url

# Get ECR login command
terraform output -raw ecr_login_command
```

Example outputs:
```
backend_repository_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-backend"
frontend_repository_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-frontend"
```

### Step 4: Test Docker Login

```bash
# Use the login command from outputs
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  123456789012.dkr.ecr.us-east-1.amazonaws.com
```

## Phase 4: CI Pipeline Setup

### Step 1: Fork the Application Repository

1. Go to https://github.com/NoahGallo/devops-workshop-app
2. Click "Fork" button
3. Clone your fork locally:

```bash
cd ..  # Go back to workshop root
git clone https://github.com/YOUR_USERNAME/devops-workshop-app.git app
cd app
```

### Step 2: Copy GitHub Actions Workflows

Copy the workflow files from `.github/workflows/` in the main workshop directory to your forked app:

```bash
# From the workshop root
cp .github/workflows/backend-ci.yml app/.github/workflows/
cp .github/workflows/frontend-ci.yml app/.github/workflows/
```

### Step 3: Configure GitHub Secrets

Go to your forked repository on GitHub:
1. Click "Settings" → "Secrets and variables" → "Actions"
2. Click "New repository secret"
3. Add these secrets:

| Secret Name | Value | How to Get It |
|-------------|-------|---------------|
| `AWS_ACCESS_KEY_ID` | Your AWS access key | From AWS IAM console |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key | From AWS IAM console |
| `AWS_REGION` | `us-east-1` | Your chosen region |
| `ECR_REGISTRY` | Registry URL | From `terraform output` (just the registry part) |

**Example ECR_REGISTRY value:**
```
123456789012.dkr.ecr.us-east-1.amazonaws.com
```

### Step 4: Trigger CI Pipeline

```bash
cd app

# Make a small change
echo "# CI Test" >> README.md

# Commit and push
git add .
git commit -m "test: trigger CI pipeline"
git push origin main
```

### Step 5: Monitor Pipeline

1. Go to your GitHub repository
2. Click "Actions" tab
3. Watch the workflows run:
   - Backend CI/CD
   - Frontend CI/CD

Expected steps:
- ✅ Lint code
- ✅ Run tests
- ✅ Build Docker image
- ✅ Push to ECR
- ✅ Security scan

## Verification

### Check ECR Repositories

```bash
# List images in backend repo
aws ecr list-images \
  --repository-name mission-control-backend \
  --region us-east-1

# List images in frontend repo
aws ecr list-images \
  --repository-name mission-control-frontend \
  --region us-east-1
```

### Pull and Test Images

```bash
# Login to ECR
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  123456789012.dkr.ecr.us-east-1.amazonaws.com

# Pull backend image
docker pull 123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-backend:latest

# Pull frontend image
docker pull 123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-frontend:latest

# Run locally to test
docker run -p 8000:8000 123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-backend:latest
docker run -p 3000:80 123456789012.dkr.ecr.us-east-1.amazonaws.com/mission-control-frontend:latest
```

## Troubleshooting

### AWS Credentials Issues

```bash
# Verify AWS credentials
aws sts get-caller-identity

# Check ECR permissions
aws ecr describe-repositories --region us-east-1
```

### GitHub Actions Failures

1. Check workflow logs in GitHub Actions tab
2. Verify all secrets are set correctly
3. Ensure AWS credentials have ECR push permissions
4. Check Dockerfile exists in backend/frontend directories

### ECR Push Denied

If you get "denied: Your authorization token has expired":
```bash
# Re-login to ECR
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  123456789012.dkr.ecr.us-east-1.amazonaws.com
```

## Next Steps

After successful CI/CD setup:
- Phase 5: GitOps with ArgoCD
- Phase 6: Application Deployment
- Phase 7: Monitoring Stack

## Cleanup (Optional)

To remove ECR resources:

```bash
# Delete all images first
aws ecr batch-delete-image \
  --repository-name mission-control-backend \
  --image-ids imageTag=latest \
  --region us-east-1

aws ecr batch-delete-image \
  --repository-name mission-control-frontend \
  --image-ids imageTag=latest \
  --region us-east-1

# Then destroy Terraform resources
cd infra/registry
terraform destroy
```
