Chezmoi will automatically generate `~/.config/chezmoi/chezmoi.yaml` from `.chezmoi.yaml.tmpl` when you run `chezmoi init` and the config file does not already exist.

Generated configuration example:

```
data:
  hosttype: "wsl"
  osid: "debian"
  proxy_ip: "127.0.0.1"
  email: "withatenth@gmail.com"
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
chezmoi init --apply https://github.com/happyba11on/dotfiles.git
```

If you need to adjust host-specific values after the first bootstrap, edit `~/.config/chezmoi/chezmoi.yaml` and re-run `chezmoi apply`.
