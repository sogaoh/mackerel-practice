resource "google_cloud_scheduler_job" "myblog-visitor-count-request-job" {
  name             = "myblog-visitor-count-request-job"
  description      = "${var.myblog_name} visitors count job"

  region           = "us-central1"

  schedule         = "*/2 * * * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "90s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "GET"
    uri         = "${var.myblog-visitor-count_app_url}/post"
  }
}
