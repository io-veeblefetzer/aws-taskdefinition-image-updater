FROM alpine:3.9

RUN apk add --update --no-cache bash

# Install jq
RUN apk add --update --no-cache jq

# Copy AWS CLI from the official image
COPY --from=ghcr.io/spacelift-io/aws-cli-alpine:2.18.15 /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=ghcr.io/spacelift-io/aws-cli-alpine:2.18.15 /aws-cli-bin/ /usr/local/bin/

# Copy the script
COPY pipe.sh /

ENTRYPOINT ["/pipe.sh"]
