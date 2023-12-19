FROM alpine:3.17 AS verify
RUN apk add --no-cache curl tar xz

RUN ROOTFS=$(curl -sfOJL -w "amzn2-container-raw-2.0.20231218.0-arm64.tar.xz" "https://amazon-linux-docker-sources.s3.amazonaws.com/amzn2/2.0.20231218.0/amzn2-container-raw-2.0.20231218.0-arm64.tar.xz") \
  && echo 'efcb7ae5505f570b3059bb542a1dd70769ac25f041dba58ecd4eb2c343120463  amzn2-container-raw-2.0.20231218.0-arm64.tar.xz' >> /tmp/amzn2-container-raw-2.0.20231218.0-arm64.tar.xz.sha256 \
  && cat /tmp/amzn2-container-raw-2.0.20231218.0-arm64.tar.xz.sha256 \
  && sha256sum -c /tmp/amzn2-container-raw-2.0.20231218.0-arm64.tar.xz.sha256 \
  && mkdir /rootfs \
  && tar -C /rootfs --extract --file "${ROOTFS}"

FROM scratch AS root
COPY --from=verify /rootfs/ /

CMD ["/bin/bash"]
