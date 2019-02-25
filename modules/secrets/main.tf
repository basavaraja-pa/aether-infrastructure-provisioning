resource "kubernetes_secret" "google-application-credentials" {
  metadata {
    name = "cloudsql-instance-credentials"
    namespace = "${var.namespace}"
  }
  data {
    credentials.json = "${base64decode(var.service_account_private_key)}"
  }
}

# service account for bucket acccess
resource "kubernetes_secret" "google-bucket-credentials" {
  metadata {
     name = "${var.namespace}-bucket-credentials"
   # name = "aether-kernel-example"
    namespace = "${var.namespace}"
  }
  data {
    #credentials.json = "${var.bucket_credentials}"
     credentials.json = "${base64decode(var.service_account_private_key)}"
  }
}

# service account for bucket acccess
resource "kubernetes_secret" "static-assets-volume" {
  metadata {
     name = "static-assets-volume"
    namespace = "${var.namespace}"
  }
  data {
     credentials.json = "${base64decode(var.service_account_private_key)}"
  }
}

resource "kubernetes_secret" "db_password" {
  metadata {
    name = "database-credentials"
    namespace = "${var.namespace}"
  }

  data {
    host = "127.0.0.1"
    user = "root"
    password = "${var.postgres_root_password}"
  }
}
