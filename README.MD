

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
- `dot_zshrc.tmpl`
  按数据渲染插件列表
- `.chezmoiignore.tmpl`
  非 Linux 环境下忽略 `.zshrc` 和 `.p10k.zsh`
- `.chezmoidata.yaml`
  集中管理模板里用到的数据
- `private_dot_ssh/private_config.tmpl`
  生成 `~/.ssh/config`

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

## SSH 建议

`.ssh` 目录建议按敏感程度拆开管理：

- 公钥可以直接保存
- `config` 适合用模板管理
- `known_hosts` 按需保存
- 私钥不要明文提交到 Git 仓库

当前仓库里的私钥已经改成加密文件：

- `private_dot_ssh/encrypted_private_id_ed25519.age`

本机 `chezmoi` 使用 `age` 解密，相关本地配置在：

- `/home/zc/.config/chezmoi/chezmoi.toml`
- `/home/zc/.config/chezmoi/key.txt`

重新纳入本机私钥的命令是：

```bash
chezmoi add --encrypt ~/.ssh/id_ed25519
```

### 需要备份的文件

最重要的是这份私钥解密密钥：

```bash
/home/zc/.config/chezmoi/key.txt
```

如果它丢失，你将无法在新机器上解密 `encrypted_private_id_ed25519.age`。

### 新机器恢复步骤

1. 安装 `chezmoi` 和 `age`
2. 把仓库拉到新机器
3. 把备份好的 `key.txt` 放到 `/home/zc/.config/chezmoi/key.txt`
4. 写入本地 `chezmoi` 配置：

```toml
encryption = "age"

[age]
    identity = "/home/zc/.config/chezmoi/key.txt"
    recipient = "age1y9e8zft92en3nr3hxff6tgjl4jutmtupx85l08rnpvm9uqwtyyqqu5h9jv"
```

5. 执行：

```bash
chezmoi apply
```
