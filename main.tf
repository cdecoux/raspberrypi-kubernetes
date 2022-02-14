terraform {
  // Store state on the Kubernetes Cluster.
  backend "kubernetes" {
    secret_suffix    = "tf-state"
    config_path      = "~/.kube/config-pi"
  }
}

// Init Providers, use config-pi (See Makefile)
provider "kubernetes" {
  config_path    = "~/.kube/config-pi"
  config_context = "default"
}

provider "helm" {
    kubernetes {
        config_path    = "~/.kube/config-pi"
        config_context = "default"
    }
}

// Init Module for Cluster Stack
module "cluster" {
    source = "./terraform"
    prometheus_config = {
        prometheus = {
            enabled = true

            prometheusSpec = {
                // Set Data Retention (Sets limits on both age and storage)
                retention = "14d"
                retentionSize = "10GB"

                // Set resource constraints for prometheus
#                resources = {
#                    requests = {
#                        cpu = "50m"
#                        memory = "200Mi"
#                    }
#                    limits = {
#                        cpu = "50m"
#                        memory = "400Mi"
#                    }
#                }
            }
        }
    }
}