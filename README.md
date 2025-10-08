# 🚀 Capstone Project: Multi-Stage DevOps Pipeline for Node.js Application

### 📝 Project Title: Capstone DevOps Pipeline for Node.js Application

This project demonstrates the implementation of a **complete DevOps CI/CD pipeline** for a simple Node.js application.  
It covers key DevOps practices including:

- 🧱 **Infrastructure as Code (IaC)** using Terraform  
- 🔁 **Continuous Integration & Continuous Delivery (CI/CD)** with Jenkins  
- 🧪 **Code Quality Analysis** using SonarQube  
- 🐳 **Containerization** using Docker  
- ☸️ **Container Orchestration** using Kubernetes (Minikube)  

The entire flow — from code commit to deployment — is automated using **Jenkins**.

---

## 📌 1. Architecture Overview

The pipeline follows a **GitOps workflow**, where a code change in GitHub triggers a multi-stage Jenkins pipeline.

### 🖼️ Architecture Diagram

Developer → GitHub → Webhook → Jenkins → SonarQube → Docker → Kubernetes (Minikube)



**Pipeline Flow:**

1. 👨‍💻 **Developer** pushes code to **GitHub**.  
2. 🌐 A **Webhook** triggers the Jenkins pipeline.  
3. 🧰 **Jenkins** clones the code and runs **SonarQube Analysis**.  
4. 🧪 **SonarQube** checks code against a **Quality Gate**.  
5. ✅ If the Quality Gate passes, Jenkins builds a **Docker Image**.  
6. ☸️ The image is deployed to a **Minikube** Kubernetes cluster and exposed via a **Service**.

---

## 🏗️ 2. Infrastructure as Code (IaC)

All infrastructure is provisioned on **AWS EC2** using **Terraform**.

**Key Files:**

- `main.tf` – Provisions the EC2 instance, security groups, and SSH key pair.  
- `bootstrap.sh` – Bootstraps the environment by installing and configuring:
  - Jenkins
  - Docker
  - SonarQube (via Docker)
  - Node.js

---

## 🧪 3. Application & Jenkins Pipeline

The application is a simple **Node.js web server**.  
The Jenkins pipeline is defined in a `Jenkinsfile` and includes multiple stages:

| Stage                  | Description |
|-------------------------|-------------|
| **Checkout**           | Clones the latest code from the GitHub repository. |
| **SonarQube Analysis** | Runs code quality & security checks using SonarQube Scanner. |
| **Quality Gate**       | Pauses to fetch SonarQube results. Aborts if Quality Gate fails. |
| **Build Docker Image** | Builds a Docker image using the `Dockerfile` and tags it with the Jenkins build number and `latest`. |
| **Deploy Container**   | Deploys the new Docker container by removing any existing container and mapping host port `80` to container port `3000`. |

---

## 🧰 4. Demonstration

### ❌ Initial Pipeline Run (Failure)

- A **deliberate vulnerability** was added to `index.js` (hardcoded secret & code duplication).  
- The pipeline was triggered, and **SonarQube** successfully detected the issues.  
- The **Quality Gate** failed, causing the pipeline to abort.  
- Jenkins console logs clearly showed the failure at the quality check stage.

---

### ✅ Final Pipeline Run (Success)

- Vulnerabilities in `index.js` were fixed.  
- A new pipeline run was triggered automatically.  
- **SonarQube Analysis** passed with a clean report.  
- **Quality Gate** passed successfully.  
- Jenkins built the Docker image and deployed it to Minikube.  
- Final build status: **`SUCCESS`** ✅  
- The application became accessible via the **EC2 instance’s public IP**.

---

## 🧹 5. Resource Management & Cleanup

To avoid unnecessary AWS costs, **terminate the EC2 instance** when not in use.

```bash
# To provision infrastructure
terraform apply

# To destroy and clean up
terraform destroy



📚 Tech Stack

Cloud: AWS EC2

IaC: Terraform

CI/CD: Jenkins

Code Quality: SonarQube

Containerization: Docker

Orchestration: Minikube (Kubernetes)

Application: Node.js



🙌 Acknowledgements

This project was developed as part of a Capstone Project to demonstrate real-world DevOps practices and end-to-end automation.

🧭 Future Enhancements

Add automated unit tests for CI stage

Push Docker images to a remote registry (e.g., Docker Hub or ECR)

Use Helm charts for Kubernetes deployment

Configure HTTPS with Ingress controller

✨ Author: Ramki
📅 Date: 8th October 2025



