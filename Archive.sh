#!/bin/bash

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下
project_path=$(pwd)
#取当前时间字符串添加到文件结尾
now=$(date +"%Y_%m_%d_%H_%M_%S")

#指定项目的scheme名称
scheme="ALPHA"
#指定要打包的配置名
configuration="Release"
#指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development, 和developer-id，即xcodebuild的method参数
export_method='ad-hoc'

#指定项目地址
workspace_path="$project_path/ALPHA.xcworkspace"
#指定输出路径
output_path="/Users/mac/Desktop/"
#指定输出归档文件地址
archive_path="$output_path/ALPHA_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/ALPHA_${now}.ipa"
#指定输出ipa名称
ipa_name="ALPHA_${now}.ipa"
#获取执行命令时的commit message
commit_msg="重新上传包$now"

fir_token="b2ae43d55820056cce85aefe0b8c7dd7"
#输出设定的变量值
echo "===workspace path: ${workspace_path}==="
echo "===archive path: ${archive_path}==="
echo "===ipa path: ${ipa_path}==="
echo "===export method: ${export_method}==="
echo "===commit msg: $1==="

#先清空前一次build
gym --workspace ${workspace_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name}

#上传到fir 当不想上传时直接注释掉上传的代码
fir publish ${ipa_path} -T ${fir_token} -Q -c "${commit_msg}"

#输出总用时
echo "===Finished. Total time: ${SECONDS}s==="