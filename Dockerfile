FROM python:slim

ENV PYENV_ROOT=/root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
      libbz2-dev \
      libffi-dev \
      liblzma-dev \
      libncurses5-dev \
      libncursesw5-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      llvm \
      make \
      openssl \
      tk-dev \
      wget \
      xz-utils \
      zlib1g-dev \
      cargo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT && \
    rm -rfv $PYENV_ROOT/.git

RUN git clone https://github.com/momo-lab/xxenv-latest.git $PYENV_ROOT/plugins/xxenv-latest

ENTRYPOINT ["/entrypoint.sh"]
COPY entrypoint.sh /entrypoint.sh
