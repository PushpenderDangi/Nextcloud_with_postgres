# 1. Introduction
   
## 1.1 What is Nextcloud?

Nextcloud is an open-source, self-hosted cloud storage solution that allows individuals and organizations to store, manage, and share files and data securely. It provides a comprehensive suite of tools for file synchronization, sharing, collaboration, and communication.

## 1.2 Features of Nextcloud

## File Synchronization and Sharing:

Allows users to synchronize files across multiple devices and share them with others, both internally and externally.
Collaboration Tools:

Integrated tools such as Nextcloud Office (based on Collabora Online or OnlyOffice), real-time chat, and collaborative editing.
Access Control:

Detailed permission settings for file and folder access, including public sharing links with expiration and password protection.
File Versioning:

Keeps track of changes made to files, allowing users to revert to previous versions.

Security and Privacy:

End-to-end encryption, two-factor authentication, and secure file access protocols.

## Extensibility:

A wide range of apps and plugins available for extending functionality, including calendar, contacts, mail integration, and more.
Mobile and Desktop Clients: Native applications for various operating systems, including Android, iOS, Windows, macOS, and Linux.

### 1.3 Benefits of Using Nextcloud

Control and Privacy:

As a self-hosted solution, Nextcloud offers complete control over your data, ensuring privacy and compliance with data protection regulations.
Cost Efficiency: Open-source nature eliminates licensing costs associated with proprietary software.
Customization: Ability to tailor the solution to specific needs with various available apps and integrations.
Community Support: Active community and extensive documentation support users and developers.
Scalability:

Suitable for small personal use cases to large enterprise environments.

# 3. What is Podman? 
Podman is a container management tool that is compatible with Docker but offers additional features such as rootless containers. This guide will walk you through the setup of Nextcloud with a PostgreSQL database using Podman.

## 2.1 Prerequisites

Podman installed on your system
Basic familiarity with command-line operations
Access to a terminal with sudo privileges

# 4. Step-by-Step Setup

## 3.1 Pull the Nextcloud and PostgreSQL Images
   
Open a terminal and pull the necessary container images from Docker Hub:

podman pull docker.io/library/nextcloud

podman pull postgres


## 3.2. Create a PostgreSQL Container
Create a PostgreSQL container with appropriate environment variables for database initialization:
podman run -d \
	--name nextcloud-postgres\
	--network nextcloud_network \
	--env POSTGRES_DB=nextcloud \
	--env POSTGRES_USER=nextcloud \
	--env POSTGRES_PASSWORD=nextcloud \
            --volume ./postgres_data:/var/lib/postgresql/data \
	docker.io/library/postgres


POSTGRES_USER: Username for the PostgreSQL database.
POSTGRES_PASSWORD: Password for the PostgreSQL user.
POSTGRES_DB: Name of the PostgreSQL database.

## 3.3. Create a Nextcloud Container
Run the Nextcloud container, linking it to the PostgreSQL container:
podman run -d \
	--name nextcloud \
	-p 8080:80 \
	--env NEXTCLOUD_ADMIN_USER=admin \
	--env NEXTCLOUD_ADMIN_PASSWORD=admin \
	--env POSTGRES_HOST=nextcloud-postgres \
	--env POSTGRES_DB=nextcloud \
	--env POSTGRES_USER=nextcloud \
	--env POSTGRES_PASSWORD=nextcloud \
	--volume ./nextcloud_data:/var/www/html \
	--network nextcloud_network \
	docker.io/library/nextcloud


NEXTCLOUD_ADMIN_USER: Credentials for the Nextcloud admin account.
NEXTCLOUD_ADMIN_PASSWORD: Credentials for the Nextcloud admin account.

## 3.4. Access Nextcloud
Once both containers are running, access the Nextcloud instance via a web browser:
http://localhost:8080

You should see the Nextcloud setup page. Follow the on-screen instructions to complete the configuration.

# 4. Troubleshooting
Container Logs: Use podman logs <container_name> to view logs if issues arise.
Container Status: Check running containers with podman ps.
Port Conflicts: Ensure that port 8080 is available on your host machine or modify it as needed.
