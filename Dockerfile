ARG CI_REGISTRY="defval"
ARG PYTHON_IMAGE_TAG="defval"
FROM $CI_REGISTRY/python-base:$PYTHON_IMAGE_TAG

ARG POETRY_VERSION=2.1.3
ENV POETRY_VERSION=$POETRY_VERSION
ENV GOTASK_VERSION=3.43.3
ENV GOTASK_SHA256SUM=717cc03e60bf92fa53015a15b263c750f2452ba17f8f7b7648b2afc19ac4e969


USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install dependencies and GoTask
# hadolint ignore=SC2086
RUN \
    apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    jq \
    openssh-client \
    openssl \
    patch \
    sshpass \
    sudo \
    time \
    tree \
    unzip \
    && curl -fsSLO https://github.com/go-task/task/releases/download/v${GOTASK_VERSION}/task_linux_amd64.deb \
    && echo "${GOTASK_SHA256SUM} task_linux_amd64.deb" | sha256sum --check \
    && dpkg -i task_linux_amd64.deb && rm task_linux_amd64.deb \
    && apt-get -y autoremove \
    && rm -rf /tmp/* /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean


# create local group and user & switch to
# hadolint ignore=SC2086
RUN \
    chown -R :$USERNAME /etc/ssh  \
    && chmod -R g+rwx /etc/ssh \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/tee" > /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR $HOME

# Install Poetry
# https://python-poetry.org/docs/#ci-recommendations
RUN \
    pip install --user --upgrade --no-cache-dir \
    poetry==$POETRY_VERSION

ENV \
    # Do not ask any interactive question
    POETRY_NO_INTERACTION=1

# default command: display Poetry version
CMD [ "poetry", "--version" ]