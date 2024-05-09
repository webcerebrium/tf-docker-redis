resource "docker_image" "redis" {
  name         = "redis"
  count        = var.enabled ? 1 : 0
  keep_locally = true
}