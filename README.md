# nginx-rtmp-docker [![Deploy](https://github.com/kaylendog/nginx-rtmp-docker/workflows/Deploy/badge.svg)](https://github.com/kaylendog/nginx-rtmp-docker/actions?query=workflow%3ADeploy)

[**Docker**](https://www.docker.com/) image with [**NGINX**](http://nginx.org/en/) using the [**nginx-rtmp-module**](https://github.com/arut/nginx-rtmp-module) module for live multimedia (video) streaming.

## Description

This image can be used to create an RTMP server for multimedia / video streaming using [**NGINX**](http://nginx.org/en/) and [**nginx-rtmp-module**](https://github.com/arut/nginx-rtmp-module), compiled from the latest sources (NGINX 1.21.6 and nginx-rtmp-module 1.2.2).

This repository is a fork of [tiangolo/nginx-rtmp-docker](https://github.com/tiangolo/nginx-rtmp-docker) with multi-arch support and a vastly smaller image (over 800mb smaller).

### Supported Architectures

This image currently targets the following architectures:

- linux/amd64
- linux/arm64

If you wish to add support for additional architectures, please [submit a pull request](https://github.com/tiangolo/nginx-rtmp-docker/compare/)!

## Example Usage

For the simplest case, just run a container with this image:

```bash
docker run -d -p 1935:1935 skyefuzz/nginx-rtmp
```

## Configuration

The default configuration is as follows:

```Nginx
worker_processes auto;
rtmp_auto_push on;
events {}
rtmp {
    server {
        listen 1935;
        listen [::]:1935 ipv6only=on;

        application live {
            live on;
            record off;
        }
    }
}

http {
    server {
        listen 80;
        listen [::]:80 ipv6only=on;

        location / {
            rtmp_stat all;
        }
    }
}
```

You can specify custom configuration for the RTMP server by either

- Mounting a custom config file at `/etc/nginx/nginx.conf`
- Creating a Dockerfile and copying a config file to `/etc/nginx/nginx.conf`

The [`nginx-rtmp-module` documentation](https://github.com/arut/nginx-rtmp-module/wiki/Directives) provides a list of directives you can use in your configuration, as well as a couple of helpful examples.

### Using a Dockerfile

```Dockerfile
FROM skyefuzz/nginx-rtmp
COPY nginx.conf /etc/nginx/nginx.conf
```

### Using volume mounts

```bash
docker run -d -p 1935:1935 -v ./nginx.conf:/etc/nginx/nginx.conf skyefuzz/nginx-rtmp
```

## Technical details

- This image is based on the `alpine` image, allowing it to be less than 10mb in size when compressed.
- The image is built from the official sources of **NGINX** and **nginx-rtmp-module** without any unnecessary dependencies.

## License

This project is licensed under the terms of the MIT License. For more information, see the [LICENSE](./LICENSE) file.
