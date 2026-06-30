#!/bin/bash

echo "=== 推送到 GitHub ==="

git pull github master

git add --all -- ':!nul'
git commit -m "更新"
git push github master
