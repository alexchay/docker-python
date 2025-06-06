ARG BASE_IMAGE_NAME="defval"
ARG BASE_IMAGE_TAG="defval"
FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

LABEL maintainer="Alexander Chaykovskiy <alexchay@gmail.com>"

ENV GOTASK_VERSION=3.43.3

# Map Docker's TARGETARCH to GoTask's arch naming (amd64 -> amd64, arm64 -> arm64)
ARG TARGETARCH
ENV TARGETARCH=$TARGETARCH

# Set GoTask download URLs and checksums for each arch
ENV GOTASK_URL_AMD64=https://github.com/go-task/task/releases/download/v${GOTASK_VERSION}/task_linux_amd64.deb
ENV GOTASK_URL_ARM64=https://github.com/go-task/task/releases/download/v${GOTASK_VERSION}/task_linux_arm64.deb
ENV GOTASK_SHA256SUM_AMD64=717cc03e60bf92fa53015a15b263c750f2452ba17f8f7b7648b2afc19ac4e969
ENV GOTASK_SHA256SUM_ARM64=e1bf47b46ec4df932f1d68b84b243c2b67d03465f8cac01379fd2b39517aa71f

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
    && \
    # Select GoTask URL and checksum based on architecture
    if [ "$TARGETARCH" = "amd64" ]; then \
      GOTASK_URL=$GOTASK_URL_AMD64; \
      GOTASK_SHA256SUM=$GOTASK_SHA256SUM_AMD64; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
      GOTASK_URL=$GOTASK_URL_ARM64; \
      GOTASK_SHA256SUM=$GOTASK_SHA256SUM_ARM64; \
    else \
      echo "Unsupported architecture: $TARGETARCH"; exit 1; \
    fi \
    && curl -fsSLO "$GOTASK_URL" \
    && echo "${GOTASK_SHA256SUM}  $(basename $GOTASK_URL)" | sha256sum --check \
    && dpkg -i $(basename $GOTASK_URL) && rm $(basename $GOTASK_URL) \
    rm -rf /tmp/* \
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