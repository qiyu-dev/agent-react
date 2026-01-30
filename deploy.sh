#!/bin/bash
# 快速部署脚本 - 将项目推送到 GitHub

set -e

echo "🚀 Agent ReAct 部署脚本"
echo "=========================="

# 检查 git 是否初始化
if [ ! -d .git ]; then
    echo "📝 初始化 git 仓库..."
    git init
    git branch -M main
else
    echo "✅ Git 仓库已初始化"
fi

# 添加所有文件
echo "📦 添加文件到暂存区..."
git add .

# 创建提交
read -p "📝 请输入提交信息 (默认: 'Deploy: Agent ReAct web app'): " commit_msg
commit_msg=${commit_msg:-"Deploy: Agent ReAct web app"}
git commit -m "$commit_msg" || echo "⚠️  没有新文件需要提交"

# 添加远程仓库
echo ""
echo "🔗 配置远程仓库..."
read -p "请输入 GitHub 仓库 URL (格式: https://github.com/USERNAME/REPO.git): " repo_url

if [ -z "$repo_url" ]; then
    echo "❌ 错误: 仓库 URL 不能为空"
    exit 1
fi

# 检查是否已有 origin
if git remote | grep -q "^origin$"; then
    echo "更新现有 origin..."
    git remote set-url origin "$repo_url"
else
    echo "添加新的 origin..."
    git remote add origin "$repo_url"
fi

# 推送到 GitHub
echo "📤 推送到 GitHub..."
git push -u origin main || {
    echo "❌ 推送失败，请检查网络和仓库 URL"
    exit 1
}

echo ""
echo "✅ 成功推送到 GitHub！"
echo ""
echo "🌐 接下来的步骤："
echo "   1. 访问 https://railway.app"
echo "   2. 用 GitHub 账号登录"
echo "   3. 创建新项目 → 选择刚推送的仓库"
echo "   4. 添加环境变量（SERPAPI_API_KEY, LLM_API_KEY 等）"
echo "   5. 自动部署完成！"
echo ""
echo "📚 详细指南见 DEPLOYMENT.md"
