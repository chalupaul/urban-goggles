FROM hashicorp/terraform:light
ADD VERSION .

RUN apk add --update bash curl python py-pip openssl ca-certificates git groff zip && \
    pip install --upgrade pip awscli && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["sh", "-c"]
CMD ["bash"]
