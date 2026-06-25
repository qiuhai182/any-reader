@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

echo ========== 步骤1：安装依赖 ==========
echo 使用 --ignore-scripts 跳过 isolated-vm 原生编译...
call pnpm install --ignore-scripts
if %errorlevel% neq 0 (
    echo [失败] 依赖安装失败
    goto :error
)

echo.
echo ========== 步骤2：构建 @any-reader/shared ==========
call pnpm shared:build
if %errorlevel% neq 0 (
    echo [失败] shared 构建失败
    goto :error
)

echo.
echo ========== 步骤3：构建 VSCode Web 模板 ==========
call pnpm vscode:build-tpl
if %errorlevel% neq 0 (
    echo [失败] web 模板构建失败
    goto :error
)

echo.
echo ========== 步骤4：构建 VSCode 插件源码 ==========
cd packages\vscode
call pnpm build
set BUILD_RESULT=%errorlevel%
cd ..\..
if %BUILD_RESULT% neq 0 (
    echo [失败] VSCode 插件构建失败
    goto :error
)

echo.
echo ========== 步骤5：生成 VSIX 包 ==========
cd packages\vscode
call npx --yes vsce package --no-dependencies
set PACK_RESULT=%errorlevel%
cd ..\..
if %PACK_RESULT% neq 0 (
    echo [失败] VSIX 打包失败
    goto :error
)

echo.
echo ========== VSIX 包生成完成！ ==========
pause
exit /b 0

:error
echo.
echo ========== 构建失败！请检查上方错误信息 ==========
pause
exit /b 1
