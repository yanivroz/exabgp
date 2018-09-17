FROM alpine:latest

MAINTAINER Yaniv Rozenboim <yanivr@radware.com>

RUN apk add --no-cache bash python3\
    && pip3 install --upgrade pip \
    && pip3 install exabgp \
    && mkdir -p /etc/exabgp \
    && exabgp --fi > /etc/exabgp/exabgp.env \
    && sed -i 's/bind = .*/bind = 0.0.0.0/' /etc/exabgp/exabgp.env

ADD exabgp.conf http_api.py /etc/exabgp/
ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh /etc/exabgp/http_api.py

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 179
EXPOSE 5001
