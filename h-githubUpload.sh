#!/bin/bash

git pull

echo "=== 推送到 GitHub ==="

git add --all -- ':!nul'
git commit -m "更新"
git push github main
