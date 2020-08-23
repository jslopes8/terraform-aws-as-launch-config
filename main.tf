## Filter AMI
data "aws_ami" "main" {
    count = var.create ? length(var.choose_ami) : 0

    most_recent = lookup(var.choose_ami[count.index], "most_recent", null)
    owners      = var.choose_ami[count.index]["owners"]

    dynamic "filter" {
        for_each = var.choose_ami[count.index]["filter"]
        content {
            name    = lookup(filter.value, "name", null)
            values  = lookup(filter.value, "values", null)
        }
    }


}
## Launch Configguration
resource "aws_launch_configuration" "main" {
    count = var.create && var.launch_configuration != null ? 1 : 0

    name_prefix                 = var.name
    image_id                    = length(data.aws_ami.main) > 0 ? data.aws_ami.main.0.id : var.image_id
    instance_type               = var.instance_type
    iam_instance_profile        = var.iam_instance_profile
    security_groups             = var.security_groups
    associate_public_ip_address = var.associate_public_ip_address
    enable_monitoring           = var.enable_monitoring
    ebs_optimized               = var.ebs_optimized
    key_name                    = var.key_name
    user_data                   = var.user_data
    spot_price                  = var.spot_price

    dynamic "root_block_device" {
        for_each    = var.root_block_device
        content {
            volume_type             = root_block_device.value.volume_type
            volume_size             = root_block_device.value.volume_size
            delete_on_termination   = root_block_device.value.delete_on_termination
        }
    }

    dynamic "ebs_block_device" {
        for_each    = var.ebs_block_device 
        content {
            device_name             = lookup(ebs_block_device.value, "device_name", null)
            encrypted               = lookup(ebs_block_device.value, "encrypted", null)
            iops                    = lookup(ebs_block_device.value, "iops", null)
            no_device               = lookup(ebs_block_device.value, "no_device", null)
            snapshot_id             = lookup(ebs_block_device.value, "snapshot_id", null)
            volume_type             = lookup(ebs_block_device.value, "volume_type", null)
            volume_size             = lookup(ebs_block_device.value, "volume_size", null)
            delete_on_termination   = lookup(ebs_block_device.value, "delete_on_termination", null)
        }
    }

    # it's recommended to specify create_before_destroy in a lifecycle block
    lifecycle {
        create_before_destroy = "true"
    }
}
#resource "aws_launch_template" "main" {
#    count = var.create && var.launch_template == "true" ? 1 : 0
#    
#    name_prefix = var.lc_name
#    image_id    = lookup(data.aws_ami.main) > 1 ? data.aws_ami.main.0.id :  var.image_id
#    vpc_security_group_ids = var.security_groups
#    instance_type   = var.instance_type
#    kernel_id       = var.kernel_id
#    key_name        = var.key_name
#}