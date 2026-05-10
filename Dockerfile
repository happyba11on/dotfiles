FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG ENABLE_C=false
ARG ENABLE_CPP=false
ARG ENABLE_PYTHON=false
ARG ENABLE_RUST=false
ARG ENABLE_GO=false
ARG ENABLE_LUA=false
ARG ENABLE_JAVASCRIPT=false
ARG ENABLE_TYPESCRIPT=false

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && packages="age bash build-essential ca-certificates curl fd-find git less locales pkg-config ripgrep sudo tmux unzip xclip xz-utils zsh"; \
    if [ "${ENABLE_C}" = "true" ] || [ "${ENABLE_CPP}" = "true" ]; then packages="${packages} clang clangd clang-format"; fi; \
    if [ "${ENABLE_PYTHON}" = "true" ]; then packages="${packages} python3 python3-pip python3-venv"; fi; \
    if [ "${ENABLE_RUST}" = "true" ]; then packages="${packages} cargo rustc rustfmt"; fi; \
    if [ "${ENABLE_GO}" = "true" ]; then packages="${packages} golang-go"; fi; \
    if [ "${ENABLE_LUA}" = "true" ]; then packages="${packages} lua5.4 luarocks"; fi; \
    if [ "${ENABLE_JAVASCRIPT}" = "true" ] || [ "${ENABLE_TYPESCRIPT}" = "true" ]; then packages="${packages} nodejs npm"; fi; \
    apt-get install -y ${packages} \
    && locale-gen en_US.UTF-8 \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN if [ "${ENABLE_RUST}" = "true" ]; then \
    curl -fsSL https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz \
    -o /tmp/rust-analyzer.gz \
    && gunzip /tmp/rust-analyzer.gz \
    && install -m 755 /tmp/rust-analyzer /usr/local/bin/rust-analyzer \
    && rm -f /tmp/rust-analyzer; \
fi

RUN curl -fsSL https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb\
    -o /tmp/fastfetch.deb \
    && apt-get update \
    && apt-get install -y /tmp/fastfetch.deb \
    && rm -f /tmp/fastfetch.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git /root/.oh-my-zsh

RUN curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    -o /tmp/nvim-linux-x86_64.tar.gz \
    && rm -rf /opt/nvim-linux-x86_64 \
    && tar -C /opt -xzf /tmp/nvim-linux-x86_64.tar.gz \
    && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim \
    && rm -f /tmp/nvim-linux-x86_64.tar.gz

RUN sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b /usr/local/bin

COPY . /tmp/chezmoi-src

RUN mkdir -p /root/.config/chezmoi \
    && printf '%s\n' \
        'data:' \
        '  hosttype: "devcontainer"' \
        '  osid: "ubuntu"' \
        '  proxy_ip: "127.0.0.1"' \
        '  email: "withatenth@gmail.com"' \
        '  languages:' \
        "    c: ${ENABLE_C}" \
        "    cpp: ${ENABLE_CPP}" \
        "    python: ${ENABLE_PYTHON}" \
        "    rust: ${ENABLE_RUST}" \
        "    go: ${ENABLE_GO}" \
        "    lua: ${ENABLE_LUA}" \
        "    javascript: ${ENABLE_JAVASCRIPT}" \
        "    typescript: ${ENABLE_TYPESCRIPT}" \
        '' \
        'encryption: "age"' \
        '' \
        'age:' \
        '  identity: "/root/.config/chezmoi/key.txt"' \
        '  recipient: "age1rj3fn2t7az2yrhpgfwrkvh80kgkcglkl9dv9y8au64x7rngjectq0danh8"' \
        > /root/.config/chezmoi/chezmoi.yaml

RUN chezmoi apply --source=/tmp/chezmoi-src --exclude encrypted

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /workspaces/chezmoi

CMD ["/bin/zsh"]
