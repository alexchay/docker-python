ARG PYTHON_VERSION="defval"
ARG BASE_IMAGE_NAME="defval"
ARG BASE_IMAGE_TAG="defval"

FROM ghcr.io/astral-sh/uv:0.8-python$PYTHON_VERSION-bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_NO_MANAGED_PYTHON=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_CACHE_DIR=root/.cache/uv

WORKDIR /app
#COPY pyproject.toml uv.lock /app/

ENV PYTHONMALLOC=malloc
RUN \
    --mount=type=cache,target=root/.cache/uv \
    export UV_TOOL_BIN_DIR="$HOME/.local/bin" \
    && uv tool install go-task-bin

RUN \
    --mount=type=cache,target=root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-default-groups --no-dev --no-editable

FROM hashicorp/envconsul:0.13 AS envconsul

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

LABEL \
    org.opencontainers.image.authors="Alexander Chaykovskiy  https://github.com/alexchay" \
    org.opencontainers.image.created=2025-07-31T19:56:37Z \
    org.opencontainers.image.url=https://github.com/alexchay/docker-python \
    org.opencontainers.image.documentation=https://github.com/alexchay/docker-python\
    org.opencontainers.image.source=https://github.com/alexchay/docker-python \
    org.opencontainers.image.version=2025.07.31.0 \
    org.opencontainers.image.licenses=MIT


USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=SC2086
RUN \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    curl \
    jq \
    openssh-client \
    patch \
    sshpass \
    sudo \
    time \
    tree \
    && rm -rf /tmp/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man


# hadolint ignore=SC2086
RUN <<EOT
    set -ex
    mkdir -p /etc/ssh
    chown -R :$GROUPNAME /etc/ssh
    chmod -R g+rwx /etc/ssh
    echo "$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/tee" > /etc/sudoers.d/$USERNAME
EOT

USER $USERNAME
WORKDIR $HOME/app

COPY --from=builder --chown=$USER_UID:$USER_GID --chmod=755 /root/.local/bin/task $HOME/.local/bin/task
COPY --from=envconsul --chown=$USER_UID:$USER_GID --chmod=755 /bin/envconsul $HOME/.local/bin/envconsul
COPY --from=builder --chown=$USER_UID:$USER_GID /app/.venv $HOME/app/.venv

RUN find "$HOME/app/.venv" -type f -exec sed -i '1s|^#!.*python3$|#!/usr/bin/env python3|' {} +

ENV \
    PATH=$HOME/app/.venv/bin:$PATH

# default command: display Python version
CMD [ "python", "--version" ]