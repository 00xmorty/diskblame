Output assets/demo.gif

Require zsh
Require ./diskblame.zsh

Set Shell "zsh"
Set FontFamily "SF Mono"
Set FontSize 22
Set Width 1000
Set Height 620
Set Padding 26
Set Framerate 18
Set PlaybackSpeed 1.0
Set TypingSpeed 35ms
Set BorderRadius 0
Set Theme {"name":"diskblame","black":"#0b1020","red":"#ef4444","green":"#22c55e","yellow":"#f59e0b","blue":"#38bdf8","magenta":"#a78bfa","cyan":"#2dd4bf","white":"#e5e7eb","brightBlack":"#475569","brightRed":"#f87171","brightGreen":"#86efac","brightYellow":"#fbbf24","brightBlue":"#7dd3fc","brightMagenta":"#c4b5fd","brightCyan":"#67e8f9","brightWhite":"#f8fafc","background":"#0b1020","foreground":"#e5e7eb","selection":"#334155","cursor":"#7dd3fc"}

Hide
Type "clear" Enter
Show
Sleep 600ms
Type "./diskblame.zsh summary" Enter
Sleep 4s
Type "./diskblame.zsh scan" Enter
Sleep 4s
Type "./diskblame.zsh --version" Enter
Sleep 2s
