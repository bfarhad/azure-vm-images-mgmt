# Variables
variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "azure-vm-images-mgmt"
}

variable "vnet_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "subnet_cidr" {
  type    = string
  default = "192.168.1.0/27"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "The size of the virtual machine. Possible choices: Standard_B1s, Standard_B2s, Standard_B4ms, etc."
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "The operating system type. Possible choices: Linux, Windows"
}

variable "image_publisher" {
  type        = string
  default     = "Canonical"
  description = "The publisher of the VM image. Possible choices: Canonical, MicrosoftWindowsServer, etc."
}

variable "image_offer" {
  type        = string
  default     = "UbuntuServer"
  description = "The offer of the VM image. Possible choices: UbuntuServer, WindowsServer, etc."
}

variable "image_sku" {
  type        = string
  default     = "22.04-LTS"
  description = "The SKU of the VM image. Possible choices: 22.04-LTS, 2019-Datacenter, etc."
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "The version of the VM image. Possible choices: latest, or specific version"
}

variable "enable_image_builder" {
  type        = bool
  default     = false
  description = "Whether to enable the image builder module"
}

variable "build_image_name" {
  type        = string
  default     = "custom-image"
  description = "The name of the custom image to build"
}

variable "base_image_publisher" {
  type        = string
  default     = "Canonical"
  description = "The publisher of the base image for image builder"
}

variable "base_image_offer" {
  type        = string
  default     = "UbuntuServer"
  description = "The offer of the base image for image builder"
}

variable "base_image_sku" {
  type        = string
  default     = "22.04-LTS"
  description = "The SKU of the base image for image builder"
}

variable "build_script" {
  type        = string
  default     = <<-EOF
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
  description = "The inline script to run during image build"
}

variable "automation_account_name" {
  type        = string
  default     = "automation-account"
  description = "Name of the Azure Automation account"
}

variable "allowed_ip" {
  type        = string
  description = "The public IP address allowed to access the VM via SSH and RDP"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "tags" {
  type = map(string)
  default = {
    "Project owner" = "bfarhad"
    "Project name"  = "azure-vm-images-mgmt"
    "region"        = "west europe"
    "cost"          = "medium"
    "env"           = "dev"
  }
}