# Environment and Project
environment  = "dev"
project_name = "azure-vm-images-mgmt"

# Location
location = "West Europe"

# Networking
vnet_cidr   = "192.168.1.0/24"
subnet_cidr = "192.168.1.0/27"

# VM Configuration
vm_size = "Standard_B1s"
os_type = "Linux"

# Image Configuration
image_publisher = "Canonical"
image_offer     = "UbuntuServer"
image_sku       = "20.04-LTS"
image_version   = "latest"

# Image Builder
enable_image_builder = true
build_image_name     = "java-tomcat-image"
base_image_publisher = "Canonical"
base_image_offer     = "UbuntuServer"
base_image_sku       = "20.04-LTS"
build_script         = <<-EOF
  #!/bin/bash
  echo "Customizing image with Apache Tomcat 10"
  # Update package list
  apt-get update
  # Install OpenJDK
  apt-get install -y openjdk-11-jdk
  # Download and install Apache Tomcat 10
  wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.17/bin/apache-tomcat-10.1.17.tar.gz
  tar -xzf apache-tomcat-10.1.17.tar.gz
  mv apache-tomcat-10.1.17 /opt/tomcat
  # Set environment variables
  echo 'export CATALINA_HOME=/opt/tomcat' >> /etc/profile
  echo 'export PATH=$PATH:$CATALINA_HOME/bin' >> /etc/profile
  # Create a systemd service for Tomcat
  cat > /etc/systemd/system/tomcat.service << EOL
  [Unit]
  Description=Apache Tomcat
  After=network.target

  [Service]
  Type=forking
  User=root
  Group=root
  Environment=CATALINA_HOME=/opt/tomcat
  Environment=CATALINA_BASE=/opt/tomcat
  ExecStart=/opt/tomcat/bin/startup.sh
  ExecStop=/opt/tomcat/bin/shutdown.sh
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target
  EOL
  systemctl enable tomcat
  echo "Tomcat installation completed"
EOF

# Allowed IP for SSH/RDP access
allowed_ip = "0.0.0.0/32" # Will be overridden by pipeline

# Tags
tags = {
  "Project owner" = "bfarhad"
  "region"        = "west europe"
  "cost"          = "medium"
  "env"           = "dev"
  "Project name"  = "azure-vm-images-mgmt"
}