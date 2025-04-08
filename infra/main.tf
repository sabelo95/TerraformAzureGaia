# Crear un Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Crear una cuenta de almacenamiento
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name 
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    environment = "staging"
  }
}

# Habilitar sitio web estático
resource "azurerm_storage_account_static_website" "static_site" {
  storage_account_id = azurerm_storage_account.storage_account.id

  index_document     = "index.html"
  error_404_document = "404.html"
}

# Subir el archivo index.html como blob
resource "azurerm_storage_blob" "blob" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web" # nombre reservado para sitios web estáticos
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.source_content
}
