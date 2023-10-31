############################# ROOT/terragrunt.hcl
############################# DEV ROOT TERRAGRUNT.hcl
locals {
  project  = "MIR"
}

generate    "main" {
    path      = "main.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<ZZZ
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # tfstate파일 저장 위치 설정 | terraform init -migrate-state
  backend "s3" {
    region  = "ap-northeast-2"
    bucket  = "mir-s3-testate" # 미리 생성한 S3 이름 작성
    encrypt = true             # tfstate파일 암호화 설정

    # tfstate 저장 경로 & lock
    key            = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "mir-dyna-lock"
  }
}

provider "aws" {
  //profile = "tf-user"
  region = "ap-northeast-2" # Asia Pacific (Seoul) region
}
    ZZZ
}