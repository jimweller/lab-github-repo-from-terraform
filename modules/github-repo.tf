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

variable "name" {
  type = string
}

variable "description" {
  type = string
}

resource "github_repository" "example" {
  name        = var.name
  description = var.description


  auto_init                   = true
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  # archived                    = false
  # default_branch              = (known after apply)
  # delete_branch_on_merge      = false
  # etag                        = (known after apply)
  # full_name                   = (known after apply)
  # git_clone_url               = (known after apply)
  # html_url                    = (known after apply)
  # http_clone_url              = (known after apply)
  # id                          = (known after apply)
  # merge_commit_message        = "PR_TITLE"
  # merge_commit_title          = "MERGE_MESSAGE"
  # node_id                     = (known after apply)
  # primary_language            = (known after apply)
  # private                     = (known after apply) #overriden by visibility attribute
  # repo_id                     = (known after apply)
  # squash_merge_commit_message = "COMMIT_MESSAGES"
  # squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  # ssh_clone_url               = (known after apply)
  # svn_url                     = (known after apply)
  topics                      = ["team-cloud-enablement","test","ignore"]
  visibility                  = "internal"
  # web_commit_signoff_required = false

  has_issues = true
  has_discussions = false
  has_projects = false
  has_wiki = false

}


resource "github_repository_file" "readme" {
  repository          = github_repository.example.name
  branch              = "main"
  file                = "README.md"
  content             = "# Repo Created by Terraform. Jim Test Ignore."
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}