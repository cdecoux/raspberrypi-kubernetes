
variable "vpn_config" {
  description = "VPN Config - Environment Variables sent to the VPN Pod (Check docs at https://github.com/qdm12/gluetun)"
  type        = map(string)
  validation {
    condition     = contains(keys(var.vpn_config), "VPNSP")
    error_message = "A VPNSP property is required (Check docs at https://github.com/qdm12/gluetun)."
  }
}

# TODO Put behind a service / deployment

resource "kubernetes_pod" "deluge" {
  metadata {
    name = "deluge"
  }

  spec {
    restart_policy = "Always"

    container {
      image = "qmcgaw/gluetun:v3.27.0"
      name  = "vpn"

      dynamic "env" {
        for_each = var.vpn_config

        content {
          name  = env.key
          value = env.value
        }
      }

      security_context {
        privileged = true
        capabilities {
          add = ["NET_ADMIN"]
        }
      }
    }

      container {
          image = "lscr.io/linuxserver/deluge"
          name = "deluge"
          port {
              container_port = 8112
          }
          port {
              container_port = 6881
              protocol = "TCP"
          }
          port {
              container_port = 6881
              protocol = "UDP"
          }
      }

  }
}