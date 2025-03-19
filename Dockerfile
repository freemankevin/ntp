FROM alpine:latest

RUN apk add --no-cache \
    chrony \
    curl \
    wget \
    net-tools \
    busybox-extras

EXPOSE 123/udp
VOLUME /etc/chrony

HEALTHCHECK --interval=30s --timeout=3s \
  CMD chronyc tracking || exit 1

ENTRYPOINT ["chronyd"]
CMD ["-d", "-f", "/etc/chrony/chrony.conf"]