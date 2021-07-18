############################## Common variables ####################
variable "vpc_id" {
  type = string
  default = "VPC id for this infrastructure"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags for all the resources created"
}
####################################################################
############################## Load Balancer variables #############
variable "application_subnets" {
  type = list(string)
  description = "List of subnets id for the application load balancer (application layer)"
}

variable "public_subnets" {
  type = list(string)
  description = "List of subnets id for the public load balancer (public layer)"
}
#####################################################################
################## Listener variables ###############################
variable "public_listener_protocol" {
  type = string
  default = "HTTP"
  description = "Protocol for the \"forward\" rule of the public layer listener."
}

variable "public_listener_port" {
  type = number
  default = 80
  description = "Port for the \"forward\" rule of the public layer listener."
}

variable "application_listener_port" {
  type = number
  default = 80
  description = "Port for the \"forward\" rule of the application layer listener."
}

variable "application_listener_protocol" {
  type = number
  default = "TCP"
  description = "Protocol for the \"forward\" rule of the application layer listener."
}

######################################################################
################## Target group variables ############################
