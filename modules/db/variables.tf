variable "db_identifier" {
  description = "The name of the RDS instance"
  default = ""
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  default = 20
}

variable "db_name" {
  description = "The DB name to create"
  default = "sre-aws-db"
}

variable "db_username" {
  description = "Username for the master DB user"
  default = "sre"
}

variable "db_password" {
  description = "Password for the master DB user"
  default = "sre"
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  default = 5000
}
