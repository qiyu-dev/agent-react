# README.md

# 🤖 Agent ReAct - 智能助手平台

基于 **ReAct 框架**的本地 + 云端智能助手，支持实时网络搜索、多轮对话、自动推理。

## ✨ 功能特性

- 🧠 **ReAct 框架** - 思考 (Thought) → 行动 (Action) → 观察 (Observation) 循环
- 🔍 **实时网络搜索** - 集成 SerpAPI 获取最新信息
- 💬 **Web 对话界面** - 现代化 UI，参考 ChatGPT 设计
- ☁️ **云端部署** - 支持 Railway、Vercel、Docker 等多种部署方式
- 🌍 **本地 + 远程** - 既可本地运行也可部署到云
- 📱 **响应式设计** - 适配桌面和手机

## 🚀 快速开始

### 本地运行

**环境要求：** Python 3.11+, pip, 虚拟环境

```bash
# 1. 克隆项目
git clone https://github.com/YOUR_USERNAME/agent-react.git
cd agent-react

# 2. 创建虚拟环境
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# 或
.venv\Scripts\activate  # Windows

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置环境变量
cp .env.example .env
# 编辑 .env，填入 API 密钥

# 5. 运行应用
python web.py

# 6. 打开浏览器
# http://localhost:5001
```

### 云端部署（推荐 Railway）

**30 秒快速部署：**

1. 将代码推送到 GitHub
2. 访问 https://railway.app
3. 授权 GitHub 并选择仓库
4. 添加环境变量
5. 自动部署完成！

详见 [DEPLOYMENT.md](DEPLOYMENT.md) 和 [PLATFORMS.md](PLATFORMS.md)

## 📋 配置

### 必需 API 密钥

1. **SerpAPI（网页搜索）**
   - 注册：https://serpapi.com
   - 免费额度：100 请求/月
   - 获取密钥并添加到 `.env`

2. **大语言模型**
   - 使用 ModelScope（阿里开源）的 Qwen 模型
   - 免费 API：https://modelscope.cn
   - 添加 API 密钥到 `.env`

### .env 配置

```bash
SERPAPI_API_KEY=your_serpapi_key
LLM_API_KEY=your_modelscope_key
LLM_MODEL_ID=Qwen/Qwen2.5-Coder-32B-Instruct
LLM_BASE_URL=https://api-inference.modelscope.cn/v1/
LLM_TIMEOUT=120
FLASK_ENV=production
```

## 📁 项目结构

```
agent-react/
├── web.py                    # Flask 服务入口
├── React.py                  # ReAct 核心逻辑
├── tools.py                  # 工具执行器
├── LLM.py                    # LLM 客户端
├── templates/
│   └── index.html           # Web UI 前端
├── requirements.txt         # Python 依赖
├── Dockerfile               # Docker 容器配置
├── docker-compose.yml       # Docker Compose 配置
├── Procfile                 # Heroku/Railway 配置
├── DEPLOYMENT.md            # 部署指南
├── PLATFORMS.md             # 多平台部署详解
├── .env.example             # 环境变量模板
└── .gitignore              # Git 忽略文件
```

## 🔧 开发

### 添加新工具

在 `tools.py` 中定义函数，然后在 `web.py` 或 `React.py` 中注册：

```python
def my_tool(query: str) -> str:
    """我的自定义工具"""
    return f"处理: {query}"

tool_executor.register_tool("MyTool", "工具描述", my_tool)
```

### 修改 Prompt

编辑 `React.py` 中的 `REACT_PROMPT_TEMPLATE` 以优化 agent 行为。

### 本地调试

```bash
# 启用 Flask 调试模式
FLASK_ENV=development python web.py
```

## 📊 使用示例

### 查询当前信息
```
用户: "2026年最流行的编程语言是什么？"
Agent: [执行搜索] → [分析结果] → [返回答案]
```

### 多步推理
```
用户: "苹果和微软最近各发布了什么新产品？"
Agent: [搜索苹果新产品] → [搜索微软新产品] → [总结对比]
```

## ⚙️ 故障排查

**问题：本地运行报错 `ModuleNotFoundError`**
```bash
# 确保激活虚拟环境
source .venv/bin/activate
pip install -r requirements.txt
```

**问题：API 密钥无效**
- 检查 `.env` 文件是否正确配置
- 验证 API 密钥未过期
- 检查 API 配额是否已用尽

**问题：云端部署超时**
- 增加平台的超时配置
- 使用异步任务队列（后续版本支持）

详细故障排查见 [DEPLOYMENT.md](DEPLOYMENT.md)

## 📚 相关资源

- [ReAct 论文](https://arxiv.org/abs/2210.03629) - 原始论文
- [SerpAPI 文档](https://serpapi.com/docs) - 搜索 API
- [ModelScope 文档](https://modelscope.cn) - LLM 提供商
- [Flask 文档](https://flask.palletsprojects.com) - Web 框架

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License - 自由使用和修改

## 👤 作者

Created with ❤️ for AI enthusiasts

---

**有问题？** 查看 [DEPLOYMENT.md](DEPLOYMENT.md) 或 [PLATFORMS.md](PLATFORMS.md)

**想要部署？** 按照[快速开始](#快速开始)中的步骤操作
