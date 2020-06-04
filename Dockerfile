FROM alpine:3.11
RUN apk --no-cache add ca-certificates tzdata
RUN set -ex; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64) arch='amd64' ;; \
		x86) arch='386' ;; \
		*) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
	esac; \
	wget --quiet -O /coredns "https://github.com/knovus/coredns/releases/download/v1.6.9/coredns-$arch"; \
	chmod +x /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
