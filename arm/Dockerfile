FROM pihole/pihole:latest

LABEL maintainer="Elton Kuzniewski"
LABEL url="https://github.com/eltonk/pihole-dot-doh"

# Install and configure cloudflared
RUN /bin/bash -c 'cd /tmp; \
apt-get update; \
apt-get install wget -y; \
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm; \
mv ./cloudflared-linux-arm /usr/local/bin/cloudflared; \
chmod +x /usr/local/bin/cloudflared;'

COPY ../config.yml /etc/cloudflared/config.yml

RUN /bin/bash -c 'mkdir -p /etc/services.d/cloudflared; \
echo "#!/usr/bin/with-contenv bash" > /etc/services.d/cloudflared/run; \
echo "s6-echo Starting cloudflared" >> /etc/services.d/cloudflared/run; \
echo "/usr/local/bin/cloudflared --config /etc/cloudflared/config.yml" >> /etc/services.d/cloudflared/run; \
echo "#!/usr/bin/with-contenv bash" > /etc/services.d/cloudflared/finish; \
echo "s6-echo Stopping cloudflared" >> /etc/services.d/cloudflared/finish; \
echo "killall -9 cloudflared" >> /etc/services.d/cloudflared/finish;'

