resource "digitalocean_kubernetes_cluster" "sandboxk8s" {
  name     = var.project_name
  region   = var.region
  vpc_uuid = digitalocean_vpc.sandboxk8s.id
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.24.4-do.0"

  node_pool {
    name = "sandbox-worker-pool"
    size = "s-2vcpu-2gb"
    # size       = "s-2vcpu-4gb-amd"
    node_count = 3

    taint {
      key    = "workloadKind"
      value  = "database"
      effect = "NoSchedule"
    }
  }
}

output "endpoint" {
  value = digitalocean_kubernetes_cluster.sandboxk8s.id
}

output "cluster_ca_certificate" {
  sensitive = true
  value = digitalocean_kubernetes_cluster.sandboxk8s.kube_config[0].raw_config
}
