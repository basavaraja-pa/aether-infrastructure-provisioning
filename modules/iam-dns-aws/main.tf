
data "google_iam_policy" "admin" {
  binding {
    role = "roles/compute.instanceAdmin"

    members = [
      "serviceAccount: servicetestaxx@encouraging-key-198909.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"

    members = [
      "user:kiran.ks@axxonet.net",
    ]
  }
}
