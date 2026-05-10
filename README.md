Chezmoi example configuration file: ~/.config/chezmoi/chezmoi.yaml

```
data:
  osid: "debian"
  proxy_ip: "127.0.0.1"
  email: "email-address@qq.com"
  languages:
    c: false
    cpp: false
    python: false
    rust: false
    go: false
    lua: false
    javascript: false
    typescript: false

encryption:  "age"

age:
  identity:  "~/.config/chezmoi/key.txt"
```

```
chezmoi init --apply https://github.com/happyba11on/dotfiles.git
```
