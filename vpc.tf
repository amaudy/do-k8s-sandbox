resource "digitalocean_vpc" "sandboxk8s" {
  name   = var.project_name
  region = var.region
}
