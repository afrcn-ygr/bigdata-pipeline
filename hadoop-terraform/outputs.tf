output "namenode_ui_url" {
  description = "HDFS NameNode Web UI URL"
  value       = "http://localhost:9870"
}

output "resourcemanager_ui_url" {
  description = "YARN ResourceManager Web UI URL"
  value       = "http://localhost:8088"
}

output "hive_server_port" {
  description = "Hive Server2 port"
  value       = "localhost:10000"
}

output "namenode_container_name" {
  value = docker_container.namenode.name
}