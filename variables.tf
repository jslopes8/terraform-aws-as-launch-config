variable "lc_name" {
    type = string
}
variable "image_id" {
    type = string
}
variable "security_groups" {
    type    = list
    default = []
}
variable "iam_instance_profile" {
    type    = string
    default = " "
}
variable "instance_type" {
    type    = string
    default = " "
}
variable "key_name" {
    type = string
}
variable "user_data" {
    type = string
}
variable "root_block_device" {
    type    = list(map(string))
}
variable "ebs_block_device" {
    type    = list(map(string))
    default = []
}
variable "enable_monitoring" {
    type    = bool
    default = "true"
}
variable "ebs_optimized" {
    type    = bool
    default = "true"
}
variable "associate_public_ip_address" {
    type    = bool
    default = "false"
}
