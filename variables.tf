variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "AMI ID optionnelle. Laisse vide pour sélectionner automatiquement Amazon Linux 2."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "docker_image" {
  description = "Docker image for newsletter app"
  type        = string
  default     = "yacineatmani/newsletter-app:latest"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8000
}
