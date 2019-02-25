provider "azurerm" {
  client_id       = "${lookup(var.client_id, var.env)}"
  client_secret   = "${lookup(var.client_secret, var.env)}"
  subscription_id = "${lookup(var.subscription_id, var.env)}"
  tenant_id       = "${lookup(var.tenant_id, var.env)}"
}

module "az_network" {
  source = "./networking"
}

module "az_random" {
  source = "./random"
}

module "az_compute_jenkins" {
  source = "./compute_jenkins"

  resource_group_devops_location = "${module.az_network.resource_group_devops_location}"

  resource_group_devops_name = "${module.az_network.resource_group_devops_name}"

  network_security_group_devops_id = "${module.az_network.network_security_group_devops_id}"

  subnet_A_devops_id = "${module.az_network.subnet_A_devops_id}"

  random_string_result = "${module.az_random.random_string_result}"
}

module "az_compute_sonarqube" {
  source = "./compute_sonarqube"

  resource_group_devops_location = "${module.az_network.resource_group_devops_location}"

  resource_group_devops_name = "${module.az_network.resource_group_devops_name}"

  network_security_group_devops_id = "${module.az_network.network_security_group_devops_id}"

  subnet_A_devops_id = "${module.az_network.subnet_A_devops_id}"

  random_string_result = "${module.az_random.random_string_result}"
}

module "az_compute_artifactory" {
  source = "./compute_artifactory"

  resource_group_devops_location = "${module.az_network.resource_group_devops_location}"

  resource_group_devops_name = "${module.az_network.resource_group_devops_name}"

  network_security_group_devops_id = "${module.az_network.network_security_group_devops_id}"

  subnet_A_devops_id = "${module.az_network.subnet_A_devops_id}"

  random_string_result = "${module.az_random.random_string_result}"
}
