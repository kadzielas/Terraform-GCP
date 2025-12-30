locals {
  prefix = "dev-alc25-"
  labels = {
    environment = "dev"
    project     = "sandbox"
    destination = "github"
  }
  github_roles = {
    "roles/iam.workloadIdentityUser" = true
  }
}
