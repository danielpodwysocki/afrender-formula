variable "ami_name" {
  type    = string
  default = "afrender"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

#ami ID for Debian 10 Buster, will be different across regions
variable "buster_ami" {
  type    = string
  default = "ami-0245697ee3e07e755"
}


locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


source "amazon-ebs" "afrender" {
  ami_name      = "${var.ami_name} ${local.timestamp}"
  instance_type = "t2.micro"
  region        = "${var.region}"
  source_ami =  "${var.buster_ami}"
  ssh_username = "admin"

}

build {
  sources = ["source.amazon-ebs.afrender"]

  provisioner "file" {
    source = "salt/roots"
    destination = "/home/admin/salt"
  }


  provisioner "file" {
    source = "afrender"
    destination = "/home/admin/salt/formulas/"
 
  }

  provisioner "file"{
      source = "salt/pillar"
      destination = "/home/admin/pillar"

  }
  
  provisioner "shell" {
      script = "apply_formula.sh"
  }
    
}
