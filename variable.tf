variable "key_name" {
  type        = list
  description = "name of keypair to pull down using data source"

  default     = ["kojitechs-demo-key"]
}