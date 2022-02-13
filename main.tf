terraform {
  backend "kubernetes" {
    secret_suffix    = "tf-state"
    config_path      = "~/.kube/config-pi"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config-pi"
  config_context = "default"
}


module "cluster" {
    source = "./terraform"
}