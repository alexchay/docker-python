
#

## Python Docker Image

This repository contains the source for building a Docker image for development and testing of Python applications.

[![Dockerfile](https://github.com/alexchay/docker-python/actions/workflows/dockerfile-check.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/dockerfile-check.yml) [![Shell scripts](https://github.com/alexchay/docker-python/actions/workflows/shellscripts-check.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/shellscripts-check.yml) [![Matrix Build](https://github.com/alexchay/docker-python/actions/workflows/build-matrix.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/build-matrix.yml)

#### Features

- Installs common development tools and libraries
- Multi-architecture support: `linux/amd64` and `linux/arm64`
- Automated builds and matrix builds for multiple Python versions
- Pre-configured for easy extension and customization

#### Prerequisites

- Docker installed on your machine
- [Taskfile CLI](https://taskfile.dev) installed on your machine

### Build

Automated builds are configured via GitHub Actions. The build matrix is defined in [`.github/matrix.yml`](.github/matrix.yml), specifying Python versions and tags.
The image is tagged with the python backend/version and a matching `python` version, e.g.:

- ghcr.io/alexchay/python:3.11-slim
- ghcr.io/alexchay/python:3.10.17

Images are built for `linux/amd64` and `linux/arm64` architectures.

### Usage

Can be used as a base image for container images with the required python modules/application or as a standalone container for running python application.
To run a container using the built image, use the following command:

```sh
docker run -it --rm python:3.9-slim
```

#### Customization

To customize the Docker image:

- Edit the `Dockerfile` to add or remove dependencies and tools.
- Modify [`.github/matrix.yml`](.github/matrix.yml) to adjust the build matrix.
- Use `Taskfile.yml` to automate common tasks (build, lint, test, etc.).

#### Versioning

This project uses CalVer (calendar versioning) managed by [bump-my-version](https://github.com/callowayproject/bump-my-version). See [pyproject.toml](pyproject.toml) for configuration.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
