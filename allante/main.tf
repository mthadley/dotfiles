provider "digitalocean" {}

resource "digitalocean_project" "allante" {
  name = "Allante"
  description = "A cloud development environment"
  purpose = "development"
  environment = "Development"
  resources = [digitalocean_droplet.engine.urn]
}

resource "digitalocean_droplet" "engine" {
  name = "allante"
  image = "ubuntu-20-04-x64"
  region = "sfo2"
  size = "s-1vcpu-1gb"
  user_data = file("${path.module}/cloud-init.yaml")
}

output "ip_addr" {
  value = digitalocean_droplet.engine.ipv4_address
  description = "Ip address of the new droplet"
}
