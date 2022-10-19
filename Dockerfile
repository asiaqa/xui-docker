FROM alpine:edge
#FROM node:alpine
#ENV USER=ezjc
ENV FL="https://github.com/FranzKafkaYu/x-ui/releases/download/0.3.3.16-0814/x-ui-linux-amd64.tar.gz" \
    KFAT=""

#COPY etc/Caddyfile /caddy/Caddyfile
#COPY etc/Caddyfile /etc/caddy/Caddyfile
#COPY etc/AdGuardHome.yaml /tmp/AdGuardHome.yaml 
#COPY etc/x.json /tmp/x.json 
#COPY start.sh /start.sh
#COPY start1.sh /start1.sh 
#COPY etc/config.ini /tmp/config.ini 
#COPY stupid.sh /stupid.sh 
#COPY etc/fb.sh /tmp/fb.sh
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget su-exec ttyd tzdata && \
    apk add --no-cache nano net-tools openssh busybox-suid bind-tools && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
    wget -O xui.tar.gz $FL && \
    tar -xvzf xui.tar.gz && rm *.tar.gz && mkdir /xui/ && cp /x-ui/bin/* /xui/ && rm -rf x-ui

    
#    mkdir -p /cf/ && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /cf/cloudflared && chmod +x /cf/cloudflared && \
#    wget -O XX.zip $XRAY_LINK && \
#    unzip XX.zip && \
#    cp /xray /x && rm /xray && \
#    chmod +x /x && chmod +x /stupid.sh && \
#    rm -rf /var/cache/apk/* && \
#    rm -f XX.zip && \
#    mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
#    wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
#    wget -O aguard.tar.gz $AGF && \
#    tar -xvzf aguard.tar.gz && rm *.tar.gz && mkdir /ag/ && cp /AdGuardHome/AdGuardHome /ag/adguard && \
#    rm -rf AdguardHome && cp /tmp/AdGuardHome.yaml /ag/ && cp /tmp/x.json /x.json && \ 
#    wget -O frp.tar.gz $FRPF && \
#    chmod +x /start.sh && chmod +x /start1.sh && \
#    tar -xvzf frp.tar.gz && rm *.tar.gz && mkdir frp && cp /frp*/frpc /frp/frpc && rm -rf frp_* && cp /tmp/config.ini /frp/frpc.ini && \
#    mkdir /fb/ && cp /tmp/fb.sh /fb/fb.sh && chmod +x /fb/fb.sh && wget -qO - https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser.tar.gz | tar -zxf - -C /fb/ 
    # echo '@reboot sleep 120 && echo "nameserver 127.0.0.1" > /etc/resolv.conf' >> /etc/crontabs/root 
    # download Filebrowser

CMD [ "/xui/x-ui" ]
