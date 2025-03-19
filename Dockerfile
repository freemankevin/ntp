FROM alpine:latest

RUN apk add --no-cache \
    chrony \
    curl \
    wget \
    net-tools \
    busybox-extras \
    tzdata


ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 123/udp
VOLUME /etc/chrony


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=30s --timeout=3s \
  CMD chronyc tracking || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-d", "-f", "/etc/chrony/chrony.conf"]