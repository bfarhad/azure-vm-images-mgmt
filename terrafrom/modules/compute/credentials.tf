# modules/compute/credentials.tf
resource "tls_private_key" "ssh" {
  count     = lower(var.os_type) == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "admin_password" {
  count   = lower(var.os_type) == "windows" ? 1 : 0
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  count        = lower(var.os_type) == "linux" ? 1 : 0
  name         = "ssh-private-key"
  value        = tls_private_key.ssh[0].private_key_pem
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "admin_password" {
  count        = lower(var.os_type) == "windows" ? 1 : 0
  name         = "admin-password"
  value        = random_password.admin_password[0].result
  key_vault_id = var.key_vault_id
}