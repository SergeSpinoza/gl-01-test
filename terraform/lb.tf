resource "google_compute_instance_group" "test" {
  name = "test-test"
  zone = "europe-west1-b"


  instances = ["${google_compute_instance.app.*.self_link}"]


  named_port {
    name = "http"
    port = "9292"
  }
}

resource "google_compute_health_check" "health-check" {
  name               = "health-check"
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port = "9292"
  }
}
resource "google_compute_backend_service" "test-1" {
  name     = "test-1"
  protocol = "HTTP"

  backend {
    group = "${google_compute_instance_group.test.self_link}"
  }

  health_checks = ["${google_compute_health_check.health-check.self_link}"]
}




resource "google_compute_url_map" "web-map" {
  name            = "tf-web-map"
  default_service = "${google_compute_backend_service.test-1.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "tf-allpaths"
  }

  path_matcher {
    name            = "tf-allpaths"
    default_service = "${google_compute_backend_service.test-1.self_link}"
    
  }
}








resource "google_compute_global_address" "external-address" {
  name = "tf-external-address"
}


resource "google_compute_target_http_proxy" "balance" {
  name    = "balance"
  url_map = "${google_compute_url_map.web-map.self_link}"
  
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "tf-http-content-gfr"
  target     = "${google_compute_target_http_proxy.balance.self_link}"
  ip_address = "${google_compute_global_address.external-address.address}"
  port_range = "80"
}

