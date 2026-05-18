Chezmoi will automatically generate `~/.config/chezmoi/chezmoi.yaml` from `.chezmoi.yaml.tmpl` when you run `chezmoi init` and the config file does not already exist.

Generated configuration example:

```
data:
  hosttype: "wsl"
  osid: "debian"
  proxy_ip: "127.0.0.1"
  email: "withatenth@gmail.com"
  niri:
    outputs: []
  languages:
    c: false
    cpp: false
    python: false
    rust: false
    go: false
    lua: false
    javascript: false
    typescript: false

encryption: "age"

age:
  identity: "~/.config/chezmoi/key.txt"
  recipient: "age1rj3fn2t7az2yrhpgfwrkvh80kgkcglkl9dv9y8au64x7rngjectq0danh8"
```

Bootstrap with automatic config generation:

```sh
chezmoi init --apply --exclude encrypted https://github.com/happyba11on/dotfiles.git
```
Without chezmoi yet:
```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply --exclude encrypted happyba11on
```

If you need to adjust host-specific values after the first bootstrap, edit `~/.config/chezmoi/chezmoi.yaml` and re-run `chezmoi apply`.

## Host-specific niri outputs

`niri` monitor names, modes, scales, and positions are machine-specific. This repo now treats
them as host data so one shared config can work across different laptops, docks, and displays.

Leave the default empty list to let `niri` auto-detect outputs:

```yaml
data:
  niri:
    outputs: []
```

Set explicit outputs only on machines that need fixed layout/scaling:

```yaml
data:
  niri:
    outputs:
      - name: "eDP-1"
        mode: "1920x1080@60.001"
        scale: 1.0
        transform: "normal"
        x: 0
        y: 0
      - name: "HDMI-A-1"
        mode: "2560x1600@130.000"
        scale: 1.2
        x: 1920
        y: 0
```

Use `niri msg outputs` on each machine to discover the correct output names and modes.

## Dockerfile

Untested and may not work. For reference only.

The repository also includes a root-level Dockerfile that builds a container with the baseline tools implied by these dotfiles:

- `zsh` with `oh-my-zsh`
- `neovim`
- `tmux`
- `chezmoi`
- `git`, `ripgrep`, `fd`, `xclip`
- `fastfetch`

Encrypted chezmoi entries are excluded during image setup.

Build with all language options disabled, which matches the default config:

```sh
docker build -t chezmoi-dotfiles .
```

Enable language-specific tooling with build args as needed:

```sh
docker build -t chezmoi-dotfiles \
  --build-arg ENABLE_GO=true \
  --build-arg ENABLE_PYTHON=true \
  --build-arg ENABLE_TYPESCRIPT=true \
  .
```

Supported build args:

- `ENABLE_C`
- `ENABLE_CPP`
- `ENABLE_PYTHON`
- `ENABLE_RUST`
- `ENABLE_GO`
- `ENABLE_LUA`
- `ENABLE_JAVASCRIPT`
- `ENABLE_TYPESCRIPT`

Run the resulting container:

```sh
docker run --rm -it chezmoi-dotfiles
```
