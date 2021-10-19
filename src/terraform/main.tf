locals {
  dns_name = "crdant.io."
}

resource "google_dns_managed_zone" "crdant_io" {
  name        = "crdant"
  dns_name    = local.dns_name
  description = "Publicly facing crdant.io domain"

  dnssec_config {
    state = "on"
  }
}

# addresses 
resource "google_dns_record_set" "crdant_io" {
  name         = google_dns_managed_zone.crdant_io.dns_name
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "A"
  ttl          = 60

  rrdatas = [
    "75.2.60.5"
  ]
}

resource "google_dns_record_set" "local_crdant_io" {
  name         = "*.local.${google_dns_managed_zone.crdant_io.dns_name}"
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "A"
  ttl          = 60

  rrdatas = [
    "127.0.0.1"
  ]
}

resource "google_dns_record_set" "minikube_crdant_io" {
  name         = "*.minikube.${google_dns_managed_zone.crdant_io.dns_name}"
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "A"
  ttl          = 60

  rrdatas = [
    "192.168.99.100"
  ]
}

resource "google_dns_record_set" "www_crdant_io" {
  name         = "www.${google_dns_managed_zone.crdant_io.dns_name}"
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "CNAME"
  ttl          = 60

  rrdatas = [
    "sad-euler-3a20af.netlify.app."
  ]
}

# MX records
resource "google_dns_record_set" "crdant_io_mx" {
  name         = google_dns_managed_zone.crdant_io.dns_name
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "MX"
  ttl          = 300

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com.",
  ]
}

resource "google_dns_record_set" "cloud_crdant_io_mx" {
  name         = "cloud.${google_dns_managed_zone.crdant_io.dns_name}"
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "MX"
  ttl          = 300

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com.",
  ]
}

# verification/security records
resource "google_dns_record_set" "crdant_io_txt" {
  name         = google_dns_managed_zone.crdant_io.dns_name
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "TXT"
  ttl          = 300

  rrdatas = [
    "\"google-site-verification=KHbc9bEc7SGC_UXq_u0cWiUrLI4G_NAlo1XMXmkSZxY\"",
    "\"v=spf1\" \"include:_spf.google.com\" \"~all\""
  ]
}

resource "google_dns_record_set" "crdant_io_caa" {
  name         = google_dns_managed_zone.crdant_io.dns_name
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "CAA"
  ttl          = 300

  rrdatas = [
    "0 issue \"letsencrypt.org\""
  ]
}

resource "google_dns_record_set" "google_site_verification_crdant_io" {
  name         = "google-site-verification.${google_dns_managed_zone.crdant_io.dns_name}"
  managed_zone = google_dns_managed_zone.crdant_io.name
  type         = "TXT"
  ttl          = 300

  rrdatas = [
    "google-site-verification=KHbc9bEc7SGC_UXq_u0cWiUrLI4G_NAlo1XMXmkSZxY",
  ]
}
