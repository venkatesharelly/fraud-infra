resource "google_project_service" "required_apis" {
  for_each = toset([
    "container.googleapis.com",          # GKE
    "compute.googleapis.com",            # Networking / LB
    "iam.googleapis.com",                # IAM
    "cloudresourcemanager.googleapis.com",
    "dns.googleapis.com",                # Private DNS
    "storage.googleapis.com"             # GCS (tfstate)
  ])

  project = var.project_id
  service = each.key

  disable_on_destroy = false
}