variable AWS_ACCESS_KEY {
  type        = string
  description = "AWS access key value from tfvars"
}

variable AWS_SECRET {
  type        = string
  description = "AWS secret key from tfvars"
}

variable cluster_name {
  type        = string
  default     = "haproxy"
  description = "name of cluster"
}
