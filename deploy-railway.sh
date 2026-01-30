#!/bin/bash

# 🚀 一键 Railway 云部署脚本
# 此脚本会自动：1. 初始化 Git
# 2. 提交所有文件
# 3. 推送到 GitHub
# 4. 输出 Railway 部署链接

set -e

COLORS='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${COLORS}🚀 Agent ReAct Railway 一键部署脚本${NC}"
echo "================================"
echo ""

# 步骤 1: 检查 GitHub 账号
echo -e "${COLORS}📋 步骤 1: 准备 GitHub 仓库${NC}"
echo "你需要一个 GitHub 仓库。请先："
echo "1. 访问 https://github.com/new"
echo "2. 创建新仓库（名字如: agent-react）"
echo "3. 记下仓库 URL"
echo ""

read -p "已创建 GitHub 仓库？(y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ 请先创建 GitHub 仓库${NC}"
    exit 1
fi

# 步骤 2: 初始化 Git
echo -e "${COLORS}📦 步骤 2: 初始化 Git 仓库${NC}"
if [ ! -d .git ]; then
    git init
    git branch -M main
    echo -e "${GREEN}✅ Git 仓库已初始化${NC}"
else
    echo -e "${GREEN}✅ Git 仓库已存在${NC}"
fi
echo ""

# 步骤 3: 添加并提交文件
echo -e "${COLORS}📝 步骤 3: 提交文件${NC}"
git add .
git commit -m "Initial commit: Agent ReAct web app ready for deployment" || echo -e "${GREEN}✅ 文件已在版本控制中${NC}"
echo -e "${GREEN}✅ 文件已提交${NC}"
echo ""

# 步骤 4: 配置远程仓库
echo -e "${COLORS}🔗 步骤 4: 配置 GitHub 远程仓库${NC}"
read -p "输入你的 GitHub 仓库 URL (例如: https://github.com/username/agent-react.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo -e "${RED}❌ 仓库 URL 不能为空${NC}"
    exit 1
fi

if git remote | grep -q "^origin$"; then
    git remote set-url origin "$REPO_URL"
    echo -e "${GREEN}✅ 更新 origin 为: $REPO_URL${NC}"
else
    git remote add origin "$REPO_URL"
    echo -e "${GREEN}✅ 添加 origin: $REPO_URL${NC}"
fi
echo ""

# 步骤 5: 推送到 GitHub
echo -e "${COLORS}📤 步骤 5: 推送到 GitHub${NC}"
git push -u origin main
echo -e "${GREEN}✅ 代码已推送到 GitHub${NC}"
echo ""

# 步骤 6: 部署到 Railway
echo -e "${COLORS}☁️  步骤 6: 部署到 Railway${NC}"
echo -e "${GREEN}✅ GitHub 推送完成！${NC}"
echo ""
echo "现在打开浏览器访问："
echo -e "${COLORS}👉 https://railway.app/new${NC}"
echo ""
echo "按照以下步骤操作："
echo "1. 用 GitHub 账号登录 (如果还没登录)"
echo "2. 选择 'Deploy from GitHub repo'"
echo "3. 选择你的仓库 (agent-react)"
echo "4. Railway 自动检测并部署"
echo "5. 在 'Variables' 选项卡添加环境变量："
echo ""
echo "   SERPAPI_API_KEY = (你的 SerpAPI 密钥)"
echo "   LLM_API_KEY = (你的 ModelScope 密钥)"
echo "   LLM_MODEL_ID = Qwen/Qwen2.5-Coder-32B-Instruct"
echo "   LLM_BASE_URL = https://api-inference.modelscope.cn/v1/"
echo "   FLASK_ENV = production"
echo ""
echo "6. 等待部署完成（通常 1-2 分钟）"
echo "7. 获取你的应用 URL（如: https://agent-react-xyz.railway.app）"
echo ""
echo -e "${GREEN}🎉 完成！你的应用现在在线了！${NC}"
echo ""
echo "需要帮助？"
echo "- Railway 文档: https://docs.railway.app"
echo "- 项目文档: 查看 DEPLOYMENT.md 和 PLATFORMS.md"
