variable "engine_version" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_ids" {
  type = list(string)
}
