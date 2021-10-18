terraform {
  backend "gcs" {
    bucket = "terraform-dns-crdant-io"
    prefix = "terraform/state"
  }
}
