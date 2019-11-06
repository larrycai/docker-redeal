#
# Docker image for https://github.com/anntzer/redeal
# 
FROM python:3.7.5-slim-buster as base

FROM base as builder
RUN mkdir /install

RUN apt-get update && apt-get install -y g++ make git libboost-all-dev procps
RUN python -mpip install --install-option="--prefix=/install" --upgrade git+https://github.com/anntzer/redeal

FROM base

LABEL org.opencontainers.image.title="Antony's deal generator" \
      org.opencontainers.image.url="https://github.com/larrycai/docker-redeal" \
      org.opencontainers.image.authors="Larry Cai"

# if redeal-gui is not needed, comment below
RUN apt-get update && apt-get install -y tk && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local
