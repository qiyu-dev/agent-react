# 使用 Python 3.11 官方镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# 复制应用文件
COPY . .

# 暴露端口
EXPOSE 8000

# 启动命令 - 使用 shell 格式以正确解析 PORT 环境变量
CMD gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 wsgi:app
