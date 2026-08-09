# 🚀 Azure Infrastructure Automation using Terraform & GitHub Actions

## 📌 Project Overview

This project demonstrates how to provision and manage Microsoft Azure infrastructure using **Terraform** with automated CI/CD using **GitHub Actions**.

The project follows an **Environment-based Terraform architecture**, where separate configurations are maintained for:

- Development (`dev`)
- Production (`prod`)

Terraform modules are used to create reusable infrastructure components, while GitHub Actions automates the Terraform workflow.

---

## 🏗️ Architecture

```text
                         Developer
                             |
                             | git push
                             ↓
                    ┌─────────────────┐
                    │ GitHub Repository│
                    └────────┬────────┘
                             |
                             ↓
                    ┌─────────────────┐
                    │ GitHub Actions   │
                    │    Pipeline      │
                    └────────┬────────┘
                             |
                  ┌──────────┴──────────┐
                  ↓                     ↓
              Terraform               Terraform
                 Plan                   Apply
                  |                     |
                  └──────────┬──────────┘
                             ↓
                      Microsoft Azure
                             |
              ┌──────────────┼──────────────┐
              ↓              ↓              ↓
             VNet           NSG             VM
````

---

# 📂 Project Structure

```text
github_action-pipeline/
│
├── .github/
│   └── workflows/
│       ├── blank.yml
│       └── terraform.yml
│
├── environments/
│   │
│   ├── dev/
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── variable.tf
│   │
│   └── prod/
│       ├── main.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variable.tf
│
├── modules/
│
└── README.md
```

---

# 📁 Directory Explanation

## `.github/workflows/`

This directory contains GitHub Actions workflow files.

### `terraform.yml`

This workflow is responsible for automating Terraform operations.

Typical workflow:

```text
Code Push
   ↓
Checkout
   ↓
Azure Login
   ↓
Terraform Init
   ↓
Terraform Format
   ↓
Terraform Validate
   ↓
Terraform Plan
   ↓
Terraform Apply
```

### `blank.yml`

This is a basic/sample GitHub Actions workflow file and can be used for testing or learning purposes.

---

# 🌍 Environments

The project uses separate Terraform configurations for different environments.

```text
environments/
├── dev/
└── prod/
```

This separation helps prevent accidental changes between Development and Production infrastructure.

---

# 🧪 Dev Environment

Location:

```text
environments/dev/
```

Contains:

```text
dev/
├── main.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf
```

### `main.tf`

Contains the Terraform resources or module calls required for the Development environment.

### `provider.tf`

Defines the Azure provider configuration.

### `variable.tf`

Defines variables used by the Development environment.

### `terraform.tfvars`

Contains the values for Development environment variables.

---

# 🚀 Production Environment

Location:

```text
environments/prod/
```

Contains:

```text
prod/
├── main.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf
```

The Production environment is maintained separately from Development to provide better isolation and control.

---

# 🧩 Terraform Modules

The `modules/` directory contains reusable Terraform modules.

Example:

```text
modules/
│
├── resource-group/
├── vnet/
├── subnet/
├── nsg/
├── nic/
└── vm/
```

The exact modules depend on the infrastructure implemented in this project.

### Why use modules?

Terraform modules provide:

* Reusability
* Maintainability
* Standardization
* Scalability
* Cleaner Terraform code
* Environment-independent infrastructure components

---

# 🔄 Deployment Workflow

The expected deployment flow is:

```text
Developer
    |
    | Modify Terraform Code
    ↓
git add .
    |
    ↓
git commit
    |
    ↓
git push
    |
    ↓
GitHub
    |
    ↓
GitHub Actions
    |
    ├── Terraform Init
    ├── Terraform Format
    ├── Terraform Validate
    ├── Terraform Plan
    └── Terraform Apply
    |
    ↓
