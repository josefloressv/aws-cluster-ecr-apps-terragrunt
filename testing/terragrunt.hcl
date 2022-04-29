# Testing environment base

terraform {
    #source = "${get_env("HOME")}/today/aws-cluster-ecr-apps-terraform//"
    source = "git::https://github.com/josefloressv/aws-cluster-ecr-apps-terraform.git"
}

remote_state {
    backend = "s3"
    config = {
        bucket = "terraform-state-0421-testing"
        key = "ecr/testing/${path_relative_to_include()}-terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-dynamo-0421-testing"
    }
}

inputs = {
    # General
    base_tags = {
        env         = "Testing"
        createdFrom = "terraform"
    }

    # ECR defaults
    ecr_default_tag_mutability = "MUTABLE"
    ecr_repo_policy_expiration_days = 7
    ecr_repo_policy_description = "Expire images older than 7 days"
    ecr_repo_tags = {
        Policy = "7 days retention policy applied to all images in this repo"
    }    
}
