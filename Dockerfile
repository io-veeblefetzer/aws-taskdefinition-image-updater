FROM alpine:3.19

# Install bash
RUN apk add --update --no-cache bash

# Install jq
RUN apk add --update --no-cache jq

# Install AWS Cli
RUN apk add --update --no-cache aws-cli

# Copy the script
COPY pipe.sh /

ENTRYPOINT ["/pipe.sh"]
