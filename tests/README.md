<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Chaskiq, verified and packaged by Elestio

A better community platform for the modern web.

[Chaskiq](https://github.com/chaskiq/chaskiq)Free & Source Available Messaging Platform for Marketing, Support & Sales.

<img src="https://github.com/elestio-examples/chaskiq/raw/main/chaskiq.png" alt="Chaskiq" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/chaskiq">fully managed chaskiq</a> on <a target="_blank" href="https://elest.io/">elest.io</a> Free & Source Available Messaging Platform for Marketing, Support & Sales .

[![deploy](https://github.com/elestio-examples/chaskiq/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/chaskiq)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/chaskiq.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

    mkdir -p ./datastorage
    chown -R 1000:1000 ./datastorage

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6743`

## Docker-compose

Here are some example snippets to help you get started creating a container.

      
    version: "3.3"
    services:
    server:
        image: elestio4test/chaskiq:${SOFTWARE_VERSION_TAG}
        restart: always
        ports:
        - 172.17.0.1:6734:3000
        env_file:
        - ./.env
        command: bundle exec rails server -b 0.0.0.0 -p 3000
        volumes:
        - ./datastorage:/usr/src/app/datastorage
        depends_on:
        - db
        - redis

    worker:
        image: elestio4test/chaskiq:${SOFTWARE_VERSION_TAG}
        restart: always
        env_file:
        - ./.env
        command: bundle exec sidekiq -C config/sidekiq.yml
        depends_on:
        - db
        - redis

    db:
        image: elestio4test/postgres:15
        restart: always
        ports:
        - "172.17.0.1:5822:5432"
        environment:
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: ${ADMIN_PASSWORD}
        POSTGRES_DB: chaskiq
        volumes:
        - ./storage/pgdata:/var/lib/postgresql/data/

    redis:
        image: elestio4test/redis:7.0
        restart: always
        env_file:
        - ./.env
        volumes:
        - "./storage/redis-data:/data"
        command: ["redis-server", "--requirepass", "${REDIS_PASSWORD}"]

    pgadmin4:
        image: dpage/pgadmin4:latest
        restart: always
        environment:
        PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
        PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
        PGADMIN_LISTEN_PORT: 8080
        ports:
        - "172.17.0.1:8869:8080"
        volumes:
        - ./servers.json:/pgadmin4/servers.json


### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
| ADMIN_EMAIL          | your-mail-id    |
| ADMIN_PASSWORD       | password        | 
| REDIS_PASSWORD       | password        | 





# Maintenance

## Logging

The Elestio Chaskiq Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://api-docs.chaskiq.io/docs/intro.html">Chaskiq documentation</a>

- <a target="_blank" href="https://github.com/chaskiq/chaskiq">Chaskiq Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/chaskiq">Elestio/chaskiq Github repository</a>
