# Docker pihole-dot-doh
Official Pi-hole docker image along with both DoT (DNS over TLS) and DoH (DNS over HTTPS).

<p align="center">
<a href="https://pi-hole.net"><img src="https://pi-hole.github.io/graphics/Vortex/Vortex_with_text.png" width="150" height="255" alt="Pi-hole"></a><br/>
</p>
<!-- Delete above HTML and insert markdown for dockerhub : ![Pi-hole](https://pi-hole.github.io/graphics/Vortex/Vortex_with_text.png) -->

## Quick Start
1. Copy docker-compose.yml.example to docker-compose.yml and update as needed. See example below:
[Docker-compose](https://docs.docker.com/compose/install/) example:
```yaml
version: "3"

# More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
services:
  pihole-dot-doh:
    container_name: pihole-dot-doh
    image: eltonk/pihole-dot-doh:latest
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
      - "443:443/tcp"
    environment:
      # This activates the DoT-DoH features. This activates the DoT-DoH features. If you comment on this, the Pi-hole will act only as blocking ads.
      PIHOLE_DNS_: '127.0.0.1#5053'
      # Set your timezone
      TZ: 'America/Chicago'
      # WEBPASSWORD: 'uncomment and set a secure password here or it will be random'
    # Volumes store your data between container upgrades
    volumes:
      - './etc-pihole/:/etc/pihole/'
      - './etc-dnsmasq.d/:/etc/dnsmasq.d/'
    # Recommended but not required (DHCP needs NET_ADMIN)
    #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
    cap_add:
      - NET_ADMIN
    restart: unless-stopped
```
2. Run `docker-compose up --detach` to build and start pi-hole
