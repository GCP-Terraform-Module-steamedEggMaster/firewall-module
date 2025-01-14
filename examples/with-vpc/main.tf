module "vpc" {
  source = "git::https://github.com/GCP-Terraform-Module-steamedEggMaster/vpc-module.git?ref=v1.0.0"

  name = "test-vpc"
}

module "firewall" {
  source = "../../"

  name    = "test-ssh-firewall"
  network = module.vpc.self_link

  source_ranges = ["0.0.0.0/0"]

  allow = [
    {
      protocol = "tcp"
      ports    = ["22"]
    }
  ]
}