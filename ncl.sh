#!/bin/bash

podman run -d \
	--name nextcloud1 \
	-p 8090:80 \
	--env NEXTCLOUD_ADMIN_USER=admin \
	--env NEXTCLOUD_ADMIN_PASSWORD=admin \
	--env POSTGRES_HOST=db \
	--env POSTGRES_DB=nextcloud \
	--env POSTGRES_USER=nextcloud \
	--env POSTGRES_PASSWORD=nextcloud \
	--volume ./nextcloud_data:/var/www/html \
	--network nextcloud_network \
	docker.io/library/nextcloud
