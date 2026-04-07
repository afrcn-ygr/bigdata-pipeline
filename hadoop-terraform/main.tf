# Configure Terraform settings
terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Create network for Hadoop services
resource "docker_network" "hadoop_network" {
  name   = "hadoop-network"
  driver = "bridge"
}

# Pull Hadoop base image
resource "docker_image" "hadoop" {
  name         = "bde2020/hadoop-namenode:2.0.0-hadoop3.2.1-java8"
  keep_locally = true
}

# HDFS NameNode container
resource "docker_container" "namenode" {
  name  = "hadoop-namenode"
  image = docker_image.hadoop.name
  networks_advanced {
    name = docker_network.hadoop_network.name
  }
  ports {
    internal = 9870
    external = 9870
  }
  ports {
    internal = 9000
    external = 9000
  }
  env = [
    "CLUSTER_NAME=test-cluster"
  ]
  volumes {
    container_path = "/hadoop/dfs/name"
    volume_name    = "namenode-data"
  }
}

# DataNode container
resource "docker_container" "datanode" {
  name  = "hadoop-datanode"
  image = "bde2020/hadoop-datanode:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_network.name
  }
  env = [
    "CLUSTER_NAME=test-cluster"
  ]
  volumes {
    container_path = "/hadoop/dfs/data"
    volume_name    = "datanode-data"
  }
  depends_on = [docker_container.namenode]
}

# ResourceManager for YARN
resource "docker_container" "resourcemanager" {
  name  = "hadoop-resourcemanager"
  image = "bde2020/hadoop-resourcemanager:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_network.name
  }
  ports {
    internal = 8088
    external = 8088
  }
  depends_on = [docker_container.namenode]
}

# NodeManager container
resource "docker_container" "nodemanager" {
  name  = "hadoop-nodemanager"
  image = "bde2020/hadoop-nodemanager:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_network.name
  }
  depends_on = [docker_container.resourcemanager]
}

# Hive Metastore container
resource "docker_container" "hive" {
  name  = "hive-metastore"
  image = "bde2020/hive:2.3.2-postgresql-metastore"
  networks_advanced {
    name = docker_network.hadoop_network.name
  }
  ports {
    internal = 10000
    external = 10000
  }
  env = [
    "HIVE_SITE_CONF_javax_jdo_option_ConnectionURL=jdbc:postgresql://hive-metastore-postgresql/metastore",
    "SERVICE_NAME=metastore"
  ]
  depends_on = [docker_container.namenode]
}