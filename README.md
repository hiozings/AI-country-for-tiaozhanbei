# AI 乡村创作平台

一个基于 Vue 3 + TypeScript + Tailwind CSS 的 AI 图像生成应用，提供智能图像创作、社区分享和资产管理功能。

## 项目简介

本项目是一个全栈 AI 图像生成平台，包含：
- **前端**：Vue 3 + Vite + TypeScript + Tailwind CSS 构建的现代化单页应用
- **后端**：C++ WebSocket 服务器，集成豆包（Doubao）和 DeepSeek API，实现实时图像生成

## 技术栈

### 前端
- Vue 3.5+ (Composition API)
- TypeScript 5.8+
- Vite 7.0+
- Tailwind CSS 3.4+
- Vue Router 4.6+
- Vitest (单元测试)

### 后端
- C++17
- WebSocket++ (WebSocket 服务器)
- libcurl (HTTP 请求)
- OpenSSL (加密)
- JSON-CPP (JSON 解析)
- 豆包 & DeepSeek API 集成

## 环境要求

- Node.js 22+ 
- npm 或 yarn
- C++17 兼容编译器（g++ 或 clang++）
- CMake 3.10+
- 依赖库：libwebsocketpp, libcurl, libssl, libjsoncpp

## 安装与运行

### 前端设置

```bash
# 安装依赖
npm install

# 开发模式启动（热重载）
npm run dev

# 生产环境构建
npm run build

# 预览生产构建
npm run preview

# 类型检查
npm run type-check

# 代码格式化
npm run format

# 代码检查
npm run lint

# 运行单元测试
npm run test:unit
```

开发服务器默认运行在 `http://localhost:5173`

### 后端设置

#### 1. 安装依赖库

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y \
    libwebsocketpp-dev \
    libboost-all-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libjsoncpp-dev \
    cmake \
    g++
```

**macOS (Homebrew):**
```bash
brew install websocketpp boost curl openssl jsoncpp cmake
```

#### 2. 配置 API 密钥

创建环境变量文件或直接在编译时设置：

```bash
# 豆包 API 密钥
export DOUBAO_API_KEY="your_doubao_api_key"

# DeepSeek API 密钥（可选）
export DEEPSEEK_API_KEY="your_deepseek_api_key"
```

#### 3. 编译后端

```bash
cd cpp-backend

# 使用 CMake 构建
mkdir build && cd build
cmake ..
make

# 或直接使用 g++ 编译
g++ -std=c++17 main.cpp -o server \
    -lwebsocketpp \
    -lboost_system \
    -lcurl \
    -lssl \
    -lcrypto \
    -ljsoncpp \
    -lpthread
```

#### 4. 运行后端服务器

```bash
./server
```

后端 WebSocket 服务器默认运行在 `ws://localhost:8080`

### 完整启动流程

```bash
# 终端 1：启动后端
cd cpp-backend
./server

# 终端 2：启动前端
cd /path/to/project
npm run dev
```

## 项目结构

```
AI-country-for-tiaozhanbei/
├── src/                    # 前端源代码
│   ├── views/             # 页面组件
│   │   ├── Generation.vue    # 图像生成页面
│   │   ├── Community.vue     # 社区页面
│   │   ├── Assets.vue        # 资产管理页面
│   │   └── Profile.vue       # 个人中心页面
│   ├── components/        # 可复用组件
│   ├── router/           # 路由配置
│   ├── assets/           # 静态资源
│   └── main.ts           # 应用入口
├── cpp-backend/          # C++ 后端
│   └── main.cpp          # WebSocket 服务器主文件
├── package.json          # 前端依赖配置
├── vite.config.ts        # Vite 配置
├── tailwind.config.js    # Tailwind CSS 配置
└── tsconfig.json         # TypeScript 配置
```

## API 端点

### WebSocket 通信协议

前端通过 WebSocket 与后端通信：

**连接地址：** `ws://localhost:8080`

**请求格式：**
```json
{
  "type": "generate",
  "content": "一幅宁静的山景，日落时分，超写实风格",
  "model": "doubao"
}
```

**响应格式：**
```json
// 生成中状态
{
  "type": "typing",
  "status": true
}

// 生成完成
{
  "type": "image",
  "content": "data:image/jpeg;base64,..."
}

// 文本消息
{
  "type": "text",
  "content": "生成成功"
}
```