# Docker pihole-doh
Official Pi-hole docker image along with DoH (DNS over HTTPS) powered by Cloudflare.

<p align="center">
<a href="https://pi-hole.net"><img src="https://pi-hole.github.io/graphics/Vortex/Vortex_with_text.png" width="150" height="255" alt="Pi-hole"></a><br/>
</p>
<!-- Delete above HTML and insert markdown for dockerhub : ![Pi-hole](https://pi-hole.github.io/graphics/Vortex/Vortex_with_text.png) -->

## Docker tags
I have build this docker image using the arm architecture and for amd64.<br>
<br>
To use in your Raspberry Pi docker, please, refer to the tag <b>latest-arm</b><br>
To use in a linux/windows docker container, please refer to the tag <b>latest-amd64</b><br>

## Quick Start
You have some options how to start the docker container. 

### In you Raspberry Pi console, you can run the following Docker command:
```shell
docker run -d --name='Pihole-DoH' \
-e TZ="Europe/Berlin" \
-e 'PIHOLE_DNS_'='127.0.0.1#5053' \
-e 'WEBPASSWORD'='password123' \
-p '53:53/tcp' \
-p '53:53/udp' \
-p '67:67/udp' \
-p '80:80/tcp' \
-p '443:443/tcp' \
-v './etc-dnsmasq.d/':'/etc/pihole/':'rw' \
-v './etc-dnsmasq.d/':'/etc/dnsmasq.d/':'rw' \
--restart=unless-stopped \
'eltonk/pihole-doh:latest-arm'
```

### You also can use a docker-compose style
[Docker-compose](https://docs.docker.com/compose/install/) example:

```yaml
version: "3"

# More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
services:
  pihole-dot-doh:
    container_name: pihole-doh
    image: eltonk/pihole-doh:latest-arm
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
      - "443:443/tcp"
    environment:
      # This activates the DoH feature. If you comment on this, the Pi-hole will only act as blocking ads.
      PIHOLE_DNS_: '127.0.0.1#5053'
      # Set your timezone
      TZ: 'Europe/Berlin'
      WEBPASSWORD: 'password123' #change your password, otherwise the default password is 'password123'
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
Run `docker-compose up --detach` to start the pihole-doh container.

## Testing your configuration
To test your configuration, after proper configured the new DNS adress in your router or computer, go to the following page:
https://1.1.1.1/help

You should note the line "<b>Using DNS over HTTPS (DoH)</b>" flagged as <b>Yes</b>.

## More info
This docker container is based on the official pihole/pihole docker container.

To see more configurations options, please check the official documentation at: https://hub.docker.com/r/pihole/pihole 
