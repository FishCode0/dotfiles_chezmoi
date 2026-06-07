

# 导入 posh-git 模块
Import-Module posh-git

# 设置 oh-my-posh Shell 提示主题
#oh-my-posh init pwsh --config "$(scoop prefix oh-my-posh)\themes\ys.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$(scoop prefix oh-my-posh)\themes\zash.omp.json" | Invoke-Expression

# 启用瞬态提示 
#Enable-PoshTransientPrompt

# 设置 Ctrl + Z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 设置 Tab 键菜单补全
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# 使用 ls 和 ll 查看目录
function ListDirectory {
    (Get-ChildItem).Name
    Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# 清除 scoop 缓存和软件旧版本 | 别名: scoopwipe
function scoopwipe{sudo scoop cleanup -gk * && sudo scoop cleanup * -g && scoop cache rm * && scoop cleanup * && Write-Host "Scoop 缓存清理完成啦~👌" }

# 启动 Hugo 本地预览服务器（通过局域网可访问）192.168.0.102 是本机局域网 IP | 别名: hugos
#function hugos{hugo server --bind="0.0.0.0" --baseURL http://192.168.0.102}

# GPG for Canokeys: https://dejavu.moe/posts/canokey-openpgp/
# 杀死 gpg agent 进程 | 別名: killgpg
#function killgpg{gpg-connect-agent killagent /bye}

# 启动 gpg agent 进程 | 别名: startgpg
#function startgpg{gpg-connect-agent /bye}

# 查看 gpg 智能卡状态 | 别名: card
#function card{gpg-connect-agent killagent /by && gpg-connect-agent /bye && gpg --card-status}

# 快速获取 yyyy-MM-dd HH:mm:ss 格式的时间 | 别名: time
#function time{Get-Date -Format 'yyyy-MM-dd HH:mm:ss'}

# 开启类似 Zsh 的自动补全预测
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Import-Module Terminal-Icons
# 设置快速补全快捷键（按右方向键补全）
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete



Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init --hook pwd  powershell | Out-String) })

# jj标准补全
# jj util completion power-shell | Out-String | Invoke-Expression

# jj动态补全
$env:COMPLETE = "powershell"
jj | Out-String | Invoke-Expression
Remove-Item Env:\COMPLETE



function y {
	$tmp = New-TemporaryFile
	yazi $args --cwd-file="$tmp"
    if (Test-Path $tmp) {
		$cwd = Get-Content -Path $tmp -Raw
	    if ($cwd -and (Test-Path $cwd)) {
	        Set-Location $cwd
	    }
	}
	 Remove-Item $tmp -Force -ErrorAction SilentlyContinue
	}
