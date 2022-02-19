resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
  }
}


variable "prometheus_config" {
  description = "Object to be passed as values to the kube-prometheus-stack Helm install. (See https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml) "
  default     = {}
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.prometheus.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "32.2.0"
  chart      = "kube-prometheus-stack"

  values = [jsonencode(var.prometheus_config)]
}