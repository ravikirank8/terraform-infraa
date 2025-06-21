provider "github" {
  token = "xxxxx"
}

resource "github_repository" "terraform-infra-repo" {
  name        = "terraform-infraa"
  description = "Infrastructure repository managed by Terraform"
  visibility  = "public"
  has_issues  = true
  has_wiki    = true
}

output "repository_clone_url_ssh" {
  value = github_repository.terraform-infra-repo.ssh_clone_url
}

#this empty repo and create a output provide git clone url


#Clone the terraform-infra repository within root in the terminal.

#The public ssh key has already been generated for you at /root/.ssh/id_rsa.pub. Use the SSH URL from the output that you generated in the previous task.
