# xui-docker

mkdir -p /root/x-ui && cd /root/x-ui/
docker run -d --network=host -v /root/x-ui/db/:/etc/x-ui/ -v /root/x-ui/cert/:/root/cert/ --name x-ui --restart=unless-stopped asiaqa/xui-docker:latest

