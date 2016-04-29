#!/bin/bash

#这里是需要上传的文件路径（绝对路径）
ipa_path="/Users/mac/Desktop/ALPHA_2016_04_29_11_49_35.ipa"

#上传时间
now=$(date +"%Y_%m_%d_%H_%M_%S")

#个人firtoken.
fir_token="b2ae43d55820056cce85aefe0b8c7dd7"

#上传到fir
fir publish ${ipa_path} -T ${fir_token} -Q -c "${now}"

echo "当前上传时间==${now}"
