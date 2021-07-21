############################## Common variables ####################
variable "vpc_id" {
  type    = string
  default = "VPC id for this infrastructure"
}

variable "ssh_sources" {
  type        = list(string)
  description = "IP allowed to reach the EC2 using SSH"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "Public (Web server) subnets cidr"
}

variable "data_subnets_cidr" {
  type        = list(string)
  description = "Data subnets cidr"
}

variable "application_subnets_cidr" {
  type        = list(string)
  description = "Application subnets cidr"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for all the resources created"
}
####################################################################
############################## Load Balancer variables #############
variable "application_subnets" {
  type        = list(string)
  description = "List of subnets id for the application load balancer (application layer)"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of subnets id for the public load balancer (public layer)"
}
#####################################################################
################## Listener and Target Group variables ###############################
variable "public_listener_protocol" {
  type        = string
  default     = "HTTP"
  description = "Protocol for the \"forward\" rule of the public layer listener."
}

variable "public_listener_port" {
  type        = number
  default     = 80
  description = "Port for the \"forward\" rule of the public layer listener."
}

variable "application_listener_port" {
  type        = number
  default     = 80
  description = "Port for the \"forward\" rule of the application layer listener."
}

variable "application_listener_protocol" {
  type        = string
  default     = "TCP"
  description = "Protocol for the \"forward\" rule of the application layer listener."
}

variable "data_listener_port" {
  type        = number
  default     = 27017
  description = "Port for the \"forward\" rule of the database layer listener."
}

variable "data_listener_protocol" {
  type        = string
  default     = "TCP"
  description = "Protocol for the \"forward\" rule of the database layer listener."
}
######################################################################
################## Autoscaling group variables ############################
variable "app_server_max" {
  type        = number
  default     = 2
  description = "Max scale out for the app server"
}
variable "app_server_min" {
  type        = number
  default     = 1
  description = "Min scale in for app server"
}
variable "app_server_desired" {
  type        = number
  default     = 1
  description = "Desired capacity for app server"
}
variable "app_server_cooldown" {
  type        = number
  default     = 300
  description = "Cooldown period for app server"
}
variable "app_server_subnets" {
  type        = list(string)
  description = "Subnets for the application server"
}

variable "web_server_max" {
  type        = number
  default     = 2
  description = "Max scale out for the web server"
}
variable "web_server_min" {
  type        = number
  default     = 1
  description = "Min scale in for the web server"
}
variable "web_server_desired" {
  type        = number
  default     = 1
  description = "Desired capacity for the web server"
}
variable "web_server_subnets" {
  type        = list(string)
  description = "Subnets for the web server"
}
variable "web_server_cooldown" {
  type        = number
  default     = 300
  description = "Cooldown period for web server"
}

variable "db_replicas" {
  type        = number
  default     = 3
  description = "Number of replicas for the db server"
}

variable "db_cooldown" {
  type        = number
  default     = 300
  description = "Cooldown period for db server"
}

variable "data_subnets" {
  type        = list(string)
  description = "Subnets for the database server"
}
###################################################################################
########################### Launch Template variables #############################
variable "app_server_instance_size" {
  type        = string
  default     = "t3.micro"
  description = "Instanze size for the application server"
}

variable "app_server_ami" {
  type        = string
  default     = "ami-0737455407c1986d6" # amazon linux 2 in eu-south-1
  description = "AMI for the application server"
}

variable "web_server_instance_size" {
  type        = string
  default     = "t3.micro"
  description = "Instanze size for the web server"
}

variable "web_server_ami" {
  type        = string
  default     = "ami-0737455407c1986d6" # amazon linux 2 in eu-south-1
  description = "AMI for the web server"
}

variable "data_instance_size" {
  type        = string
  default     = "t3.micro"
  description = "Instanze size for the db server"
}

variable "data_ami" {
  type        = string
  default     = "ami-0737455407c1986d6" # amazon linux 2 in eu-south-1
  description = "AMI for the db server"
}