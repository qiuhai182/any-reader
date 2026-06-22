#!/bin/bash

git pull

git add --all -- ':!nul'
git commit -m "去重快捷上传"
git push
git push gitee main
git push github main
