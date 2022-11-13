terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.23.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "docker" {
   host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"
  ports {
    internal = 80
    external = 8080
  }
}
