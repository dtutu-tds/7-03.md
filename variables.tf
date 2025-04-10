variable "yc_cloud_id" {
  type        = string
  description = "b1gmdn70g06hoq9n9f7c
}
variable "yc_folder_id" {
  type        = string
  description = " b1g6vssliphgjfnbo6ek"
}
variable "service_account_key_file" {
  type        = string
  default     = "./terraform-key.json"
  description = "Путь к JSON-файлу серв. аккаунта"
}
variable "public_ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Путь к публичному SSH-ключу, который будет прописан на ВМ"
}
