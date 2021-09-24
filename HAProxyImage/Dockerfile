FROM haproxy:latest
WORKDIR /usr/local/etc/haproxy
COPY haproxy.cfg .
CMD [ "haproxy", "-f", "haproxy.cfg" ]
EXPOSE 80
EXPOSE 8404