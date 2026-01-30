# 各平台详细部署指南

## 🚀 Railway（推荐 - 最简单）

### 自动部署（仅需 5 分钟）
1. 访问 https://railway.app
2. 点击 "Create New Project" → "Deploy from GitHub repo"
3. 授权 GitHub 并选择你的仓库
4. Railway 自动检测并部署
5. 在 "Variables" 选项卡添加环境变量
6. 等待部署完成，获得公开 URL

### 环境变量配置
```
SERPAPI_API_KEY=your_key_here
LLM_API_KEY=your_key_here
LLM_MODEL_ID=Qwen/Qwen2.5-Coder-32B-Instruct
LLM_BASE_URL=https://api-inference.modelscope.cn/v1/
FLASK_ENV=production
```

**优点：** 简单快速、免费额度充足、自动 HTTPS

---

## 🔵 Vercel（适合简单应用）

### 手动部署步骤

1. **注册账号**
   - 访问 https://vercel.com
   - 用 GitHub 授权登录

2. **导入项目**
   - 点击 "New Project"
   - 选择你的 GitHub 仓库
   - 自动检测 Python 项目

3. **配置环境变量**
   - "Environment Variables" 选项卡
   - 添加所有必需的 API 密钥

4. **部署**
   - 点击 "Deploy" 开始构建
   - 等待部署完成

**⚠️ 注意：** Vercel 的免费层对长时间运行请求有限制（15秒超时），可能导致 agent 搜索超时。考虑升级付费计划或使用其他平台。

---

## 🐳 Docker（完全控制）

### 本地测试
```bash
# 构建镜像
docker build -t agent-react .

# 运行容器（使用 docker-compose）
docker-compose up

# 访问 http://localhost:5000
```

### 部署到云平台
**选项 A: Google Cloud Run（推荐 Docker）**
```bash
# 1. 安装 Google Cloud SDK
# 2. 认证
gcloud auth login

# 3. 推送镜像到 Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT/agent-react

# 4. 部署到 Cloud Run
gcloud run deploy agent-react \
  --image gcr.io/YOUR_PROJECT/agent-react \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars SERPAPI_API_KEY=your_key,LLM_API_KEY=your_key
```

**选项 B: AWS ECS**
1. 创建 ECR 仓库
2. 构建并推送 Docker 镜像
3. 创建 ECS 服务
4. 配置环境变量和安全组

---

## 🟠 Heroku（经典方案，需信用卡）

### 部署步骤

1. **安装 Heroku CLI**
   ```bash
   brew tap heroku/brew && brew install heroku
   heroku login
   ```

2. **创建 Heroku 应用**
   ```bash
   heroku create your-app-name
   ```

3. **添加环境变量**
   ```bash
   heroku config:set SERPAPI_API_KEY=your_key
   heroku config:set LLM_API_KEY=your_key
   heroku config:set LLM_MODEL_ID=Qwen/Qwen2.5-Coder-32B-Instruct
   heroku config:set LLM_BASE_URL=https://api-inference.modelscope.cn/v1/
   ```

4. **部署**
   ```bash
   git push heroku main
   ```

5. **查看日志**
   ```bash
   heroku logs --tail
   ```

**成本：** 免费 dyno 已停用，最低需要 $7/月的标准 dyno

---

## 🟣 PythonAnywhere（完全为 Python 优化）

### 部署步骤

1. **注册免费账号**
   - https://www.pythonanywhere.com
   - 选择免费计划（pythonanywhere.com 子域）

2. **上传代码**
   选项 A: 从 GitHub Clone
   ```bash
   # 在 PythonAnywhere 控制台
   git clone https://github.com/YOUR_USERNAME/your-repo.git
   ```

3. **创建虚拟环境**
   ```bash
   # 在 Web 选项卡，创建新 Web App
   # 选择 Python 版本
   # 配置虚拟环境路径
   ```

4. **安装依赖**
   ```bash
   pip install -r requirements.txt
   ```

5. **配置 WSGI**
   编辑 WSGI 文件（通常在 `/var/www/YOUR_USERNAME_pythonanywhere_com_wsgi.py`）：
   ```python
   import sys
   path = '/home/YOUR_USERNAME/your-repo'
   if path not in sys.path:
       sys.path.append(path)
   from web import app as application
   ```

6. **设置环境变量**
   在虚拟环境的 `bin/activate` 中添加：
   ```bash
   export SERPAPI_API_KEY="your_key"
   export LLM_API_KEY="your_key"
   export LLM_MODEL_ID="Qwen/Qwen2.5-Coder-32B-Instruct"
   export LLM_BASE_URL="https://api-inference.modelscope.cn/v1/"
   ```

7. **重载 Web App**
   在 PythonAnywhere 仪表板点击 "Reload"

**优点：** 专为 Python 设计、界面友好、免费额度可用

---

## 🟢 快速部署脚本

### 一键推送到 GitHub
```bash
chmod +x deploy.sh
./deploy.sh
```

然后：
1. 选择 Railway（最简单）
2. 连接 GitHub 仓库
3. 添加环境变量
4. 自动部署

---

## 🔐 安全最佳实践

部署前必须做：
- [ ] `.env` 已加入 `.gitignore`
- [ ] 所有 API 密钥都通过环境变量传入（不硬编码）
- [ ] 本地测试通过
- [ ] 仓库设置为私密（如包含敏感信息）
- [ ] 定期轮换 API 密钥

---

## 📊 平台对比表

| 平台 | 难度 | 成本 | 冷启动 | 超时限制 | 推荐度 |
|------|------|------|--------|---------|--------|
| Railway | ⭐ 最简单 | 免费/付费 | <1分钟 | 30分钟+ | ⭐⭐⭐⭐⭐ |
| Vercel | ⭐⭐ 简单 | 免费/付费 | <1分钟 | 15秒 | ⭐⭐⭐ |
| Docker + Cloud Run | ⭐⭐⭐ 中等 | ~$1/月 | 30秒 | 1小时 | ⭐⭐⭐⭐ |
| Heroku | ⭐⭐ 简单 | $7/月+ | 30秒 | 30分钟 | ⭐⭐⭐ |
| PythonAnywhere | ⭐⭐ 简单 | 免费/付费 | 1-2分钟 | 5分钟 | ⭐⭐⭐⭐ |

---

## 常见问题

**Q: 部署后 agent 搜索超时？**
A: 增加超时限制。在 Railway 或其他平台增加 WSGI 超时配置。

**Q: API 密钥暴露了怎么办？**
A: 立即在 API 提供商处重新生成密钥。

**Q: 如何查看部署日志？**
A: 每个平台的仪表板都有 "Logs" 选项卡。

**Q: 如何自动更新部署？**
A: 在 GitHub push 时自动触发（大多数平台支持）。

---

需要帮助？查看各平台官方文档或联系平台客服。
