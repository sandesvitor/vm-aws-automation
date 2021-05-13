terraform {
  backend "remote" {
    organization = "sandesvitor"

    workspaces {
      name = "aws-infrastructure-dixit"
    }
  }
}