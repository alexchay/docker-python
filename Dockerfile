ARG BASE_IMAGE_NAME="defval"
ARG BASE_IMAGE_TAG="defval"
FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

LABEL maintainer="Alexander Chaykovskiy <alexchay@gmail.com>"

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install dependencies and GoTask
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
    unzip \
    && rm -rf /tmp/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man


# hadolint ignore=SC2086
RUN <<EOT
    set -ex
    chown -R :$GROUPNAME /etc/ssh
    chmod -R g+rwx /etc/ssh
    echo "$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/tee" > /etc/sudoers.d/$USERNAME
EOT

USER $USERNAME
WORKDIR $HOME

# default command: display Python version
CMD [ "python", "--version" ]