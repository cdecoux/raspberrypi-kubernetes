terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}