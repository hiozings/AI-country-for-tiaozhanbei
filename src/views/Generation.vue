<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-white shadow-sm border-b">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex items-center">
            <h1 class="text-xl font-bold text-gray-900">智绘乡野</h1>
          </div>
          <div class="flex space-x-8">
            <router-link to="/" class="text-gray-900 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium" :class="{ 'text-blue-600': $route.name === 'Generation' }">创作</router-link>
            <router-link to="/community" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">社区</router-link>
            <router-link to="/assets" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">资产</router-link>
            <router-link to="/profile" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">我的</router-link>
          </div>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <div class="px-4 py-6 sm:px-0">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">生成页面</h2>

        <!-- Generation Form -->
        <div class="bg-white shadow rounded-lg p-6 mb-8">
          <h3 class="text-lg font-medium text-gray-900 mb-4">生成参数</h3>
          <form @submit.prevent="generateImage" class="space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700">模型选择</label>
                <select v-model="form.model" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                  <option value="model1">模型1</option>
                  <option value="model2">模型2</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">风格预设</label>
                <select v-model="form.style" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                  <option value="style1">风格1</option>
                  <option value="style2">风格2</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">画面比例</label>
                <select v-model="form.aspectRatio" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                  <option value="1:1">1:1</option>
                  <option value="16:9">16:9</option>
                  <option value="9:16">9:16</option>
                  <option value="4:3">4:3</option>
                  <option value="3:4">3:4</option>
                  <option value="2:3">2:3</option>
                  <option value="3:2">3:2</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700">随机种子（可选）</label>
                <input v-model="form.seed" type="number" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">反向提示词</label>
              <input v-model="form.negativePrompt" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 text-gray-900">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">提示词</label>
              <textarea v-model="form.prompt" rows="5" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 text-gray-900" placeholder="输入提示词描述你的灵感"></textarea>
            </div>
            <div class="flex justify-between items-center">
              <div class="text-sm text-gray-600">剩余点数：250</div>
              <div class="flex space-x-4">
                <button type="button" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 hover:scale-105 transition-all duration-200">历史记录</button>
                <button type="button" class="bg-[#FF9F1C] text-white px-4 py-2 rounded-md hover:bg-[#FFB347] hover:scale-105 transition-all duration-200">开通会员</button>
                <button type="submit" class="bg-[#FF9F1C] text-white px-4 py-2 rounded-md hover:bg-[#FFB347] hover:scale-105 transition-all duration-200">立即生成</button>
              </div>
            </div>
          </form>
        </div>

        <!-- Recent Generations -->
        <div class="bg-white shadow rounded-lg p-6">
          <h3 class="text-lg font-medium text-gray-900 mb-4">最近生成</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div v-for="image in recentImages" :key="image.id" class="bg-gray-50 rounded-lg p-4">
              <img :src="image.url" :alt="image.description" class="w-full h-48 object-cover rounded-md mb-4 hover:scale-105 transition-all duration-300 cursor-pointer">
              <p class="text-sm text-gray-600 mb-2">{{ image.description }}</p>
              <p class="text-xs text-gray-400 mb-4">{{ image.time }}</p>
              <button class="bg-[#FF9F1C] text-white px-3 py-1 rounded text-sm hover:bg-[#FFB347] hover:scale-105 transition-all duration-200">下载</button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

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
  // TODO: Implement image generation logic
  console.log('Generating image with:', form.value)
}
</script>