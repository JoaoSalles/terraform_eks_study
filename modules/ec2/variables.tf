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

variable "vpc_id" {
  type = string
}