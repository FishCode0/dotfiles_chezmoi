

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

### 提前安装软件

```bash
sudo apt install -y zsh  zip tig ripgrep ncdu nano micro httpie htop gzip grep git ffmpeg fd-find dos2unix bat age 7zip eza cmake shellcheck wl-clipboard zstd clang libclang-dev duf gh
```

将apt改为nala会更快

### micro
如果包管理器无法直接安装的话
```bash
curl https://getmic.ro | bash
```

### uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### cargo
⭐很重要，最好先安装
```bash
curl https://sh.rustup.rs -sSf | sh
```

### jujutsu

tip: 需先完成上述cargo的安装。

```bash
sudo apt install build-essential
cargo install --locked --bin jj jj-cli
```

### golang

官网：https://go.dev/dl/

```bash
wget https://go.dev/dl/go1.26.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.26.3.linux-amd64.tar.gz 

```

### gh
因为`.gitconfig`里配置了，所以需要用gh登录获得授权
```bash
gh auth login
```
然后一步步选择即可，最终建议选择`Login with a web browser`

获得8 位数的动态授权验证码，
然后进入https://github.com/login/device，输入授权验证码，完成激活。


### 配置环境变量

`.zshrc`

```
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
```

`config.fish`

```
set -Ux GOPATH $HOME/go
fish_add_path $GOPATH/bin

fish_add_path /usr/local/go/bin
```
### bat
https://github.com/sharkdp/bat
在Debain/Unbntu中使用apt安装，可能会变为`batcat`，所以建议使用cargo安装，其他系统可以直接使用各自的安装器安装
如Rocky Linux可以直接
```bash
sudo dnf install -y bat
```
cargo安装：
```bash
cargo install --locked bat
```

### eza 
https://github.com/eza-community/eza/blob/main/INSTALL.md
cargo安装方法：
```bash
cargo install eza
```

### fzf

apt安装的版本有点老，没有好用的交互 UI（好像是0.70.0以上才有）

所以下载最新仓库，使用仓库的脚本安装

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

tip：全部yes，而且 `~/.fzf/`文件夹不能删

### zoxide

tip：需先安装fzf

好用的跳转工具

https://github.com/ajeetdsouza/zoxide

其实也可以用包管理器安装，下面用脚本安装是为了安装最新版本

```
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

之后在shell启动脚本加入启动命令

```bash
# bash
eval "$(zoxide init bash)"
# fish
zoxide init fish | source
# zsh 
eval "$(zoxide init zsh)"
# 其他可以在官网Readme中查看

```

### atuin

好用的命令行历史记录器，提供同步功能

安装：

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive
```

添加到配置文件

```bash
# zsh
eval "$(atuin init zsh)"
# fish
atuin init fish | source
```

#### 导入历史记录
```bash
atuin import auto
```
或者指定shell
```bash
atuin import bash
atuin import zsh
```

#### 注册与云同步
官方提供了免费云同步服务
```bash
# 注册
atuin register -u <username> -e <email>
# 登录
atuin login
# 获取同步key
atuin key
# 统计命令使用频率
atuin stats
```
tips：也可以自建服务器

### fd-find
https://github.com/sharkdp/fd
```bash
cargo install fd-find
```

### direnv

功能：自动加载环境变量（虚拟环境）

需要go >= 1.24

```bash
git clone https://github.com/direnv/direnv.git
cd direnv
make
make test
# 安装到/usr/local
make install
# 自定义安装路径，如~.local/bin/
make install PREFIX=~/.local
```

添加到配置文件中

```bash
# bash
eval "$(direnv hook bash)"
# zsh
eval "$(direnv hook zsh)"
# oh-my-zsh
plugins=(... direnv)
# fish
direnv hook fish | source
```

### ouch
功能：统一压缩/解压命令的软件
```bash
cargo install ouch
```
语法：
```bash
ouch decompress a.tar.gz
ouch compress a/ a.tar.zst
```


### 安装Nerd Fonts字体

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

### Fish

Zsh可能不好用，开箱即用的fish更适合懒人

```bash
git clone https://github.com/fish-shell/fish-shell.git
cd fish-shell
mkdir build; cd build
cmake ..
cmake --build .
sudo cmake --install .
```

手册页补全

```bash
# 先进fish
fish
fish_update_completions
```

搭配下面的starship更佳

设置为默认终端

```bash
chsh -s $(which fish)
```

如果报错`chsh：/usr/local/bin/fish 是无效的 shell`

先修改`/etc/shells`

```bash
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s $(which fish)
```



#### Fisher

一个极简的fish插件管理器（oh-my-fish是全家桶版框架）

特点：只负责下载和清理

```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

推荐的插件：

+ zoxide
+ atuin
+ fzf.fish
+ done
+ direnv
+ autopair
+ bass
+ tide

##### zoxide

更好的目录跳转，安装参考上文zoxide部分

```bash
echo "zoxide init fish | source" >> ~/.config/fish/config.fish
```

##### atuin

历史命令记录，提供同步功能

```bash
echo "atuin init fish | source" >> ~/.config/fish/config.fish
```

### fzf.fish

fzf+fish 比官方自带的completion更强

tip：需先安装fzf

```bash
fisher install PatrickF1/fzf.fish
```

##### done

长命令执行完后，进行桌面提醒

```bash
fisher install franciscolourenco/done
```

##### direnv

```bash
echo "direnv hook fish | source" >> ~/.config/fish/config.fish
```

##### autopair

自动补`"`,`[`,`(`之类的

```bash
fisher install jorgebucaran/autopair.fish
```

##### bass

用来兼容bash语法

```bash
fisher install edc/bass
```



##### tide

类似p10k一样提供prompt、装了starship可以不装这个

```bash
fisher install IlanCosman/tide@v6
```

### starship

```bash
curl -sS https://starship.rs/install.sh | sh
```

配置Fish自动启用

```bash
# 创建配置文件夹
mkdir -p ~/.config/fish

# 将初始化语句写入 fish 配置文件
echo "starship init fish | source" >> ~/.config/fish/config.fish
```



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

### 

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

