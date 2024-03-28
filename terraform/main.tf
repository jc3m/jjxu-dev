terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider aws {
  region = "us-east-2"
}

provider aws {
  alias = "us-east-1"
  region = "us-east-1"
}