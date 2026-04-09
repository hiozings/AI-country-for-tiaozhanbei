<template>
  <div class="min-h-screen bg-gray-50 flex">
    <!-- Left Sidebar Navigation -->
    <aside class="fixed left-0 top-0 h-full w-20 bg-white shadow-lg flex flex-col items-center py-8 space-y-8 z-10">
      <router-link 
        to="/" 
        class="group flex flex-col items-center"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Generation' }"
      >
        <span class="text-2xl">✏️</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">创作</span>
      </router-link>
      
      <router-link 
        to="/community" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Community' }"
      >
        <span class="text-2xl">👥</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">社区</span>
      </router-link>
      
      <router-link 
        to="/assets" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Assets' }"
      >
        <span class="text-2xl">🎨</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">资产</span>
      </router-link>
      
      <router-link 
        to="/profile" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Profile' }"
      >
        <span class="text-2xl">👤</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">我的</span>
      </router-link>
    </aside>

    <!-- Right Top Actions -->
    <div class="fixed top-4 left-20 right-4 z-10">
      <div class="bg-white/80 backdrop-blur-sm border border-gray-200/70 rounded-[32px] p-4 shadow-lg">
        <div class="flex items-center justify-between gap-4">
          <h2 class="text-lg font-bold text-gray-900">生成页面</h2>
          <div class="flex space-x-4">
            <button type="button" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-xl hover:bg-gray-300 hover:scale-105 transition-all duration-200">历史记录</button>
            <button type="button" class="bg-green-500 text-white px-4 py-2 rounded-xl hover:bg-green-600 hover:scale-105 transition-all duration-200">开通会员</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <main class="flex-1 ml-20">
      <!-- Page Content -->
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 pt-20">
        <div class="px-4 py-6 sm:px-0">

          <!-- Prompt Input Section -->
          <div class="bg-white shadow rounded-lg p-6 mb-8">
            <h3 class="text-lg font-medium text-gray-900 mb-4">输入提示词描述你的灵感</h3>
            <div class="space-y-4">
              <div>
                <textarea v-model="form.prompt" rows="5" class="mt-1 block w-full rounded-xl border border-gray-100 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500 text-gray-900 px-3 py-2" placeholder="一幅宁静的山景，日落时分，超写实风格..."></textarea>
              </div>
            </div>
            <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between mt-4">
              <button type="button" @click="generateImage" :disabled="isGenerating" class="inline-flex items-center justify-center bg-[#FF9F1C] text-white px-4 py-2 rounded-xl hover:bg-[#FFB347] hover:scale-105 transition-all duration-200 disabled:opacity-60 disabled:cursor-not-allowed">
                {{ isGenerating ? '生成中...' : '立即生成' }}
              </button>
              <div class="text-sm text-gray-600">剩余点数：250</div>
            </div>
            <p class="mt-3 text-sm text-orange-600" v-if="statusMessage">{{ statusMessage }}</p>
          </div>

        <!-- Generation Form -->
        <div class="bg-white shadow rounded-lg p-6 mb-8">
          <h3 class="text-lg font-medium text-gray-900 mb-4">生成参数</h3>
          <form @submit.prevent="generateImage" class="space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700">模型选择</label>
                <select v-model="form.model" class="mt-1 block w-full rounded-xl border border-gray-100 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500 text-gray-900 px-3 py-2 bg-white">
                  <option value="dalle3">DALL-E 3</option>
                  <option value="midjourney">Midjourney V</option>
                  <option value="sdxl">Stable Diffusion XL</option>
                  <option value="flux">Flux Pro</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">风格预设</label>
                <select v-model="form.style" class="mt-1 block w-full rounded-xl border border-gray-100 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500 text-gray-900 px-3 py-2 bg-white">
                  <option value="realism">写实风格</option>
                  <option value="art">艺术风格</option>
                  <option value="anime">动漫风格</option>
                  <option value="3d">3D渲染</option>
                  <option value="oil">油画风格</option>
                  <option value="watercolor">水彩风格</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">画面比例</label>
                <div class="mt-1 flex space-x-2">
                  <button 
                    v-for="ratio in aspectRatios" 
                    :key="ratio.value"
                    @click="form.aspectRatio = ratio.value"
                    :class="[
                      'px-3 py-2 rounded-xl transition-all duration-200',
                      form.aspectRatio === ratio.value 
                        ? 'bg-[#FF9F1C] text-white border border-[#FF9F1C]' 
                        : 'bg-white text-gray-700 hover:bg-gray-50'
                    ]"
                  >
                    {{ ratio.label }}
                  </button>
                </div>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">随机种子（可选）</label>
                <input v-model="form.seed" type="number" class="mt-1 block w-full rounded-xl border border-gray-100 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500 text-gray-900 px-3 py-2 bg-white">
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">反向提示词</label>
              <input v-model="form.negativePrompt" type="text" class="mt-1 block w-full rounded-xl border border-gray-100 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500 text-gray-900 px-3 py-2" placeholder="输入反向提示词">
            </div>
          </form>
        </div>

        <!-- Recent Generations -->
        <div class="bg-white shadow rounded-lg p-6">
          <h3 class="text-lg font-medium text-gray-900 mb-4">最近生成</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div v-for="image in recentImages" :key="image.id" class="rounded-xl overflow-hidden shadow-lg">
              <div class="relative group aspect-square">
                <img :src="image.url" :alt="image.description" class="w-full h-full object-cover hover:scale-105 transition-all duration-300 cursor-pointer">
                <!-- Download button with glassmorphism effect -->
                <button class="absolute bottom-4 left-4 right-4 bg-white/30 backdrop-blur-md text-white px-4 py-2 rounded-xl transition-all duration-200 opacity-0 group-hover:opacity-100 hover:bg-white/50 hover:scale-105 font-medium">下载</button>
              </div>
              <div class="bg-gray-50 p-4">
                <p class="text-sm text-gray-600 mb-2">{{ image.description }}</p>
                <p class="text-xs text-gray-400">{{ image.time }}</p>
              </div>
            </div>
          </div>
        </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'

