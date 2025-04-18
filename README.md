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

---

# Server Modding Guide

## Installing Mods from Steam Workshop

### Step 1: Subscribe to Mods on Steam
1. Open Steam and navigate to the Starbound Workshop
2. Browse and subscribe to the mods you want to use on your server
3. Wait for Steam to download all subscribed mods

### Step 2: Locate the Workshop Files
Steam Workshop files for Starbound are typically located at:
```
~/.steam/steam/steamapps/workshop/content/211820/
```
(On Windows: `C:\Program Files (x86)\Steam\steamapps\workshop\content\211820\`)

### Step 3: Extract Mod Files
On Linux you can use the following script to extract all mod .pak files into a single output folder:

```bash
#!/bin/bash
# Save this as extract_mods.sh

# Navigate to your Steam Workshop content folder
cd ~/.steam/steam/steamapps/workshop/content/211820/

# Extract all mod .pak files
for file in $(find . -name "contents.pak"); do
    parent_dir=$(dirname "$file")
    parent_dir=${parent_dir##*/}
    mkdir -p ./output_folder
    cp -n "$file" "./output_folder/$parent_dir.pak"
done

echo "All mods have been extracted to output_folder"
```

Make the script executable:
```bash
chmod +x extract_mods.sh
```

Run the script:
```bash
./extract_mods.sh
```

### Step 4: Install Mods on the Server
1. Copy the extracted .pak files to your server's mods folder:

```bash
# Assuming you're in the directory containing output_folder
cp output_folder/*.pak /path/to/starbound-docker/starbound_1.4.4_linux/mods/
```

2. If using the Docker setup from this repository:
```bash
# Navigate to your starbound-docker repository
cd /path/to/starbound-docker

# Copy the mod files directly into the server's mods folder
cp /path/to/output_folder/*.pak ./starbound_1.4.4_linux/mods/

# Restart the server to apply mods
docker compose restart
```

## Troubleshooting Mods

If you experience issues with mods:

1. Check the server logs for errors:
```bash
docker compose logs -f
```

2. Ensure mod compatibility:
   - Some mods may conflict with each other
   - Some mods may need additional compatibility patches

3. Try removing mods one by one to identify problematic ones:
   - Rename mod files from `.pak` to `.pak.disabled` instead of deleting them

## Keeping Mods Updated

1. Periodically check the Steam Workshop for mod updates
2. Re-run the extraction script when mods are updated
3. Replace old mod files on your server with the updated versions
4. Restart the server to apply updates

## Warning About Mod Removal

Removing mods from a server that has active worlds can cause data loss or corruption, especially if those mods added items, blocks, or other content to the world. Always backup your server data before removing mods.

## License

This Docker configuration is provided under the MIT License. Starbound itself is owned by Chucklefish and subject to its own licensing terms.
