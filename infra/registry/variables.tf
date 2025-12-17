variable "aws_region" {
  description = "AWS region for ECR repositories"
  type        = string
  default     = "us-east-1"
}

variable "backend_repo_name" {
  description = "Name of the backend ECR repository"
  type        = string
  default     = "mission-control-backend"
}

variable "frontend_repo_name" {
  description = "Name of the frontend ECR repository"
  type        = string
  default     = "mission-control-frontend"
}

variable "image_tag_mutability" {
  description = "Tag mutability setting for repositories"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}
