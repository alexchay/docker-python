# Python Docker Image

This repository contains a Docker image for Python development. It is designed to provide a consistent and reproducible environment for Python applications.

[![validate](https://github.com/alexchay/docker-python/actions/workflows/validate.yml/badge.svg)](https://github.com/alexchay/docker-python/actions/workflows/validate.yml)

## Features

- Based on the official Python Docker image
- Python environment managed with Docker.
- Pre-configured for development and testing.

## Getting Started

### Prerequisites

- Docker installed on your machine
- Taskfile CLI installed on your machine

### Building the Image

To build the Docker image, run the following command:

```sh
git checkout 3.9-slim
task build-image
```

### Running a Container

To run a container using the built image, use the following command:

```sh
docker run -it --rm python:3.9-slim
```

## Customization

You can customize the Docker image by modifying the `Dockerfile` and adding any additional dependencies or configurations needed for your project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
