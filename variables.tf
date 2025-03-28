variable "domain" {
  type        = string
  description = "Where your files are stored. S3 or EFS"
  default     = "S3"
}

variable "sftp_users" {
  type = map(object({
    user_name           = string
    public_key          = string
    s3_bucket_name      = optional(string)
    bucket_permissions  = optional(list(string))
    home_directory_type = optional(string)
    home_directory      = optional(string)
    home_directory_mappings = optional(list(object({
      entry  = string
      target = string
    })))
  }))
  default     = {}
  description = "Map of SFTP users and their configurations. Required: user_name, public_key. Optional: s3_bucket_name, bucket_permissions, home_directory_type, home_directory, home_directory_mappings"
}

variable "restricted_home" {
  type        = bool
  description = "Restricts SFTP users so they only have access to their home directories."
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Forces the AWS Transfer Server to be destroyed"
  default     = false
}

variable "s3_bucket_name" {
  type        = string
  description = "This is the bucket that the SFTP users will use when managing files"
}

# Variables used when deploying to VPC
variable "vpc_id" {
  type        = string
  description = "VPC ID that the AWS Transfer Server will be deployed to"
  default     = null
}

variable "address_allocation_ids" {
  type        = list(string)
  description = "A list of address allocation IDs that are required to attach an Elastic IP address to your SFTP server's endpoint. This property can only be used when endpoint_type is set to VPC."
  default     = []
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security groups IDs that are available to attach to your server's endpoint. If no security groups are specified, the VPC's default security groups are automatically assigned to your endpoint. This property can only be used when endpoint_type is set to VPC."
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC."
  default     = []
}

variable "security_policy_name" {
  type        = string
  description = "Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, and TransferSecurityPolicy-FIPS-2020-06. Default value is: TransferSecurityPolicy-2018-11."
  default     = "TransferSecurityPolicy-2018-11"
}

variable "domain_name" {
  type        = string
  description = "Domain to use when connecting to the SFTP endpoint"
  default     = ""
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID to add the CNAME"
  default     = ""
}

variable "eip_enabled" {
  type        = bool
  description = "Whether to provision and attach an Elastic IP to be used as the SFTP endpoint. An EIP will be provisioned per subnet."
  default     = false
}
variable "workflow_details" {
  type = object({
    on_upload = object({
      execution_role = string
      workflow_id    = string
    })
  })
  description = "Workflow details for triggering the execution on file upload."
  default = {
    on_upload = {
      execution_role = ""
      workflow_id    = ""
    }
  }
}

variable "enable_workflow" {
  type    = bool
  default = false
}
