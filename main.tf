module "container_glrunner_k2" {
  source    = "github.com/studio-telephus/tel-iac-modules-lxd.git//instance?ref=develop"
  name      = "container-glrunner-k2"
  image     = "images:debian/bookworm"
  profiles  = ["limits", "fs-dir", "nw-adm"]
  autostart = true
  nic = {
    name = "eth0"
    properties = {
      nictype        = "bridged"
      parent         = "adm-network"
      "ipv4.address" = "10.0.10.131"
    }
  }
  mount_dirs = [
    "${path.cwd}/filesystem-shared-ca-certificates",
    "${path.cwd}/filesystem",
  ]
  exec = {
    enabled    = true
    entrypoint = "/mnt/install.sh"
    environment = {
      RANDOM_STRING                  = "844cc615-8e80-4703-b4c9-057ee868e2fa"
      GITLAB_RUNNER_REGISTRATION_KEY = var.gitlab_runner_registration_key
      GIT_SA_USERNAME                = var.git_sa_username
      GIT_SA_TOKEN                   = var.git_sa_token
    }
  }
}
