variable "prefix" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "retention_days" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}