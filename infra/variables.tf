############################## Common variables ####################
variable "vpc_id" {
  type    = string
  default = "VPC id for this infrastructure"
}

variable "ssh_sources" {
  type        = list(string)
  description = "IP allowed to reach the EC2 using SSH"
}

variable "subnets_cidr" {
  type        = list(string)
  description = "Public (Web server) subnets cidr"
}

variable "external_traffic_cidrs" {
  type        = list(string)
  description = "CIDR allowed for egress rule"
}

variable "ingress_traffic_cidrs" {
  type        = list(string)
  description = "CIDRs that can reach the web server"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for all the resources created"
}

variable "ssh_pubkey" {
  type        = string
  description = "SSH public key for the EC2 instances the ASGs will create"
}

####################################################################
############################## Load Balancer variables #############
variable "public_subnets" {
  type        = list(string)
  description = "List of subnets id for the public load balancer (public layer)"
}
######################################################################################
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

######################################################################################
############################ Instance variables ######################################
variable "extra_sg_id" {
  type        = list(string)
  default     = []
  description = "IDs of extra security group to be attached to the server"
}

variable "associate_public_ip" {
  type        = bool
  default     = true
  description = "Whether to attach or not a public IP address to the EC2"
}

variable "instance_size" {
  type        = string
  default     = "t2.micro"
  description = "Size of the server"
}

variable "ami" {
  type        = string
  default     = "ami-00f22f6155d6d92c5" # amazon linux 2 in eu-centra-1
  description = "AMI for the servers"
}

variable "ec2_cidr_az_mapping" {
  type        = map(string)
  description = "Mappings az -> cidr for the servers"
}

variable "db_port" {
  type        = number
  default     = 27017
  description = "DB port"
}

variable "db_allowed_cidr" {
  type = list(string)
  description = "CIDR allowed to communicate with DB"
}

variable "application_listener_port" {
  type        = number
  default     = 8080
  description = "Application port"
}

variable "application_allowed_cidrs" {
  type = list(string)
  description = "CIDR allowed to communicate with the application"
}