import diagrams
print(dir(diagrams))

import diagrams.azure.compute
print(dir(diagrams.azure.compute))

import diagrams.azure.security
print(dir(diagrams.azure.security))

import diagrams.azure.monitor
print(dir(diagrams.azure.monitor))


from diagrams import Diagram, Cluster
#from diagrams import Diagram

from diagrams.azure.compute import VMScaleSet, VMSS
from diagrams.azure.compute import VM  # Or use VMSS if available

from diagrams.azure.network import VirtualNetworks, LoadBalancers, Firewall
from diagrams.azure.security import SecurityCenter  # if KeyVault is not available
from diagrams.azure.identity import ActiveDirectory
from diagrams.azure.identity import ManagedIdentities
from diagrams.azure.devops import Devops
from diagrams.azure.network import DDOSProtectionPlans
from diagrams.azure.monitor import Monitor  # If Monitor is found in a different module
from diagrams.azure.monitor import Logs
from diagrams.azure.database import SQLDatabases
from diagrams.azure.storage import BlobStorage
from diagrams.onprem.client import Users
from diagrams.azure.security import KeyVaults # Replace with the correct name found
from diagrams.azure.compute import ImageTemplates, SharedImageGalleries
from diagrams.onprem.client import Client



# Create a diagram context
with Diagram("My Azure Architecture", filename="images/my_azure_architecture", show=False) as diag:
    # Use the DDOSProtectionPlans within the diagram context
    ddos = DDOSProtectionPlans("DDoS Protection Plans")
# Create a high-level architecture diagram
    
    user = Users("End Users")

    vmss = VMSS("VM Scale Set")
    #cost = Custom("Cost Management", "./cost_management_icon.png")


    with Cluster("Azure Cloud Environment"):
        
        # Networking & Security
        with Cluster("Networking & Security"):
            vnet = VirtualNetworks("Azure VNet")
            firewall = Firewall("Azure Firewall")
            ddos = DDOSProtectionPlans("DDoS Protection")
            security = SecurityCenter("Security Center")
            
            vnet >> firewall >> ddos >> security
        
        # Compute Layer
        with Cluster("Compute Layer"):
            vmss = VMScaleSet("VM Scale Set")
            vm1 = VM("Azure VM 1")
            vm2 = VM("Azure VM 2")
            storage = BlobStorage("Storage")
            img_builder = ImageTemplates("Image Builder")
            gallery = SharedImageGalleries("Shared Image Gallery")

            vm1 - vm2 >> vmss >> storage
            img_builder >> gallery >> vmss
        
        # Identity & Access Management
        with Cluster("Identity & Access Management"):
            ad = ActiveDirectory("Microsoft Entra ID")
            keyvault = KeyVaults("Key Vault")
        
        # Monitoring & Governance
        with Cluster("Monitoring & Governance"):
            monitor = Monitor("Azure Monitor")
            logs = Logs("Log Analytics")
            cost = Logs("Cost Management Logs")

        # CI/CD & Automation
        with Cluster("Automation & DevOps"):
            devops = Devops("Azure DevOps")
            automation = Client("Automation Account")
            devops >> automation

        # Data Layer
        database = SQLDatabases("Azure SQL Database")

        # Connections
        user >> vnet >> vmss >> database
        vmss >> ad >> keyvault
        vmss >> monitor >> logs >> cost
        vmss >> devops >> automation
        devops >> img_builder >> gallery >> vmss
