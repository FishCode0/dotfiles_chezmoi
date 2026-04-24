

## 一键导入

```bash
chezmoi init https://github.com/FishCode0/dotfiles_chezmoi.git
```

一键导入并应用
```bash
chezmoi init --apply https://github.com/FishCode0/dotfiles_chezmoi.git
```

## 模板示例

这个仓库现在演示了 `chezmoi` 的模板能力：

- `dot_gitconfig.tmpl`
  按主机名切换 Git 邮箱
- `.chezmoiignore.tmpl`
  非 Linux 环境下忽略 `.zshrc` 和 `.p10k.zsh`
- `.chezmoidata.yaml`
  集中管理模板里用到的数据

查看当前模板数据：

```bash
chezmoi data
```

单独测试模板表达式：

```bash
chezmoi execute-template '{{ .chezmoi.hostname }}'
chezmoi execute-template '{{ if .zsh.enable_eza_aliases }}eza on{{ else }}eza off{{ end }}'
```

应用改动：

```bash
chezmoi apply
```
