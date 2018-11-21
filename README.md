# tfenv
[![Build Status](https://travis-ci.org/ridibooks-docker/tfenv.svg?branch=master)](https://travis-ci.org/ridibooks-docker/tfenv)
[![](https://images.microbadger.com/badges/version/ridibooks/tfenv.svg)](https://microbadger.com/images/ridibooks/tfenv "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/ridibooks/tfenv.svg)](https://microbadger.com/images/ridibooks/tfenv "Get your own image badge on microbadger.com")

## Getting started
### 1. Write terraform-bundle.hcl
```bash
#
# Configuration used by terraform-bundle to fetch all required plugins ONCE.
#
# (see https://github.com/hashicorp/terraform/tree/master/tools/terraform-bundle)
# (why https://github.com/hashicorp/terraform/issues/15801)
#

terraform {
  version = "0.11.10"
}

providers {
  aws = ["~> 1.38"]
  null = ["~> 1.0"]
  template = ["~> 1.0"]
  terraform = ["~> 1.0"]
}
```

### 2. Create Terraform S3 backend
```bash
# create_backend: Create Terraform S3 backend
docker run --rm -it \
    -e BACKEND_S3_REGION=ap-northeast-2 \
    -e BACKEND_S3_BUCKET=your-bucket-name \
    ridibooks/tfenv \
    create_backend

# delete_backend: Delete Terraform S3 backend
docker run --rm -it \
    -e BACKEND_S3_REGION=ap-northeast-2 \
    -e BACKEND_S3_BUCKET=your-bucket-name \
    ridibooks/tfenv \
    delete_backend
```

## 3. Run Terraform commands
```bash
# Commands:
#  - init [TARGET_PATH]
#  - plan [TARGET_PATH]
#  - apply [TARGET_PATH]
#  - get [TARGET_PATH]
#  - destroy [TARGET_PATH]
#  - output [TARGET_PATH]
#  - state [TARGET_PATH] [COMMAND]
#  - import [TARGET_PATH] [RESOURCE_ADDR] [ID]
#  - force-unlock [LOCK_ID]

# Example: terraform init
docker run --rm -it \
    -e BACKEND_S3_REGION=ap-northeast-2 \
    -e BACKEND_S3_BUCKET=your-bucket-name \
    -v /your/project/root:/app
    ridibooks/tfenv \
    init prod/resource1
```

## Environment Variables
- TARGET_OS (default: linux)
- TARGET_ARCH (default: amd64)

- BACKEND_S3_REGION
- BACKEND_S3_BUCKET

- [Terroform variables](https://www.terraform.io/docs/configuration/environment-variables.html)
  - TF_PLUGIN_DIR
  - TF_PLAN_DIR
  - TF_DATA_DIR
  - TF_LOG_PATH
  - TF_INPUT
  - TF_IN_AUTOMATION

- AWS variables
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
