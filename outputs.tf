output "bastion_public_ip" {
  value       = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
  description = "Public IP of bastion"
}

output "web_a_private_ip" {
  value = yandex_compute_instance.web_a.network_interface.0.ip_address
}

output "web_b_private_ip" {
  value = yandex_compute_instance.web_b.network_interface.0.ip_address
}

