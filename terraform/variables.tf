variable "project_id" {
  type        = string
  description = "The Google Cloud project to deploy to"
  default     = "data-platform-439814"
}

variable "region" {
  type        = string
  description = "The region to deploy to"
  default     = "europe-west2"
}

variable "location" {
  type        = string
  description = "The target location for datasets and more, EU or US "
  default     = "EU"
}

variable "zone" {
  type        = string
  description = "The zone to deploy to"
  default     = "europe-west2-c"
}
