Chezmoi example configuration file: ~/.config/chezmoi/chezmoi.yaml

```
data:
  osid: "debian"
  proxy_ip: "127.0.0.1"
  email: "email-address@qq.com"
  languages:
    c: true
    cpp: true
    python: true
    rust: true
    go: false
    lua: true
    javascript: true
    typescript: true

encryption:  "age"

age:
  identity:  "~/.config/chezmoi/key.txt"
```
