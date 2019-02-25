resource "azurerm_public_ip" "public_ip_jenkins_devops" {
  name                = "public_ip_jenkins_devops"
  location            = "${var.resource_group_devops_location}"
  resource_group_name = "${var.resource_group_devops_name}"
  allocation_method   = "Dynamic"
  domain_name_label   = "jenkins${var.random_string_result}"

  tags {
    Name  = "Jenkins"
    Group = "DevOps"
  }
}

resource "azurerm_network_interface" "network_interface_jenkins_devops" {
  name                      = "nic_jenkins_devops"
  location                  = "${var.resource_group_devops_location}"
  resource_group_name       = "${var.resource_group_devops_name}"
  network_security_group_id = "${var.network_security_group_devops_id}"

  ip_configuration {
    name                          = "nic_config_jenkins_devops"
    subnet_id                     = "${var.subnet_A_devops_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.public_ip_jenkins_devops.id}"
  }

  tags {
    Name  = "Jenkins"
    Group = "DevOps"
  }
}

resource "azurerm_virtual_machine" "virtual_machine_jenkins" {
  name                  = "JenkinsMaster"
  location              = "${var.resource_group_devops_location}"
  resource_group_name   = "${var.resource_group_devops_name}"
  network_interface_ids = ["${azurerm_network_interface.network_interface_jenkins_devops.id}"]
  vm_size               = "Standard_B2s"

  # depends_on = ["azurerm_network_interface.main"]
  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "jenkinsosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "openLogic"
    offer     = "CentOS"
    sku       = "7.6"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "centos"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/centos/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }

  provisioner "local-exec" {
    command = "sleep 20; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u centos --private-key ~/.ssh/id_rsa -i 'jenkins${var.random_string_result}.centralus.cloudapp.azure.com,' ./ansible/jenkins_main.yml"
  }

  tags {
    Name  = "JenkinsMaster"
    Group = "DevOps"
  }
}
