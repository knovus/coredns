FROM debian:stable-slim

RUN apt-get update && apt-get -uy upgrade
RUN apt-get -y install ca-certificates wget && update-ca-certificates
RUN wget https://github.com/knovus/coredns/releases/download/v1.6.9/coredns-386 -O /tmp/coredns

FROM scratch

COPY --from=0 /etc/ssl/certs /etc/ssl/certs
COPY --from=0 /tmp/coredns /coredns
#ADD coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
