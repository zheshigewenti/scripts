#!/bin/bash
xrandr --auto --output HDMI1 --same-as eDP1 --size 1920*1080   # 外接显示器显示
/bin/bash ~/scripts/dwm-status.sh &                            # 任务栏状态刷新
/bin/bash ~/scripts/wp-autochange.sh &                         # 换壁纸
# picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
picom -b                                                       #渲染器
# /bin/bash ~/scripts/tap-to-click.sh &                        #触控板点击
# /bin/bash ~/scripts/inverse-scroll.sh &                      #触控板滑动
# /bin/bash ~/scripts/run-mailsync.sh &                        #邮件同步
~/scripts/autostart_wait.sh &                                #输入法
