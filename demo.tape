Output assets/demo.gif

Require zsh
Require git
Require ./diskblame.zsh

Set Shell "zsh"
Set FontFamily "Menlo"
Set FontSize 18
Set Width 1080
Set Height 660
Set Padding 28
Set Framerate 18
Set PlaybackSpeed 1.0
Set TypingSpeed 30ms
Set BorderRadius 0
Set Theme {"name":"diskblame-gnzh-cyan","black":"#06141b","red":"#ef4444","green":"#22c55e","yellow":"#f59e0b","blue":"#38bdf8","magenta":"#a78bfa","cyan":"#2dd4bf","white":"#cffafe","brightBlack":"#475569","brightRed":"#f87171","brightGreen":"#86efac","brightYellow":"#fbbf24","brightBlue":"#7dd3fc","brightMagenta":"#c4b5fd","brightCyan":"#67e8f9","brightWhite":"#f8fafc","background":"#06141b","foreground":"#cffafe","selection":"#334155","cursor":"#22d3ee"}

Hide
Type "if [ ! -d /tmp/morty-oh-my-zsh-demo/.git ]; then git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git /tmp/morty-oh-my-zsh-demo >/dev/null 2>&1; fi" Enter
Sleep 500ms
Type "mkdir -p /tmp/diskblame-omz-demo && cp assets/demo-omz-zshrc /tmp/diskblame-omz-demo/.zshrc" Enter
Sleep 300ms
Type "export DISKBLAME_DEMO_DIR=$PWD; export ZDOTDIR=/tmp/diskblame-omz-demo; exec zsh -i" Enter
Sleep 1500ms
Type "clear" Enter
Show
Sleep 600ms
Type "./diskblame.zsh summary" Enter
Sleep 3.2s
Type "./diskblame.zsh scan" Enter
Sleep 2.6s
Type "./diskblame.zsh --version" Enter
Sleep 1.8s
