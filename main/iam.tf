resource "google_service_account" "fraud_sa" {
  account_id   = "fraud-sa"

  depends_on = [
    google_project_service.required_apis
  ]
}

resource "google_project_iam_member" "pubsub_access" {
  project = var.project_id
  role    = "roles/pubsub.editor"
  member  = "serviceAccount:${google_service_account.fraud_sa.email}"
}

resource "kubernetes_service_account" "fraud_ksa" {
  metadata {
    name      = "fraud-ksa"
    namespace = "fraud"

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.fraud_sa.email
    }
  }
}

resource "google_service_account_iam_binding" "binding" {
  service_account_id = google_service_account.fraud_sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[fraud/fraud-ksa]"
  ]

  depends_on = [
    google_container_cluster.gke
  ]
}