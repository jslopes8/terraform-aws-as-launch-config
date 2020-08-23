variable "create" {
    type = bool 
    default = true
}
variable "choose_ami" {
    type = any 
    default = []
}
variable "launch_configuration" {
    type = bool 
    default = true
}
variable "name" {
    type = string 
}
variable "image_id" {
    type = string 
    default = null
}
variable "instance_type" {
    type = string 
}
variable "iam_instance_profile" {
    type = string 
    default = null
}
variable "security_groups" {
    type = list 
    default = []
}
variable "key_name" {
    type = string
}
variable "user_data" {
    type = string
}
variable "associate_public_ip_address" {
    type = bool 
    default = false
}
variable "enable_monitoring" {
    type = bool 
    default = false
}
variable "ebs_optimized" {
    type = bool 
    default = false
}
variable "spot_price" {
    type = number 
    default = null
}
variable "root_block_device" {
    type = any 
    default = []
}
variable "ebs_block_device" {
    type = any 
    default = []
}