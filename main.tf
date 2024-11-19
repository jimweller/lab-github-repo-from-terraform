# the github source=integrations/github needs to be both in the instance AND in
# the module weird bugs from when github tookover the provider from hashi
# https://github.com/integrations/terraform-provider-github/issues/652
# https://github.com/integrations/terraform-provider-github/issues/662
# https://github.com/integrations/terraform-provider-github/issues/696
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  owner="ExampleCo"
}


module "ymlA" {
  source  = "levmel/yaml_json/multidecoder"
  version = "0.2.3"
  filepaths = ["repos.yml"]
}

locals {
  reponames = {for k,v in module.ymlA.files.repos.github-repositories : v.name => v  }
}

module "github-repo" {
  for_each = local.reponames
  source = "./modules"
  name = each.value.name
  description = each.value.description
}
