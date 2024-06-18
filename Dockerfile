FROM alpine:latest AS alpine

FROM boxboat/config-merge:latest as config-merge

FROM alpine:latest

# Add binaries from config-merge
COPY --from=config-merge /usr/local/config-merge /usr/local/config-merge
COPY --from=config-merge /usr/local/bin/config-merge /usr/local/bin/config-merge
COPY --from=config-merge /usr/local/bin/envsubst /usr/local/bin/envsubst

# Add dasel
RUN wget -O /usr/local/bin/dasel https://github.com/TomWright/dasel/releases/download/v1.27.1/dasel_linux_amd64
RUN chmod +x /usr/local/bin/dasel

# Add system packages
RUN apk add --update nodejs npm curl jq lz4 vim zstd