# iac-tools-aws

[![dockeri.co](https://dockeri.co/image/dockernm/iac-tools-aws)](https://hub.docker.com/r/dockernm/iac-tools-aws)

The `dockernm/iac-tools-aws` Dockerfile provides a useful baseline image for run some common tools for working with Amazon Web Services (AWS) and Infrastructure as Code (IaC).

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
* [Tooling](#tooling)
* [Prerequisities](#Prerequisities)
* [How to Use](#How-to-use)
* [Security](#security)


<!-- vim-markdown-toc -->

# Introduction

I use these tools for work across different client environments. I built this docker image to avoid cluttering up my laptop and getting into trouble with multiple different versions of python, pip and other packages that many of these tools use. I can have one container for each customer with a seperate set of AWS key etc so there is no chance of cross-contamination between clients. 

The image is based on Ubuntu (https://hub.docker.com/_/ubuntu) 

# Tooling

This image contains my favourite tools which I find useful for development and help to adopt a 'shift left' approach for IaC security testing


All baseline Ubuntu tools plus 

- `make`
- `wget`
- `git`
- `ssh`
- `unzip`
- `ca-certificates`
- `gcc python3-dev`
- `python3-pip`  
- [`shellcheck`](https://github.com/koalaman/shellcheck)

[Terraform](https://github.com/hashicorp/terraform/), [Terraform Lint](https://github.com/terraform-linters/tflint/), [Checkov](https://github.com/bridgecrewio/checkov) and [TFSec](https://github.com/tfsec/tfsec):

- `terraform` (0.14.8)
- `tflint` (0.25.0)
- `checkov` (latest)
- `tfsec` (0.39.10)

AWS CLI which is for [Terraform Backends](https://www.terraform.io/docs/backends/)

- `aws` (2.1.31)

[AWSUME](https://github.com/trek10inc/awsume) which is to allow automatic IAM role assumption on the AWS CLI (Very very useful)
- `awsume` (latest at time of publishing = 4.5.1a2)

[Pre-commit](https://github.com/pre-commit/pre-commit)
- ``pre-commit`` (latest at time of publishing = 2.11.1)


# Prerequisities


In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

# How to use
There are two options you have, you can download and run the container I have put on Docker Hub or download this repo and build your own image locally. 
If you chose to build your own image you can amend the versions of some of the tools such as Terraform to meet your needs. 
### Build your own image

Clone this repo

SSH - ``git clone git@github.com:nmarchini/iac-tools-aws.git``

HTTPS - ``git clone https://github.com/nmarchini/iac-tools-aws.git && cd iac-tools-aws``

Issue the docker build command ``docker build -t <image-name:tag> .``

Example `docker build -t <my-iac-tools-aws:v1> .`


### Download from Docker Hub and run 

Download from Docker Hub (https://hub.docker.com/r/dockernm/iac-tools-aws)
   
`docker pull dockernm/iac-tools-aws && cd iac-tools-aws`

`docker run -it dockernm/iac-tools-aws:latest /bin/bash`



### Security

To scan the image for vulnerabilities then you can do this on the cli using this command. Uses Snyk

`docker scan dockernm/iac-tools-aws:latest`