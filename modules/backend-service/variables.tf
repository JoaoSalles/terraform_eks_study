variable "prefix" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "lb_target_group_arn" {
  type = string
}

variable "lb_sg_id" {
  type = string
}

variable "sg_public_id" {
  type = string
}


variable "vpc_id" {
  type = string
}

variable "aws_ecs_cluster_id" {
  type = string
}