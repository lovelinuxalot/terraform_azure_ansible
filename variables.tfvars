
location = "eastus2"

rgname = "rmqRG"

rg_tag = "RabbitMQ demo"

virtual_network_name = "rmqVNet"

vm_count = 3

vm_size = "Standard_B1ms"

storage_image_reference = ["OpenLogic", "CentOS", "7.5", "latest"]

storage_os_disk = ["Standard_LRS","FromImage","ReadWrite"]

admin_username = "azureadmin"

local_public_ssh_key = "/root/.ssh/id_rsa.pub"

public_ssh_key_path = "/home/azureadmin/.ssh/authorized_keys"

subnet_counter = 3
