resource "docker_container" "redis" {
  count   = var.enabled ? 1 : 0
  image   = docker_image.redis[0].image_id
  name    = local.hostname
  restart = "always"

  command = ["redis-server", "--appendonly", "yes"]

  log_opts = var.network_params.log_opts

  dynamic "ports" {
    for_each = local.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  networks_advanced {
    name = local.network_id
  }

  labels {
    label = "project"
    value = local.project
  }

  labels {
    label = "host"
    value = local.hostname
  }

  labels {
    label = "role"
    value = "redis"
  }

  volumes {
    volume_name    = docker_volume.storage.name
    container_path = "/data"
  }
}

