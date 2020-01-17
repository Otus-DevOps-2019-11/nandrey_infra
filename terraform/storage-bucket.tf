provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "storage-bucket-stage" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  location = "europe-west3"
  name = "otus-tf-stage"
}

output storage-bucket_url-stage {
  value = module.storage-bucket-stage.url
}

module "storage-bucket-prod" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  location = "europe-west3"
  name = "otus-tf-prod"
}

output storage-bucket_url-prod {
  value = module.storage-bucket-prod.url
}
