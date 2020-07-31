resource "google_service_account" "service-account-analytics-transcriber" {
  account_id   = "analytics-transcriber"
  display_name = "analytics-transcriber"
  project      = var.project
}
