
#

## Python Docker Image

This repository contains the source for building container image for development and testing of Python applications.

[![Dockerfile](https://github.com/alexchay/docker-python/actions/workflows/dockerfile-check.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/dockerfile-check.yml) [![Shell scripts](https://github.com/alexchay/docker-python/actions/workflows/shellscripts-check.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/shellscripts-check.yml) [![Matrix Build](https://github.com/alexchay/docker-python/actions/workflows/build-matrix.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/build-matrix.yml)

#### Features

- Includes common Python development tools and libraries
- Python environment managed with Docker.
- Pre-configured for development and testing.

#### Prerequisites

- Docker installed on your machine
- [Taskfile CLI](https://taskfile.dev) installed on your machine

### Build

Automated builds are setup for the repository and the matrix of base images and python versions are listed in the `matrix.yml` file.
The image is tagged with the python backend/version and a matching `python` version, e.g.:

- ghcr.io/alexchay/python:3.11-slim
- ghcr.io/alexchay/python:3.10.17

Images are built for `linux/amd64` and `linux/arm64` architectures.

You can build the images locally using the `task` command:

```sh
git checkout 3.10-slim
task build-image
```

### Usage

Can be used as a base image for container images with the required python modules/application or as a standalone container for running python application.
To run a container using the built image, use the following command:

```sh
docker run -it --rm python:3.9-slim
```

## Customization

You can customize the Docker image by modifying the `Dockerfile` and adding any additional dependencies or configurations needed for your project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
