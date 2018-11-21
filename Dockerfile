FROM golang:alpine

# aws-cli uses 'less -R'. However less with R option is not available in alpine linux
ENV PAGER=more

# groff is required by aws-cli
RUN apk add --no-cache -v --virtual .build-deps \
    git \
    py-pip \
    && apk --no-cache -v add \
        bash \
        groff \
        jq \
        python \
        py-setuptools \
    && pip install \
        awscli==1.16.18 \
    && git clone --depth=1 https://github.com/hashicorp/terraform.git ${GOPATH}/src/github.com/hashicorp/terraform > /dev/null 2>&1 \
    && (cd ${GOPATH}/src/github.com/hashicorp/terraform; go install ./tools/terraform-bundle) \
    && rm -rf ${GOPATH}/src/github.com/hashicorp/terraform \
&& apk del .build-deps \
&& rm -rf /root/.cache \
&& rm -rf /var/cache/apk/*

WORKDIR /app

COPY src/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/tfenv"]
CMD []
