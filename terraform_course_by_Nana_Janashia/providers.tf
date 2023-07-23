terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }

    linode = {
      source  = "linode/linode"
      version = "2.5.2"
    }
  }
}
