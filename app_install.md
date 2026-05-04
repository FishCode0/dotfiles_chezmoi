

describe：安装Linux环境常用的各种软件、

## 更新源

```bash
sudo apt update
```

### 换源

可能会因为种种原因，导致获取软件源配置很慢，可以考虑换源

可以下载nala、它可以帮忙自动测试镜像源的延迟，给出选择：

```bash
sudo apt install nala
sudo nala fetch
```

tip: 有时也可能是因为代理被劫持等原因导致的，建议直接问chatgpt

fetch之后记得注释掉（或删除）原来的源地址

```bash
sudo vim /etc/apt/sources.list
# Ubuntu26.04更改为以下地址
sudo vim /etc/apt/sources.list.d/ubuntu.sources 
```



## 安装

提前安装软件

```bash
sudo apt install -y zsh zoxide zip tig ripgrep ncdu nano micro httpie htop gzip grep git ffmpeg fd-find dos2unix bat age 7zip eza 
```

将apt改为nala会更快

### uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### cargo

```bash
curl https://sh.rustup.rs -sSf | sh
```

### jujutsu

tip: 需先完成上述cargo的安装。

```bash
sudo apt install build-essential
cargo install --locked --bin jj jj-cli
```

### fzf

apt安装的版本有点老，没有好用的交互 UI（好像是0.70.0以上才有）

所以下载最新仓库，使用仓库的脚本安装

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

tip：`.fzf\`文件夹不能删

### Zsh

检查版本：

```bash
zsh --version
```

设置为默认终端

```bash
chsh -s $(which zsh)
```

先重启终端，验证：

```bash
echo $SHELL
```

如果遇到无`.zshrc`,可能是上面chezmoi没完全成功的问题

#### oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

接下来可能会由于没有安装插件，导致zsh启动失败

接下来、

#### 安装插件

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### 安装Nerd Fonts字体

下载字体

```bash
cd ~
wget https://github.com/githubnext/monaspace/releases/download/v1.301/monaspace-nerdfonts-v1.301.zip
```

解压字体

```bash
unzip monaspace-nerdfonts-v1.301.zip -d monaspace
```

安装字体

```bash
# 创建用户字体目录
mkdir -p ~/.local/share/fonts
cp -r monaspace ~/.local/share/fonts/
```

刷新缓存

```bash
fc-cache -fv
```

验证

```bash
fc-list | grep -i monaspace
```



### yazi

```bash
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked
mv target/release/yazi target/release/ya ~/.local/bin
```

### fastfetch

```bash
sudo apt install fastfetch
```

不行的话只能自己编译了

```bash
git clone https://github.com/fastfetch-cli/fastfetch.git
cd fastfetch/
# 构建配置文件
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$HOME/.local"
# 编译
cmake --build build -j
# 安装
cmake --install build
```

### tldr

tldr有很多版本，这边安装的是rust版的

有tealdeer和tlrc两种，前者偏轻量、后者功能更全

```bash
# tealdeer
cargo install tealdeer
# tlrc
cargo install tlrc --locked
```

可以设置中文版本

```bash
# 获取配置文件地址
tldr --config-path
# 生成配置文件
tldr --gen-config > "$(tldr --config-path)"

micro ~/.config/tlrc/config.toml

# 修改完成后，更新page包
tldr --update

```

`~/.config/tlrc/config.toml`改为

```TOML
[cache]
languages = ["zh","en"]
```

完成后，即会输出中文描述。



## 清理

清理一下下载的文件

```bash
rm -rf ~/yazi/
rm -rf ~/bin/
rm monaspace-nerdfonts-v1.301.zip
```