interface GenerationForm {
  model: string
  style: string
  aspectRatio: string
  seed: string
  negativePrompt: string
  prompt: string
}

interface RecentImage {
  id: number
  url: string
  description: string
  time: string
}

const ws = ref<WebSocket | null>(null)
const statusMessage = ref('')
const isGenerating = ref(false)
const pendingPrompt = ref<string | null>(null)

const sendGenerateRequest = (prompt: string) => {
  if (!ws.value || ws.value.readyState !== WebSocket.OPEN) {
    pendingPrompt.value = prompt
    connectWebSocket()
    statusMessage.value = '正在连接后端，请稍候...'
    isGenerating.value = true
    return
  }

  const payload = {
    type: 'generate',
    content: prompt,
    model: 'doubao'
  }

  ws.value.send(JSON.stringify(payload))
  statusMessage.value = '正在生成，请稍候...'
  isGenerating.value = true
}

const connectWebSocket = () => {
  if (ws.value && ws.value.readyState === WebSocket.OPEN) {
    return
  }

  // 自动选择 ws 或 wss，使用页面的主机名作为目标主机（若需要可替换为具体主机）
  const proto = window.location.protocol === 'https:' ? 'wss' : 'ws'
  const host = window.location.hostname || 'localhost'
  const url = `${proto}://${host}:8080`
  console.log('[Generation] connecting websocket to', url)

  try {
    ws.value = new WebSocket(url)
  } catch (e) {
    console.error('[Generation] WebSocket create error', e)
    statusMessage.value = '无法创建 WebSocket 连接，请检查后端是否可达。'
    return
  }

  ws.value.onopen = () => {
    console.log('[Generation] websocket open')
    statusMessage.value = '已连接后端，准备生成图片。'
    if (pendingPrompt.value) {
      const promptToSend = pendingPrompt.value
      pendingPrompt.value = null
      sendGenerateRequest(promptToSend)
    }
  }

  ws.value.onmessage = (event: MessageEvent) => {
    console.log('[Generation] ws message', event.data)
    try {
      const data = JSON.parse(event.data)
      if (data.type === 'typing') {
        statusMessage.value = data.status ? '正在生成，请稍候...' : '生成完成。'
        return
      }

      if (data.type === 'image' && typeof data.content === 'string') {
        const imageUrl = data.content
        recentImages.value.unshift({
          id: Date.now(),
          url: imageUrl,
          description: form.value.prompt || 'AI 生成图像',
          time: '刚刚'
        })
        isGenerating.value = false
        statusMessage.value = '生成成功，已加入最近生成。'
        return
      }

      if (data.type === 'text' && typeof data.content === 'string') {
        statusMessage.value = data.content
        isGenerating.value = false
      }
    } catch (e) {
      console.error('[Generation] WebSocket message parse error:', e, event.data)
      statusMessage.value = '收到未知响应。'
      isGenerating.value = false
    }
  }

  ws.value.onerror = () => {
    statusMessage.value = '后端连接失败，请检查后端是否已启动。'
    isGenerating.value = false
  }

  ws.value.onclose = () => {
    statusMessage.value = '后端连接已关闭。'
    isGenerating.value = false
  }
}