Azure Infrastructure
```

---

# ⚙️ Terraform Commands

## Development Environment

Go to the Dev directory:

```bash
cd environments/dev
```

Initialize Terraform:

```bash
terraform init
```

Format Terraform files:

```bash
terraform fmt
```

Validate configuration:

```bash
terraform validate
```

Create execution plan:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

---

# 🚀 Production Environment

Go to the Prod directory:

```bash
cd environments/prod
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Create plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

---

# 🔐 Azure Authentication

GitHub Actions requires authentication to Azure before Terraform can create resources.

Recommended approach:

**OIDC / Workload Identity Federation**

Common values required by the GitHub Actions workflow:

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
```

These values should be stored securely in GitHub:

```text
GitHub Repository
       ↓
Settings
       ↓
Secrets and variables
       ↓
Actions
```

Credentials should never be hard-coded in Terraform files.

---

# 🔒 Terraform State

Terraform state contains information about the infrastructure managed by Terraform.

For a production environment, use a **remote backend**, such as Azure Storage Account.

Recommended architecture:

```text
Terraform
    |
    ↓
Azure Storage Account
    |
    └── Terraform State
         |
         ├── Dev State
         └── Prod State
```

Remote state provides:

* Centralized state management
* Team collaboration
* State locking
* Better security
* Reduced risk of state loss

---

# 🔐 Security Best Practices

This project follows these recommended practices:

1. Never hard-code Azure credentials.
2. Use GitHub Secrets or OIDC authentication.
3. Keep Development and Production separate.
4. Use Terraform modules for reusable infrastructure.
5. Store Terraform state remotely.
6. Protect the Production branch.
7. Use Pull Requests for Production changes.
8. Run `terraform plan` before `terraform apply`.
9. Do not commit `.tfstate` files.
10. Do not commit sensitive `.tfvars` files.

---

# 🚫 Recommended `.gitignore`

```gitignore
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
```

> `.terraform.lock.hcl` should normally be committed to Git because it locks Terraform provider versions.

---

# 📊 Environment Comparison

| Environment | Purpose               | Risk Level | Deployment           |
| ----------- | --------------------- | ---------: | -------------------- |
| Dev         | Development & Testing |        Low | Automated            |
| Prod        | Production workloads  |       High | Approval recommended |

---

# 🎯 Project Objectives

This project demonstrates practical knowledge of:

* Microsoft Azure
* Terraform
* Terraform Modules
* Infrastructure as Code
* Git
* GitHub
* GitHub Actions
* CI/CD
* Dev / Prod Environment Management
* Azure Authentication
* Terraform State Management
* DevOps Best Practices

---

# 🔮 Future Improvements

The project can be enhanced with:

* Azure Storage Remote Backend
* OIDC authentication
* Separate GitHub Actions workflows for Dev and Prod
* Pull Request based Terraform Plan
* Production approval
* Terraform security scanning using Checkov
* Infrastructure cost estimation using Infracost
* Terraform state locking
* Azure Monitor integration

---

# 👨‍💻 Author

**Krishna Pal**

DevOps / Cloud Engineer

### Technologies

```text
Azure
Terraform
Git
GitHub
GitHub Actions
Linux
Docker
Kubernetes
CI/CD
Infrastructure as Code
```

---

## ⭐ Conclusion

This project demonstrates how Terraform can be integrated with GitHub Actions to automate Azure infrastructure deployment while maintaining separate **Development and Production environments** and reusable Terraform modules.

```

### Ek important point bhai

Tumhare screenshot ke according **actual `main.tf` aur module files ka content mujhe nahi dikh raha**, sirf folder structure dikh raha hai. Isliye upar README tumhare **structure ke exactly according** hai, lekin Azure me exactly kaunse resources create ho rahe hain woh maine assume nahi kiya hai.

Agar tum **poora project ZIP upload** kar do, main uske actual code ko read karke **100% exact README.md** bana sakta hoon—jisme actual resources, modules, variables, Dev/Prod flow aur `terraform.yml` ka exact workflow explain hoga.
```
