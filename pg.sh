#1/bin/bash

podman run -d \
	--name db \
	--volume ./postgres_data:/var/lib/postgresql/data \
	--env POSTGRES_DB=nextcloud \
	--env POSTGRES_USER=nextcloud \
	--env POSTGRES_PASSWORD=nextcloud \
	--network nextcloud_network \
	docker.io/library/postgres
