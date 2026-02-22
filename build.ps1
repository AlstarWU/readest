# build.ps1 - Tauri Build Script

# 1. 安装所有依赖 (在项目根目录)
Write-Host "Installing dependencies..."
pnpm install
if ($LASTEXITCODE -ne 0) { Write-Error "pnpm install failed."; exit 1 }

# 2. 准备 vendor 文件
Write-Host "Preparing vendor files..."
pnpm --filter @readest/readest-app setup-vendors
if ($LASTEXITCODE -ne 0) { Write-Error "setup-vendors failed."; exit 1 }

# 3. 构建前端资源
Write-Host "Building frontend resources..."
Set-Location -Path "e:\Code\Git\readest\apps\readest-app"
pnpm build
if ($LASTEXITCODE -ne 0) { Write-Error "Frontend build failed."; exit 1 }
Set-Location -Path "e:\Code\Git\readest" # 返回项目根目录

# 4. 构建 Tauri 应用
Write-Host "Building Tauri application..."
# 注意：这里使用 `pnpm --filter @readest/readest-app tauri build` 是为了确保在正确的子项目上下文中执行 tauri 命令
pnpm --filter @readest/readest-app tauri build
if ($LASTEXITCODE -ne 0) { Write-Error "Tauri build failed."; exit 1 }

Write-Host "Build process completed successfully!"
