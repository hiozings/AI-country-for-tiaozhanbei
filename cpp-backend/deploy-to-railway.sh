#!/bin/bash

###############################################################################
# Railway 快速部署脚本
# 
# 前置要求：
#   1. 安装 Railway CLI: npm install -g @railway/cli
#   2. 登录 Railway: railway login
#
# 使用方法：
#   cd cpp-backend
#   bash deploy-to-railway.sh
###############################################################################

set -e

echo "========================================="
echo "部署后端到 Railway"
echo "========================================="

# 检查是否已登录
if ! railway whoami &> /dev/null; then
    echo "请先登录 Railway: railway login"
    exit 1
fi

# 初始化项目（如果还没有）
if [ ! -f "railway.toml" ]; then
    echo "创建 Railway 配置..."
    cat > railway.toml << 'EOF'
[build]
builder = "DOCKERFILE"
dockerfilePath = "Dockerfile.railway"

[deploy]
startCommand = "./server"
healthcheckPath = "/"
healthcheckTimeout = 100
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 10
EOF
fi

# 链接到 Railway 项目
echo "链接到 Railway 项目..."
railway link

# 上传代码并部署
echo "开始部署..."
railway up

# 获取项目域名
DOMAIN=$(railway domain)
echo ""
echo "========================================="
echo "部署成功！"
echo "========================================="
echo "后端地址: wss://$DOMAIN"
echo ""
echo "下一步："
echo "1. 在 Railway Dashboard 中添加环境变量："
echo "   ARK_API_KEY=你的豆包API密钥"
echo "   DEEPSEEK_API_KEY=你的DeepSeek API密钥"
echo ""
echo "2. 在 Vercel 中设置环境变量："
echo "   VITE_WS_URL=wss://$DOMAIN"
echo ""
echo "3. 重新部署 Vercel 项目"
