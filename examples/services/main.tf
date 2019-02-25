resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations {
      name = "${var.namespace}"
    }
    name = "${var.namespace}"
  }
}

# Helm modules
module "system_modules" {
  source = "../../modules/helm/system-modules"
  google_project = "${var.google_project}"
  google_zone = "${var.google_zone}"
  cluster_name = "${var.cluster_name}"
  domain = "${var.domain}"
}

# Secrets
module "postgres_secrets" {
  source = "../../modules/secrets"
  namespace = "axxonet"
  postgres_root_username = "${var.postgres_root_username}"
  postgres_root_password = "${var.postgres_root_password}"
  service_account_private_key = "${var.service_account_private_key}"
  bucket_credentials = "${var.bucket_credentials}"
}

# Aether
module "aether_kernel" {
  source = "../../modules/helm/service"
  chart_name = "aether-kernel"
  chart_version = "1.2.0"
  namespace = "axxonet" # UPDATE ME
  project = "aethertest"
  domain = "${var.domain}"
  dns_provider = "gcloud"
  database_instance_name = "${var.database_instance_name}"
  gcs_bucket_name = "aether-kernel-example"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
}

module "aether_odk" {
  source = "../../modules/helm/service"
  chart_name = "aether-odk"
  chart_version = "1.2.0"
  namespace = "axxonet" # UPDATE ME
  project = "aethertest" # UPDATE ME
  domain = "${var.domain}"
  dns_provider = "gcloud"
  database_instance_name = "${var.database_instance_name}"
  gcs_bucket_name = "aether-odk-example"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
}



module "gather" {
  source = "../../modules/helm/service"
  chart_name = "gather"
  chart_version = "3.1.0"
  namespace = "axxonet" # UPDATE ME
  project = "aethertest" # UPDATE ME
  domain = "${var.domain}"
  dns_provider = "gcloud"
  database_instance_name = "${var.database_instance_name}"
}
