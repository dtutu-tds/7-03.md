terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 1.0.0"
}

provider "yandex" {
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"

  # используем сервисный аккаунт и ключ:
  service_account_key_file = /home/tds/terraform-key.json
  
