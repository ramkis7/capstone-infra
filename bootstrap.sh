#!/bin/bash
# Update
yum update -y

# Install dependencies
amazon-linux-extras enable corretto17
yum install -y java-17-amazon-corretto git docker unzip

# Start Docker
systemctl enable --now docker
usermod -aG docker ec2-user
usermod -aG docker jenkins

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install -y jenkins
systemctl enable --now jenkins

# Install SonarQube via Docker
docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create sonarqube_logs

docker run -d --name sonarqube --restart unless-stopped \
  -p 9000:9000 \
  -v sonarqube_data:/opt/sonarqube/data \
  -v sonarqube_extensions:/opt/sonarqube/extensions \
  -v sonarqube_logs:/opt/sonarqube/logs \
  sonarqube:lts-community

# Node.js & Nginx
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
yum install -y nodejs nginx
systemctl enable --now nginx

