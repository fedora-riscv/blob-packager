FROM docker.io/fedorariscv/base:latest

WORKDIR /

RUN dnf install -y rpm-build findutils tar gzip sed coreutils

COPY ./package.sh /package.sh

RUN chmod +x /package.sh

ENTRYPOINT ["/package.sh"]
