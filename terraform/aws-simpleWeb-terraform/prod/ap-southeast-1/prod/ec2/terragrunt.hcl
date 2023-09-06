include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ec2.hcl"
}


inputs = {
  // qa tag
  ec2-name = "prod"
}