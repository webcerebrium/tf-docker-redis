resource "local_file" "redis_flushall" {
  count        = var.enabled ? 1 : 0
   content = <<EOF
#!/usr/bin/env bash
set -ex
docker exec -it redis-${local.postfix} redis-cli flushall

EOF
   filename = "./bin/redis-flushall.sh"
   file_permission = "0777"
}
