<div align="center">
  <h1>
    <br/>
    <img src="notebook.svg" width="100"/>
    <br />
    standalone-rpi
    <br />
  </h1>
  Standard Notes Syncing Infrastructure for the Raspberry Pi
  <br />
  <br />
  <br />
</div>

## Installation

```bash
git clone https://github.com/agmm/standalone-rpi.git && cd standalone-rpi && sudo bash ./install.sh
```

## Usage

To connect to the syncing server, go to `Account > Register > Advanced Options` and set the sync domain to `https://raspberrypi.local`. Keep in mind that the mobile app version of Standard Notes does not work with self-signed certificates. To connect to the server from the mobile app you need to follow the next section.

## HTTPS

By default, the current template encrypts requests to `https://raspberrypi.local` with a self-signed certificate generated by [Caddy](https://caddyserver.com/docs/). You can add a custom domain by modifying the `Caddyfile` and supplying the corresponding certificate and key. For more information on how to do that, see this [guide](#).

## Commands

To control the Standard Notes infrastructure, execute the following commands inside the repo directory.

- To start the server: `sudo bash ./server.sh start`
- To stop the server: `sudo bash ./server.sh stop`
- To see the status: `sudo bash ./server.sh status`
- To see the logs: `sudo bash ./server.sh logs`

## Suggestions

In order to be able to access your Standard Notes server from anywhere, without exposing it directly to the internet, we suggest the use of [Tailscale](https://tailscale.com/).

The general setup would be the following:

- Tailscale running on the RPi
- Tailscale running on your devices
- An external domain pointing to the Tailscale IP of the RPi
- Caddy configured to handle requests from that domain

<!-- ## Extensions
To add extensions: go to `Extensions` and paste `https://snext.netlify.app/index.json` where it asks for your "Extended Activation Code". -->

## License

Copyright (c) 2021 Arnaldo Gabriel

This project is licensed under the [MIT License](LICENSE).
