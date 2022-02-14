resource "kubernetes_namespace" "sandbox" {
    metadata {
        name = "sandbox"
    }
}

resource "kubernetes_pod" "alpine" {
    metadata {
        name = "alpine"
        namespace = kubernetes_namespace.sandbox.metadata[0].name
    }

    spec {
        restart_policy = "Never"

        container {
            image = "alpine:3.15.0"
            name  = "alpine"
            args = ["sh"]
            tty = true
            stdin = true
            stdin_once = true
        }
    }
}

resource "kubernetes_pod" "ubuntu" {
    metadata {
        name = "ubuntu"
        namespace = kubernetes_namespace.sandbox.metadata[0].name
    }

    spec {
        restart_policy = "Never"

        container {
            image = "ubuntu:22.04"
            name  = "ubuntu"
            args = ["sh"]
            tty = true
            stdin = true
            stdin_once = true
        }
    }
}