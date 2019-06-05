provider aws {
  region = "${var.region}"
}

terraform {
  backend "remote" {}
}
