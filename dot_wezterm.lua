local wezterm = require 'wezterm'
local c = {}
if wezterm.config_builder then
    c = wezterm.config_builder()
end

-- 初始大小
c.initial_cols = 96
c.initial_rows = 24

-- 关闭时不进行确认
c.window_close_confirmation = 'NeverPrompt'

c.window_background_opacity = 0.85
c.win32_system_backdrop = 'Acrylic'     -- Windows 11 专属毛玻璃
c.color_scheme = 'Catppuccin Macchiato' -- 极客圈最火的配色
-- 字体
-- c.font = wezterm.font 'JetBrains Mono'
c.font = wezterm.font_with_fallback({
    {
        family = 'Monaspace Argon',
        -- calt: 上下文连字, ss01: 纹理修护, liga: 标准连字
        harfbuzz_features = { 'calt=1', 'ss01=1', 'liga=1', 'dlig=1' }
    },
    { family = 'Noto Color Emoji' },
    { family = 'Fira Code',       harfbuzz_features = { 'calt=1' } },
    { family = 'PingFang SC' }
})

-- 建议配合设置（让渲染更清晰）
c.font_size = 12.0
c.line_height = 1.1 -- Monaspace 稍微调大一点点行高视觉效果更好


-- 斜体配合
c.font_rules = {
    {
        -- 当检测到是斜体（通常是代码注释）时
        italic = true,
        font = wezterm.font({
            family = 'Monaspace Radon', -- 或者 Neon
            style = 'Italic',
            harfbuzz_features = { 'calt=1', 'ss01=1' },
        }),
    },
}



-- 配色
local materia = wezterm.color.get_builtin_schemes()['Material Darker (base16)']
materia.scrollbar_thumb = '#cccccc' -- 更明显的滚动条
c.colors = materia

-- 透明背景
c.window_background_opacity = 0.9
-- 取消 Windows 原生标题栏
c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- 滚动条尺寸为 15 ，其他方向不需要 pad
c.window_padding = { left = 0, right = 15, top = 0, bottom = 0 }
-- 启用滚动条
c.enable_scroll_bar = true

-- 默认启动 MinGW64 / MSYS2
c.default_prog = { 'pwsh.exe' }

-- 启动菜单的一些启动项
c.launch_menu = {
    -- { label = 'MINGW64 / MSYS2', args = { 'C:/msys64/msys2_shell.cmd', '-defterm', '-here', '-no-start', '-shell', 'zsh', '-mingw64' }, },
    -- { label = 'MSYS / MSYS2',    args = { 'C:/msys64/msys2_shell.cmd', '-defterm', '-here', '-no-start', '-shell', 'zsh', '-msys' }, },
    { label = 'PowerShell 7', args = { 'pwsh.exe' }, },
    { label = 'Ubuntu (WSL)', args = { 'wsl.exe', '~' } },
    { label = 'CMD',          args = { 'cmd.exe' }, },
    { label = 'nas / ssh',    args = { 'C:/msys64/usr/bin/ssh.exe', 'nas' }, },
}

-- 取消所有默认的热键
c.disable_default_key_bindings = true
local act = wezterm.action
c.keys = {
    -- 分屏：Alt + D (垂直) / Alt + Shift + D (水平)
    { key = 'd',         mods = 'ALT',        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'd',         mods = 'ALT|SHIFT',  action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Ctrl+Tab 遍历 tab
    { key = 'Tab',       mods = 'CTRL',       action = act.ActivateTabRelative(1) },
    -- F11 切换全屏
    { key = 'F11',       mods = 'NONE',       action = act.ToggleFullScreen },
    -- Ctrl+ + 字体增大
    { key = '+',         mods = 'CTRL',       action = act.IncreaseFontSize },
    -- Ctrl+ - 字体减小
    { key = '-',         mods = 'CTRL',       action = act.DecreaseFontSize },
    -- Ctrl+Shift+C 复制选中区域
    { key = 'C',         mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    -- Ctrl+ N 新窗口
    { key = 'N',         mods = 'CTRL',       action = act.SpawnWindow },
    -- Ctrl+T 新 tab
    { key = 'T',         mods = 'CTRL',       action = act.ShowLauncher },
    -- Ctrl+Shift+Enter 显示启动菜单
    { key = 'Enter',     mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
    -- Ctrl+Shift+V 粘贴剪切板的内容
    { key = 'V',         mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    -- Ctrl+Shift+W 关闭 tab 且不进行确认
    { key = 'W',         mods = 'SHIFT|CTRL', action = act.CloseCurrentTab { confirm = false } },
    -- Ctrl+Shift+PageUp 向上滚动一页
    { key = 'PageUp',    mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },
    -- Ctrl+Shift+PageDown 向下滚动一页
    { key = 'PageDown',  mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },
    -- Ctrl+Shift+UpArrow 向上滚动一行
    { key = 'UpArrow',   mods = 'SHIFT|CTRL', action = act.ScrollByLine(-1) },
    -- Ctrl+Shift+DownArrow 向下滚动一行
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(1) },
    -- Ctrl+Shift+L 切换菜单
    { key = 'L',         mods = 'SHIFT|CTRL', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
    -- Ctrl+A 全选
    {
        key = 'A',
        mods = 'CTRL',
        action = act.Multiple {
            act.ActivateCopyMode,
            act.CopyMode 'MoveToScrollbackTop',
            act.CopyMode { SetSelectionMode = 'Cell' },
            act.CopyMode 'MoveToScrollbackBottom',
            act.CopyTo 'Clipboard',
        },
    },
    -- Ctrl+L 选中当前行
    {
        key = 'l',
        mods = 'CTRL',
        action = act.Multiple {
            act.ActivateCopyMode,
            act.CopyMode 'MoveToStartOfLineContent',
            act.CopyMode { SetSelectionMode = 'Cell' },
            act.CopyMode 'MoveToEndOfLineContent',
            act.CopyTo 'Clipboard',
        },
    },
}

-- c.mouse_bindings = {
--     -- 右键点击 (Mouse Down)
--     {
--         event = { Down = { streak = 1, button = 'Right' } },
--         mods = 'NONE',
--         -- 核心逻辑：如果是选中的文本，则执行复制到剪贴板
--         action = wezterm.action.CopyTo 'Clipboard',
--     },
-- }


c.mouse_bindings = {
    -- 当有选区时，右键点击执行复制并清除选区
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(wezterm.action.CopyTo 'Clipboard', pane)
                window:perform_action(wezterm.action.ClearSelection, pane)
            else
                window:perform_action(wezterm.action.PasteFrom 'Clipboard', pane)
            end
        end),
    },
}

c.use_ime = true

return c
