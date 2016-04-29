#!/bin/bash

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下
project_path=$(pwd)
#取当前时间字符串添加到文件结尾
now=$(date +"%Y_%m_%d_%H_%M_%S")

#指定项目的scheme名称
scheme="ALPHA"
#指定要打包的配置名，这里直接Release就可以了。
configuration="Release"
#指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development, 和developer-id，即xcodebuild的method参数
#打什么样的包就设置什么参数。
export_method='ad-hoc'

#指定项目地址 这个是你项目的路径，如果是cocoaPods管理的填写xcworkspace后缀名文件.如果不是请填写.xcodeproj文件。作者是pods管理的，所以举例是xcworkspace后缀名。
workspace_path="$project_path/XXX.xcworkspace"
#这里是打包的输出路径一般写桌面，作者直接打包到桌面，因为作者的用户叫mac 所以路径是/Users/mac/Desktop/，根据自己实际填写自己的桌面路径
output_path="/Users/xxx/Desktop/"
#指定输出归档文件地址，下面的这些XXX根据自己情况替换，比如你的scheme叫Demo,那么请把XXX都换成Demo

archive_path="$output_path/XXX_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/XXX_${now}.ipa"
#指定输出ipa名称
ipa_name="XXX_${now}.ipa"


#获取执行命令时的commit message 下面这些是fir.im上传的参数。因为作者公司用的是fir.im测试平台
commit_msg="重新上传包$now"
#token是fir.im平台每个注册用户的标识。如果注册了，可以在fir.im平台上查到自己的token.
fir_token="b2ae43d55820056cce85aefe0b8c7dd7"



#这里是在终端打印以上设置的一些参数。会shell的开发者可自己更改输出格式。
echo "————workspace path: ${workspace_path}————"
echo "————archive path: ${archive_path}————"
echo "————ipa path: ${ipa_path}————"
echo "————export method: ${export_method}———"

#这里进入打包的环节，我们用的是gym.下面这段代码打包pods管理的工程。如果你的工程不是用pods管理的，请用打开48行代码，注释46行。
gym --workspace ${workspace_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name}

#gym --project ${workspace_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name}


#上传到fir 当不想上传时直接注释掉上传的代码,执行下面这行代码需要安装fir-cli，Readme.txt文档中告诉大家如何安装了。如果没有自己的公测平台，直接注释这行代码。代码中的参数ipa_path是路径，—T 是传入token,fir_token唯一的用户token，这个token决定了打出的.ipa上传到哪。-Q是生成二维码，直接在你一开始设置的output_path目录下，作者设置的是桌面，所以直接就在桌面生成可一张二维码图片。同事只要扫了这个二维码就能下载你的包了。后面的-c 参数是fir.im提交的时候一些说明，可以在fir平台上看到的。
fir publish ${ipa_path} -T ${fir_token} -Q -c "${commit_msg}"

#输出总用时
echo "__Finished. Total time: ${SECONDS}s__"