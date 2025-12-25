# Environment and Project
environment = "dev"
project_name = "azure-vm-images-mgmt"

# Location
location = "West Europe"

# Networking
vnet_cidr = "192.168.1.0/24"
subnet_cidr = "192.168.1.0/27"

# VM Configuration
vm_size = "Standard_B1s"
os_type = "Linux"

# Image Configuration
image_publisher = "Canonical"
image_offer = "UbuntuServer"
image_sku = "22.04-LTS"
image_version = "latest"

# Image Builder
enable_image_builder = true
build_image_name = "java-tomcat-image"
base_image_publisher = "Canonical"
base_image_offer = "UbuntuServer"
base_image_sku = "22.04-LTS"
build_script = <<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y openjdk-11-jdk
  wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
  tar -xzf apache-tomcat-9.0.75.tar.gz
  mv apache-tomcat-9.0.75 /opt/tomcat
  echo "Java and Apache Tomcat installed successfully"
EOF

# Tags
tags = {
  "Project owner" = "bfarhad"
  "region" = "west"
  "cost" = "medium"
  "env" = "dev"
  "Project name" = "azure-vm-images-mgmt"
}