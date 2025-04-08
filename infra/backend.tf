terraform {
  backend "azurerm" {
    resource_group_name  = "mi-grupo-recursos"    
    storage_account_name = "mistorage2025santi01" 
    container_name       = "misarchivos"          
    key                  = "terraform.tfstate"    
  }
}
