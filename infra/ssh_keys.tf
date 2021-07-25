# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "default" {
  key_name   = "${lookup(var.tags, "Project", "")}WebServer"
  public_key = var.ssh_pubkey
}