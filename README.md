# Dockerized Starbound Server

This repository contains everything needed to run a Starbound server in a Docker container. The setup is designed to work on Debian-based systems but should be compatible with any system that supports Docker.

## Prerequisites

- Docker and Docker Compose installed on your system
- Starbound game files for Linux (from Steam or Humble Bundle)

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/starbound-docker.git
   cd starbound-docker
   ```

2. Obtain Starbound Linux files:
   - From Steam: Navigate to your Steam library, find Starbound, right-click and go to Properties → Local Files → Browse. Copy the `linux` folder and all necessary game files.
   - From Humble Bundle: Download the Linux version of Starbound from your Humble Bundle library.

3. Place the Starbound Linux files in the repository:
   - Create a directory named `starbound_1.4.4_linux` (or replace with your version)
   - Copy all Starbound Linux files into this directory
   - The final structure should look like:
     ```
     starbound-docker/
     ├── docker-compose.yml
     ├── Dockerfile
     ├── README.md
     └── starbound_1.4.4_linux/
         ├── assets/
         ├── linux/
         ├── storage/
         └── ...
     ```

4. Configure your server:
   - Edit the server configuration file located at:
     ```
     starbound_1.4.4_linux/storage/starbound_server.config
     ```
   - Here you can modify server name, password, and other settings as needed

## Running the Server

### Start the server:
```bash
docker compose up -d
```
This will build the Docker image and start the server in detached mode.

### View server logs:
```bash
docker compose logs -f
```
Press Ctrl+C to exit log view while keeping the server running.

### Stop the server:
```bash
docker compose down
```

### Restart the server:
```bash
docker compose restart
```

### Rebuild and restart (after Dockerfile changes):
```bash
docker compose up -d --build
```

## Port Information

The server runs on port 21025, which is exposed to the host system as defined in the docker-compose.yml file.

## Updating Starbound

When a new version of Starbound is released:

1. Stop the server
2. Update your Starbound files in the `starbound_1.4.4_linux` directory (or rename to match new version)
3. Update the directory name in docker-compose.yml if needed
4. Restart the server

## Troubleshooting

- If the server doesn't start, check the logs with `docker compose logs`
- Verify that you have the correct Linux version of Starbound
- Ensure your firewall allows traffic on port 21025

## License

This Docker configuration is provided under the MIT License. Starbound itself is owned by Chucklefish and subject to its own licensing terms.
