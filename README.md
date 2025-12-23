# Full-Stack Node.js API with Automated CI/CD & Monitoring

A professional-grade deployment of a Node.js SQLite API on **AWS**, featuring Infrastructure as Code (IaC), an automated Jenkins pipeline, and a full observability stack.

## Tech Stack

- **Infrastructure:** AWS (EC2, VPC, Security Groups)
- **IaC:** Terraform
- **Automation:** Jenkins (Pipeline-as-Code)
- **Containerization:** Docker & Docker Compose
- **Monitoring:** Prometheus & Grafana
- **Backend:** Node.js, Express, SQLite

---

## System Architecture

1. **Terraform** provisions a `t3.micro` EC2 instance with an expanded 20GB EBS volume.
2. **Jenkins** (running in Docker) triggers on GitHub pushes via Webhooks.
3. **CI/CD Pipeline** builds a fresh Docker image, runs the API, and handles container cleanup.
4. **Prometheus & Node Exporter** track system metrics (CPU, RAM, Disk).
5. **Grafana** visualizes health stats on a real-time dashboard.

---

## Getting Started

### 1. Infrastructure Deployment

Navigate to the terraform directory and initialize the cloud resources:

```bash
cd terraform
terraform init
terraform apply

```

### 2. Monitoring Setup

The monitoring stack is managed via Docker Compose for easy scaling:

```bash
cd ~/prometheus
docker-compose up -d

```

### 3. Pipeline Configuration

- **Jenkins URL:** `http://<EC2_IP>:8080`
- **Webhook:** Set to `http://<EC2_IP>:8080/github-webhook/` in GitHub settings.
- **Pipeline Script:** Points to the `Jenkinsfile` in the repository root.

---

## 📊 Observability

The system is monitored in real-time. Access the dashboards at:

- **Prometheus:** `http://<EC2_IP>:9090` (Data Collection)
- **Grafana:** `http://<EC2_IP>:4000` (Visualization)
- _Note: Use Dashboard ID `1860` for the Node Exporter Full view._

---
