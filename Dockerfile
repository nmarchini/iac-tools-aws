# A baseline image for AWS tools for IAc.

# Using Ubuntu as it has less vulnerabilities and debian but this should work with Debian:buster as well
#FROM ubuntu:latest
FROM ubuntu:rolling

# Some metadata.
MAINTAINER Nick Marchini (https://github.com/nmarchini)

# Used to control versions
ARG VERSION_TERRAFORM=0.14.8 ## https://github.com/hashicorp/terraform/releases
ARG VERSION_TFLINT=0.25.0 ## https://github.com/terraform-linters/tflint/releases
ARG VERSION_AWS_CLI=2.1.31 ## https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst
ARG VERSION_CHECKOV=1.0.854  ## https://github.com/bridgecrewio/checkov/releases
ARG VERSION_TFSEC=0.39.10 ## https://github.com/tfsec/tfsec/releases

# Install some common tools needed for the build
RUN apt-get update -qq && apt-get install --no-install-recommends --no-install-suggests -qq -y \
    make \
    wget \
    git \
    ssh \
    unzip \
    ca-certificates \
    gcc python3-dev \
    python3-pip \
    shellcheck

# Install Terraform.
RUN wget -q https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_linux_amd64.zip && \
    unzip terraform_${VERSION_TERRAFORM}_linux_amd64.zip && \
    install terraform /usr/local/bin && \
    terraform -v && \
    rm -f terraform_${VERSION_TERRAFORM}_linux_amd64.zip && \
    rm -f terraform

# Install tflint.
RUN wget -q https://github.com/terraform-linters/tflint/releases/download/v${VERSION_TFLINT}/tflint_linux_amd64.zip && \
    unzip tflint_linux_amd64.zip && \
    install tflint /usr/local/bin && \
    chmod ugo+x /usr/local/bin/tflint && \
    tflint -v && \
    rm -f tflint_linux_amd64.zip && \
    rm -f tflint

#Install TFSec
RUN wget -q https://github.com/tfsec/tfsec/releases/download/v0.39.9-fix-recursive/tfsec-linux-amd64 && \
    mv tfsec-linux-amd64 tfsec && \
    install tfsec /usr/local/bin && \
    chmod ugo+x /usr/local/bin/tfsec && \
    tfsec -v && \
    rm -f tfsec

# Install Checkov
RUN pip3 install --no-cache-dir --upgrade setuptools && pip3 install checkov==${VERSION_CHECKOV} && checkov -v

# Install the AWS CLI.
RUN  wget --user-agent=Mozilla --content-disposition -E -c https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.1.31.zip && \
    unzip awscli-exe-linux-x86_64-2.1.31.zip && \
    ./aws/install && \
    rm -f awscli-exe-linux-x86_64-2.1.31.zip

# Install the Precommit.
RUN pip3 install pre-commit --no-cache-dir && pre-commit --version

# Install AWSume
RUN pip3 install awsume




