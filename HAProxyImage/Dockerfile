FROM haproxy:latest
WORKDIR /etc/haproxy
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
VOLUME [ "/haproxy" ]
CMD [ "bash", "/haproxy-start" ]
EXPOSE 80