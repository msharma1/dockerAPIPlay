FROM debian:buster-slim

RUN apt-get update \
 && apt-get -y --no-install-recommends install \
    jq \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ip_forecast.sh /data/ip_forecast.sh
ENTRYPOINT ["/data/ip_forecast.sh"]

