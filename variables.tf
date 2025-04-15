variable "yc_cloud_id" {
  type        = string
  default     = "b1gmdn70g06hoq9n9f7c"
  description = "ID облака Yandex Cloud"
}

variable "yc_folder_id" {
  type        = string
  default     = "b1g6vssliphgjfnbo6ek"
  description = "ID папки Yandex Cloud"
}

variable "service_account_key_file" {
  type        = string
  default     = "/home/tds/terraform-key.json"
  description = "Путь к JSON-файлу сервисного аккаунта"
}

variable "public_ssh_key_path" {
  default = "/home/tds/.ssh/yandex_id_rsa.pub"
}