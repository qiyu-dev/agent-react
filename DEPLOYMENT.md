# 云端部署指南

## 部署选项（推荐 Railway）

### 方案 1: Railway（推荐 ⭐）
最简单快速的云部署方案，支持免费额度。

**步骤：**
1. 注册账号：https://railway.app
2. 连接 GitHub 账号
3. 创建新项目 → 选择 GitHub 仓库
4. 设置环境变量（参考下面的 `.env.example`）
5. 自动部署完成

**环境变量配置：**
在 Railway 仪表板中添加以下环境变量：
```
SERPAPI_API_KEY=your_serpapi_key_here
LLM_API_KEY=your_llm_api_key
LLM_MODEL_ID=Qwen/Qwen2.5-Coder-32B-Instruct
LLM_BASE_URL=https://api-inference.modelscope.cn/v1/
FLASK_ENV=production
```

---

### 方案 2: Vercel（适合简单应用）
**步骤：**
1. 注册：https://vercel.com
2. GitHub 授权
3. Import 项目
4. 设置环境变量
5. 部署

**注意：** Vercel 默认不支持长时间运行的请求，可能导致 agent 搜索超时。

---

### 方案 3: PythonAnywhere（完全为 Python 优化）
**步骤：**
1. 注册免费账号：https://www.pythonanywhere.com
2. 上传代码或从 GitHub clone
3. 创建 Web app → Flask
4. 配置虚拟环境和依赖
5. 设置 WSGI 文件

---

## 本地快速测试

在部署前，确保本地运行正常：
```bash
# 安装依赖
source .venv/bin/activate
pip install -r requirements.txt

# 运行
python web.py
```

访问 http://127.0.0.1:5001

---

## 部署前检查清单

- [ ] 已上传代码到 GitHub 公开/私有仓库
- [ ] 已生成 `requirements.txt`
- [ ] 已生成 `Procfile`（如果使用 Heroku/Railway）
- [ ] 已配置所有环境变量（API 密钥）
- [ ] `.env` 文件已添加到 `.gitignore`（防止泄露密钥）
- [ ] 本地测试通过

---

## 推荐的快速部署流程（Railway）

```bash
# 1. 初始化 git 仓库（如果还没有）
git init
git add .
git commit -m "Init: Agent ReAct web interface"
git remote add origin https://github.com/YOUR_USERNAME/your-repo.git
git branch -M main
git push -u origin main

# 2. 在 Railway 仪表板中：
#    - 连接 GitHub
#    - 选择刚推送的仓库
#    - 添加环境变量
#    - 自动部署开始
```

完成后，你会得到一个公开 URL 如：
```
https://your-app-123abc.railway.app
```

---

## 故障排查

### 502 Bad Gateway / 超时
- 原因：web 搜索或 LLM 调用耗时过长
- 解决：在云平台增加超时配置或使用异步处理

### 环境变量未加载
- 检查环境变量名称是否正确
- 重启应用服务

### API 密钥无效
- 确保 API 密钥正确
- 检查 API 配额是否已用完

---

## 后续优化

部署成功后可考虑：
- [ ] 添加请求日志和监控
- [ ] 实现异步任务队列（Celery + Redis）
- [ ] 添加用户认证
- [ ] 数据库存储对话历史
- [ ] CDN 加速前端资源
