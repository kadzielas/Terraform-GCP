# Terraform-GCP — GCP Sandbox

Repo to recreate GCP infrastructure and improve Terraform skills — with a practical focus on spinning up **sandbox environments quickly** (new projects / “sandboxes” with a repeatable set of resources). :contentReference[oaicite:0]{index=0}

---

## Table of Contents

- [What this repo does](#what-this-repo-does)
- [Repository layout](#repository-layout)
- [Prerequisites](#prerequisites)
- [Authentication](#authentication)
- [Quick start](#quick-start)
- [Configuration](#configuration)
- [Typical workflows](#typical-workflows)
- [Modules](#modules)
- [CI/CD (GitHub Actions)](#cicd-github-actions)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## What this repo does

This repository provides Terraform code intended to act as a **sandbox factory** for Google Cloud Platform:

- Quickly deploy a **new sandbox** with a predictable set of resources.
- Keep the setup **repeatable** (same inputs → same result).
- Encourage reuse via **Terraform modules** and environment composition.

> The exact list of provisioned resources depends on the modules and configuration in `modules/` and `project/`.

---

## Repository layout

Top-level structure:
|
|--.github/workflows/ # GitHub Actions workflows (CI/CD automation)
|
|--modules/ # reusable Terraform modules (building blocks)
|
|--project/ # environment composition / sandbox definitions
|
|--README.md
|
|--LICENSE

## Prerequisites

- **Terraform** (recommended: latest stable)
- **Google Cloud SDK (`gcloud`)** (recommended for local auth)
- A **GCP account** with permissions to create/manage the intended resources
- (If using remote state) access to the chosen backend (e.g., GCS bucket)

---

## Quick start

### Authentication

``` Cloud Shell
gcloud auth application-default login
gcloud config set project <YOUR_GCP_PROJECT_ID>
```

### Deploy infrastructure

```IDE
Comment whole backend.tf file because bucket for state does not exist for now.
```

``` IDE terminal
cd project/<env>

terraform init -var-file="../config/<env>.tfvars"
terraform apply -var-file="../config/<env>.tfvars"
```

```IDE
Uncomment backend.tf and provide correct values to bucket.
Do apply once again.
```

### Destroy infrastructure

```IDE terminal
terraform destroy -var-file="../config/<env>.tfvars"
```
