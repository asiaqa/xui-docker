FROM alpine:edge
#FROM node:alpine
#ENV USER=ezjc
ENV AUUID="143a9766-4477-5b16-ad4e-5f8020b42f7c" \
#ARG CADDYIndexPage="https://github.com/AYJCSGM/mikutap/archive/master.zip" 
 CADDYIndexPage="https://github.com/asiaqa/asset/raw/main/webpage-master.zip" \
 ParameterSSENCYPT="chacha20-ietf-poly1305" \
 MYPATH="ckczjc" \
 PORT=80 \
 FRP_SITE="" \
 FRP_USER="admin" \
 FRP_PORT=80 \
 DNS=53 \
 FRP_PASS="ckczjc" \
 FRP_PROTO="websocket" \
 FRP_RP=6050 \
 FRP_SSH=2050 \
 FRP_NAME="ckczjc" \
 SSS="G5oBIXH2JvLNw97XOCkCTw==" \
 TZ="Asia/Chongqing" \
 AGF="https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.11/AdGuardHome_linux_amd64.tar.gz" \
 FRPF="https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_amd64.tar.gz" \
 SH_S=0 \
 SH_PASS="password" \
 TUNNEL_TOKEN=""
ARG SH_USER="mp"
ARG SH_PASS="password"
# Password has to be no speical string, such as '/', '\'. command: openssl rand -base64 16
ARG XRAY_LINK="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
#ARG XRAY_LINK="https://github.com/XTLS/Xray-core/releases/download/v1.5.10/Xray-linux-64.zip"
ENV FRP_S=0
COPY etc/Caddyfile /caddy/Caddyfile
COPY etc/Caddyfile /etc/caddy/Caddyfile
COPY etc/AdGuardHome.yaml /tmp/AdGuardHome.yaml 
COPY etc/x.json /tmp/x.json 
COPY start.sh /start.sh
COPY start1.sh /start1.sh 
COPY etc/config.ini /tmp/config.ini 
COPY stupid.sh /stupid.sh 
COPY etc/fb.sh /tmp/fb.sh
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget su-exec ttyd tzdata && \
    apk add --no-cache nano net-tools openssh busybox-suid bind-tools && \
    #adduser -h /home/$SH_USER -s /bin/sh -D $SH_USER && \
    #echo -n $SH_USER:$SH_PASS | chpasswd && \
    adduser -D $SH_USER -h /home/$SH_USER -s /bin/sh && mkdir -p /etc/sudoers.d && \
    #echo "$SH_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/SH_USER && \
    #chmod 0440 /etc/sudoers.d/SH_USER && \
    #a_pass=$(echo $MY_PATH | mkpasswd) && \
    #echo "root:${a_pass}" | chpasswd && \
    echo "root:$MYPATH" | chpasswd && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
#RUN addgroup -S $USER && adduser -S $USER -G $USER
#USER $USER
#RUN && \
    mkdir -p /cf/ && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /cf/cloudflared && chmod +x /cf/cloudflared && \
    wget -O XX.zip $XRAY_LINK && \
    unzip XX.zip && \
    cp /xray /x && rm /xray && \
    chmod +x /x && chmod +x /stupid.sh && \
    rm -rf /var/cache/apk/* && \
    rm -f XX.zip && \
    mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
    wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
    wget -O aguard.tar.gz $AGF && \
    tar -xvzf aguard.tar.gz && rm *.tar.gz && mkdir /ag/ && cp /AdGuardHome/AdGuardHome /ag/adguard && \
    rm -rf AdguardHome && cp /tmp/AdGuardHome.yaml /ag/ && cp /tmp/x.json /x.json && \ 
    wget -O frp.tar.gz $FRPF && \
    chmod +x /start.sh && chmod +x /start1.sh && \
    tar -xvzf frp.tar.gz && rm *.tar.gz && mkdir frp && cp /frp*/frpc /frp/frpc && rm -rf frp_* && cp /tmp/config.ini /frp/frpc.ini && \
    mkdir /fb/ && cp /tmp/fb.sh /fb/fb.sh && chmod +x /fb/fb.sh && wget -qO - https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser.tar.gz | tar -zxf - -C /fb/ 
    # echo '@reboot sleep 120 && echo "nameserver 127.0.0.1" > /etc/resolv.conf' >> /etc/crontabs/root 
    # download Filebrowser

CMD /start.sh
