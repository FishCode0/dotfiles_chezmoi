
## 安装chezmoi
### 下载
#### curl下载
```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)"
```
#### wget下载
```bash
sh -c "$(wget -qO- https://get.chezmoi.io)"
```
#### PowerShell安装
```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')}"
```
### 安装
正常来说会直接安装好，也可能会出现在`~`下创建了一个bin目录，这个时候使用以下命令
```bash
 cp bin/chezmoi ~/.local/bin
```

## 克隆chezmoi库
方法一：使用HTTPS克隆
1. 获取临时密码Token
https://github.com/settings/personal-access-tokens


2. 一键导入

```bash
chezmoi init https://github.com/FishCode0/dotfiles_chezmoi.git
```
导入并应用
```bash
chezmoi init --apply https://github.com/FishCode0/dotfiles_chezmoi.git
```
或者也可以使用SSH登录

方法二：使用SSH克隆

1. 生成SSH公钥
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
2. 将公钥上传到GitHub
https://github.com/settings/keys

3. 一键导入
```bash
chezmoi init  https://github.com/FishCode0/dotfiles_chezmoi.git
```
一键导入并应用
```bash
chezmoi init --apply https://github.com/FishCode0/dotfiles_chezmoi.git
```

### 使用同步

```bash
chezmoi apply 
```
可能因为有加密文件导致失、缺少文件，使用`--exclude encrypted`跳过加密文件
```bash
chezmoi apply --exclude encrypted
```
## 更新
以本地文件为模板更新
```bash
chezmoi re-add
```
文件夹中的新文件可能不会自动追踪，需要重新add一下文件夹
```bash
chezmoi update
```

以库为模板更新


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

## 更多软件安装
详见[app_install.md](app_install.md)

