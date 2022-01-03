terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "srs" {
  name = "ossrs/srs:latest"
  keep_locally = true
}

resource "docker_container" "srs" {
  image = docker_image.srs.latest
  name  = var.container_name
  ports {
    internal = 8080
    external = 8080
    protocol = "tcp"
  }
  ports {
    internal = 1985
    external = 1985
    protocol = "tcp"
  }
  ports {
    internal = 1935
    external = 1935
    protocol = "tcp"
  }
}