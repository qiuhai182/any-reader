@echo off
chcp 65001 >nul 2>&1

echo ========== 步骤1：安装依赖 ==========
@REM call pnpm-npm-vsce-install.bat

echo.
echo ========== 步骤2：构建核心模块 ==========
pnpm.cmd build

echo.
echo ========== 步骤3：构建 VSCode Web 模板 ==========
pnpm.cmd vscode:build-tpl

echo.
echo ========== 步骤4：构建 VSCode 插件源码 ==========
cd packages\vscode
copy package.json package.json.build-bak >nul
pnpm.cmd build
cd ..\..

echo.
echo ========== 步骤5：生成 VSIX 包 ==========
cd packages\vscode
pnpm.cmd run pack
copy /y package.json.build-bak package.json >nul
del package.json.build-bak
cd ..\..

echo.
echo VSIX 包生成完成！
pause