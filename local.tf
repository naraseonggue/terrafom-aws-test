locals {
  project_name          =   "${var.project_name != "" ? var.project_name : "default"}"
  vpc_name              =   "${local.project_name}-vpc"
}