onMounted(() => {
  connectWebSocket()
})

onBeforeUnmount(() => {
  if (ws.value) {
    ws.value.close()
    ws.value = null
  }
})

const aspectRatios = [
  { value: '1:1', label: '1:1' },
  { value: '16:9', label: '16:9' },
  { value: '9:16', label: '9:16' },
  { value: '4:3', label: '4:3' },
  { value: '3:4', label: '3:4' },
  { value: '2:3', label: '2:3' },
  { value: '3:2', label: '3:2' }
]

const form = ref<GenerationForm>({
  model: 'model1',
  style: 'style1',
  aspectRatio: '1:1',
  seed: '',
  negativePrompt: '',
  prompt: ''
})

const recentImages = ref<RecentImage[]>([
  {
    id: 1,
    url: 'https://images.unsplash.com/photo-1713188090500-a4fb0d2cf309?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhYnN0cmFjdCUyMGRpZ2l0YWwlMjBhcnQlMjBjb2xvcmZ1bHxlbnwxfHx8fDE3NzU1NjgwODJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    description: '抽象数字艺术，流动的色彩',
    time: '2小时前'
  },
  {
    id: 2,
    url: 'https://images.unsplash.com/photo-1763198216782-b534fea3dcf1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmdXR1cmlzdGljJTIwbGFuZHNjYXBlJTIwc2NpLWZpfGVufDF8fHx8MTc3NTU2ODA4Mnww&ixlib=rb-4.1.0&q=80&w=1080',
    description: '未来主义科幻风景，黎明时分',
    time: '5小时前'
  },
  {
    id: 3,
    url: 'https://images.unsplash.com/photo-1774744799470-c2cbddfebf92?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmYW50YXN5JTIwY2FzdGxlJTIwbWFnaWNhbHxlbnwxfHx8fDE3NzU1MzIwMzB8MA&ixlib=rb-4.1.0&q=80&w=1080',
    description: '中世纪城堡，魔法极光',
    time: '1天前'
  },
  {
    id: 4,
    url: 'https://images.unsplash.com/photo-1641650265007-b2db704cd9f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjeWJlcnB1bmslMjBjaXR5JTIwbmVvbnxlbnwxfHx8fDE3NzU0OTgyNTJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    description: '霓虹灯赛博朋克都市',
    time: '2天前'
  },
  {
    id: 5,
    url: 'https://images.unsplash.com/photo-1709409903008-fbc1ce9b7dfa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcGFjZSUyMG5lYnVsYSUyMHN0YXJzfGVufDF8fHx8MTc3NTUxMDg1N3ww&ixlib=rb-4.1.0&q=80&w=1080',
    description: '宇宙星云与星辰',
    time: '3天前'
  },
  {
    id: 6,
    url: 'https://images.unsplash.com/photo-1635098765215-40d07ea6a4f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxuYXR1cmUlMjBtb3VudGFpbiUyMHN1bnNldHxlbnwxfHx8fDE3NzU1NjgwODR8MA&ixlib=rb-4.1.0&q=80&w=1080',
    description: '黄金时刻的山景',
    time: '1周前'
  }
])

const generateImage = () => {
  if (!form.value.prompt.trim()) {
    statusMessage.value = '请输入生成提示词后再试。'
    return
  }

  sendGenerateRequest(form.value.prompt)
}
</script>