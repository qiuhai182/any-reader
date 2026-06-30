#!/bin/bash

git pull

echo "=== 推送到 Gitee ==="

git add --all -- ':!nul'
git commit -m "更新"
git push gitee master
