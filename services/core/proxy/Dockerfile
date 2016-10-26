FROM alpine:3.4
MAINTAINER ototadana@gmail.com

RUN apk add --no-cache tinyproxy

RUN sed -i -e "s/^Allow /#Allow /" /etc/tinyproxy/tinyproxy.conf

EXPOSE 8888
CMD ["/usr/sbin/tinyproxy", "-d"]
