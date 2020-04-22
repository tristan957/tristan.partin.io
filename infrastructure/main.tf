variable "token" {
  description = "Linode API access token"
}

variable "root-password" {
  description = "Root password for a linode instance"
}

provider "linode" {
  token = var.token
}

resource "linode_sshkey" "c3po" {
  label   = "c3po"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}

resource "linode_sshkey" "builds-sr-ht" {
  label   = "builds-sr-ht"
  ssh_key = chomp(file("~/.ssh/builds-sr-ht.pub"))
}

resource "linode_instance" "personal-server" {
  label           = "personal-server"
  image           = "linode/ubuntu18.04"
  region          = "us-central"
  type            = "g6-standard-1"
  authorized_keys = ["${linode_sshkey.c3po.ssh_key}", "${linode_sshkey.builds-sr-ht.ssh_key}"]
  root_pass       = var.root-password
  group           = "personal"
  tags            = ["personal"]
  swap_size       = 256
  private_ip      = false

  alerts {
    cpu            = 75
    network_in     = 50
    network_out    = 50
    io             = 1000
    transfer_quota = 80
  }

  backups_enabled  = false
  watchdog_enabled = false
}
