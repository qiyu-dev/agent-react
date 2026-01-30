# 🎯 Railway 部署完整指南

## 前提准备（10 分钟）

### 1️⃣ 准备 API 密钥

在开始部署前，确保你已有：

**A. SerpAPI 密钥**
- 访问：https://serpapi.com
- 免费注册获得 100 次/月 免费额度
- 找到你的 API 密钥并复制

**B. ModelScope LLM 密钥**
- 访问：https://modelscope.cn
- 用邮箱/手机注册
- 在"个人中心" → "API Token" 获取密钥

✅ 现在你有了两个密钥，记在安全的地方

---

## 部署步骤（5 分钟）

### 第 1 步：推送代码到 GitHub

在项目目录运行一键部署脚本：

```bash
chmod +x deploy-railway.sh
./deploy-railway.sh
```

脚本会：
1. 初始化 Git 仓库
2. 提交所有文件
3. 推送到你的 GitHub 仓库

**如果你已有 GitHub 仓库，可以手动推送：**

```bash
git init
git add .
git commit -m "Deploy: Agent ReAct"
git remote add origin https://github.com/YOUR_USERNAME/agent-react.git
git branch -M main
git push -u origin main
```

### 第 2 步：在 Railway 上创建项目

1. **访问 Railway**
   - 打开：https://railway.app
   - 点击右上角 "Create New" 或访问：https://railway.app/new

2. **授权 GitHub**
   - 选择 "Deploy from GitHub repo"
   - 点击 "Connect GitHub"
   - 授权 Railway 访问你的 GitHub

3. **选择仓库**
   - 找到你的 `agent-react` 仓库
   - 点击它
   - Railway 自动检测 Python/Flask 项目

4. **等待初始部署**
   - Railway 会自动：
     - 拉取代码
     - 安装依赖（requirements.txt）
     - 构建应用
     - 启动服务
   - 这需要 1-2 分钟，查看实时日志

### 第 3 步：配置环境变量 ⚙️

部署过程中或之后，需要添加环境变量：

1. **打开项目仪表板**
   - 点击你的项目
   - 进入项目详情页

2. **找到 "Variables" 选项卡**
   - 点击 "Add Variable"
   - 一次添加以下变量（复制粘贴）：

| 变量名 | 值 |
|--------|-----|
| `SERPAPI_API_KEY` | (粘贴你的 SerpAPI 密钥) |
| `LLM_API_KEY` | (粘贴你的 ModelScope 密钥) |
| `LLM_MODEL_ID` | `Qwen/Qwen2.5-Coder-32B-Instruct` |
| `LLM_BASE_URL` | `https://api-inference.modelscope.cn/v1/` |
| `FLASK_ENV` | `production` |

**逐个步骤：**
```
1. 点击 "Raw Editor"（可选，但更快）
2. 粘贴以下内容：

SERPAPI_API_KEY=your_key_here
LLM_API_KEY=your_key_here
LLM_MODEL_ID=Qwen/Qwen2.5-Coder-32B-Instruct
LLM_BASE_URL=https://api-inference.modelscope.cn/v1/
FLASK_ENV=production

3. 点击 "Save"
```

3. **重新部署**
   - 点击 "Redeploy"
   - 等待新部署完成（通常 30 秒）

### 第 4 步：获取应用 URL 🎉

部署完成后：

1. **查看 URL**
   - 在 "Deployments" 或项目首页找到你的应用 URL
   - 看起来像：`https://agent-react-xyz.railway.app`

2. **打开应用**
   - 在浏览器打开你的 URL
   - 看到聊天界面就成功了！

3. **分享链接**
   - 复制 URL 给朋友
   - 任何人都可以访问和使用你的 agent！

---

## ✅ 验证部署成功

### 检查清单

- [ ] 代码已推送到 GitHub
- [ ] Railway 项目已创建
- [ ] 所有环境变量已添加
- [ ] 部署状态显示 "Success"（绿色✅）
- [ ] 可以访问应用 URL
- [ ] 输入问题 → 收到回答

### 常见问题

**Q: 打开 URL 显示 502 错误？**
A: 
1. 检查环境变量是否全部添加
2. 查看 "Logs" 标签找错误信息
3. 点击 "Redeploy" 重新部署
4. 等待 2 分钟重试

**Q: 提交问题后没有回答？**
A:
1. 检查 SERPAPI_API_KEY 是否正确
2. 查看 Railway 日志找错误
3. 确保 LLM_API_KEY 有效且未过期

**Q: 如何查看应用日志？**
A:
1. Railway 项目 → "Deployments" 选项卡
2. 找到最新的部署
3. 点击它 → "Logs" 查看实时日志

**Q: 如何更新应用代码？**
A:
1. 本地修改代码
2. `git add . && git commit -m "update" && git push`
3. Railway 自动检测并重新部署（2-3 分钟）

---

## 🔐 安全提示

- ❌ 不要在代码中硬编码 API 密钥
- ✅ 始终使用环境变量
- ✅ 定期轮换 API 密钥
- ✅ 如果密钥泄露，立即重新生成
- ✅ 定期检查 Railway 的账单和配额

---

## 📊 监控和维护

### 查看应用状态

Railway 仪表板显示：
- **CPU/内存使用** — 实时监控
- **数据传入/传出** — 网络流量
- **请求日志** — 每个 HTTP 请求

### 缩放应用

如果流量增加，可以：
1. 升级到 Railway 付费计划
2. 增加实例数量
3. 增加内存/CPU 分配

---

## 💡 下一步

部署成功后，可以考虑：

1. **添加自定义域名**
   - Railway → "Custom Domain" 选项卡
   - 连接你自己的域名

2. **优化应用**
   - 添加更多工具/功能
   - 改进 UI 和 UX
   - 添加数据库保存对话历史

3. **添加认证**
   - 限制谁能使用你的应用
   - 添加用户注册/登录

4. **监控和日志**
   - 集成第三方监控服务
   - 设置错误告警

---

## 📞 获得帮助

- **Railway 文档**：https://docs.railway.app
- **Railway 社区**：https://railway.app/community
- **本项目 GitHub Issues**：在你的仓库中报告问题

---

**🎉 恭喜！你的 Agent ReAct 应用现已在线！**

分享你的应用 URL，让更多人体验 AI 助手的魔力！
