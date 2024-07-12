terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.112"
    }
  }

  backend "azurerm" {
    resource_group_name  = "devops-ncia-rg-tfstate"
    storage_account_name = "devopsnciatfstate2"
    container_name       = "tfstate-dev"
    key                  = "devops-ncia.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "common" {
  source = "../../modules/common"
  env = var.env
}