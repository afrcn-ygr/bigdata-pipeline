variable "hadoop_version" {
  description = "Hadoop version to deploy"
  type        = string
  default     = "3.2.1"
}

variable "network_name" {
  description = "Docker network name for Hadoop"
  type        = string
  default     = "hadoop-network"
}