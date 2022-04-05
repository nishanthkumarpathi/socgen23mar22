terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "targetserver" {
  name         = "nishanthkp/targetserver:ubuntu16"
  keep_locally = false
}

resource "docker_container" "web_server" {
  image = docker_image.targetserver.name
  name  = "web_server"
  ports {
    internal = 5000
    external = 5000
  }
}

resource "docker_container" "db_server" {
  image = docker_image.targetserver.name
  name  = "db_server"
  ports {
    internal = 3306
    external = 3306
  }
}

#Output the IP Address of the Web Server Container

output "web_server_ip_address" {
  value       = docker_container.web_server.ip_address
  description = "The IP for the container."
}

output "web_server_container_name" {
  value       = docker_container.web_server.name
  description = "The name of the container."
}

# Output the IP Address of the Database Container

output "db_server_container_name" {
  value       = docker_container.db_server.name
  description = "The name of the container."
}

output "db_server_ip_address" {
  value       = docker_container.db_server.ip_address
  description = "The IP for the container."
}


resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
    db_ip  = "${docker_container.db_server.ip_address}",
    web_ip = "${docker_container.web_server.ip_address}"
  })
  filename = "inventory"
}

resource "local_file" "ansible_db_inventory" {
  content = templatefile("../dummyoutput/db_server.tmpl", {
    db_ip  = "${docker_container.db_server.ip_address}"
  })
  filename = "../dummyoutput/db_server.yml"
}

resource "local_file" "ansible_web_inventory" {
  content = templatefile("../dummyoutput/web_server.tmpl", {
    db_ip  = "${docker_container.web_server.ip_address}"
  })
  filename = "../dummyoutput/web_server.yml"
}