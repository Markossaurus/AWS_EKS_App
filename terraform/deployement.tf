resource "kubernetes_pod" "webserver1" {
  metadata {
    name = "webserver1"
    labels {
      App = "nginx1"
    }
  }

  spec {
    container {
      image = "localhost:5000/webserver1"
      name  = "first-webserver"
      imagePullPolicy = "Always"

      port {
        container_port = 80
      }
    }
  }
   depends_on = [
    aws_eks_cluster.haproxy,
    aws_eks_node_group.haprox,
  ]
}