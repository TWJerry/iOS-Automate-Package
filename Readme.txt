
iOS自动化打包需求产生于Xcode打包速度慢，尤其是上线之前那会，改了一些bug，测试急需新的包，如果每次都用xcode打包，那有可能一天就干不了什么别的活了，而且频繁的打包确实是一种体力活。机械的操作比较无聊，下面介绍自动打包的是使用方法，ios小伙伴可以参考。作者也是看了别人的思路然后总结摸索最后终于成功了。

首先你的mac要有ruby环境，安装过cocoaPads已经装过ruby了。如果没有环境请自行百度,安装方法到处都是

1先下载我的脚本文件Archive.sh

2使用fastlane gym打包
首先打开终端执行：sudo gem install gym （如果是10.11的系统由于根路径，执行：gem install -n /usr/local/bin gym）

3脚本文件中有一些参数需要自己更改，具体请打开我的脚本。里面有说明。脚本放在你的工程目录下，和XXX.xcworkspace，XXX.xcodeproj在同一级目录。

4执行脚本。首先是需要权限 终端输入： chmod +x 脚本名     如果要获得Archive.sh权限，那么输入：chmod +x Archive.sh
4.1执行脚本：./Archicve.sh 终端直接输入：./Archicve.sh        然后就自己自动打包啦。

5如果你想打包顺便直接上传到公司的测试平台fir,请安装fir-cli.安装步骤如下
5.1 终端执行：ruby -v # > 1.9.3
    终端执行：gem install fir-cli

如果遇到安装问题请执行以下指令 作者安装的时候就遇到，估计是以前配置MySql的问题。

5.1.1
终端执行：xcode-select --install （如果提示没有权限请在指令前加上sudo，然后输入密码）
终端执行：gem sources --remove https://rubygems.org/
终端执行：gem sources -a https://ruby.taobao.org/
终端执行：gem sources -l

*** CURRENT SOURCES ***

https://ruby.taobao.org （如果看到这个，说明安装成功）

终端执行：gem update --system
终端执行：gem install fir-cli   （10.11系统的小伙伴请执行：gem install -n /usr/local/bin fir-cli）

到这里基本fir-cli就安装结束了，可在终端执行：fir login 然后输入自己fir的token.查看是否对应自己的邮箱。想了解fir更多请百度就行了。

5.2打开脚本中fir publish 那行代码（没装fir-cli的还是注释掉），执行脚本就会发现会自动上传你的ipa包。执行前记得fir_token改成自己的token哦，否则你的包就传到作者的fir上啦

备注：faceBook也出了一个自动打包，作者已经试了，打包时间是fastlane的好几倍。平均是6倍左右。publish.sh这个脚本主要用于不是每次打包都要上传到自己的fir,不需要上传就注释打包脚本中的fir publish 那行，但是有的时候打完包，需要传到fir,那么直接执行publish.sh脚本就行了。打完包以后桌面有3个文件，一个是Archive,一个ipa,还有一个是dYSM文件，最后一个用来调试崩溃。
