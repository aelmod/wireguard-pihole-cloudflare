# Installing Wireguard, PiHole, Cloudflared VPN

## Overview
This repository offers a solution for configuring your personal Wireguard VPN server with PiHole to block malicious and advertising DNS requests, along with a Cloudflared tunnel for DNS over HTTPS.

Inspired by: https://github.com/jbencina/vpn

## Docker Install
We'll be using Docker Compose to run Wireguard/PiHole/Cloudflared. 
Follow the standard install guides appropriate for your server to install Docker: 
https://docs.docker.com/engine/install/ubuntu/

## Clone repository
```bash
git clone https://github.com/aelmod/wireguard-pihole-cloudflare.git wireguard
cd wireguard
```

## Wireguard Setup
To ensure a simple setup in the `docker-compose.yml`, you must modify the `SERVERURL` parameter by substituting it with your domain or IP address. Additionally, adjust the `TZ` parameter to specify the timezone you intend to use. 
I highly recommend acquainting yourself with all the parameters and settings, which can be found in this repository:

https://github.com/linuxserver/docker-wireguard#parameters

## Pihole Setup
In `docker-compose.yml` adjust the `TZ` parameter to specify the timezone you intend to use.

## Kick off the service:
```bash
docker compose up -d
```

## Pihole Admin Panel
To create a password for the PiHole Admin, you need to run the docker compose interactive shell for the PiHole container using the command `docker compose exec pihole bash`.
Once you are in the shell, execute the command `pihole -a -p`. This command will prompt you to enter a new password for the PiHole Admin.
It is recommended to use a strong password, and you can use a password generator to create one.
After setting the password, you can access the PiHole Admin Panel by opening a web browser and navigating to:

http://172.20.0.2/admin/ 

## Whitelist (optional)
Before we leave the interactive shell, I recommend running the `pihole_apple_whitelist.sh` script and execute the command it generated from whatever txt file you prefer.
This command will add Apple services to the white list, so Apple services and devices will work without violations.
You can also browse this topic (where I found this [script] by [foresthus]) to find solutions to problems that may arise after blocking domains, for example how to whitelist `s.youtube.com` so as not to break your YouTube watch history:

https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212

## Verify
Now connect to Wireguard from your client and enjoy ad free browsing. To verify that DNS over HTTPS (DoH) is working as expected, visit:

https://1.1.1.1/help

This website is operated by Cloudflare, which provides a DNS resolver that supports DNS over HTTPS. By accessing this URL, you can get information about your current DNS configuration and check if DoH is enabled and functioning correctly.

## Conclusion
We utilize a Docker compose setup to run these services, which involves the creation of three Docker containers.
These containers serve different purposes:

 - One container hosts Cloudflared DNS over HTTPS.
 - Another container hosts PiHole, utilizing a specific Docker image.
 - The third container hosts Wireguard VPN.

Each container is assigned a static IP address, and PiHole is configured to utilize the [Cloudflared] DNS resolver.

[Cloudflared]: <https://github.com/cloudflare/cloudflared>
[script]: <https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212/147>
[foresthus]: <https://discourse.pi-hole.net/u/foresthus>
