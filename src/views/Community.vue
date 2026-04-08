<template>
  <div class="min-h-screen bg-gray-50 flex">
    <!-- Left Sidebar Navigation -->
    <aside class="fixed left-0 top-0 h-full w-20 bg-white shadow-lg flex flex-col items-center py-8 space-y-8 z-10">
      <router-link 
        to="/" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Generation' }"
      >
        <span class="text-2xl">✏️</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">创作</span>
      </router-link>
      
      <router-link 
        to="/community" 
        class="group flex flex-col items-center"
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
        <div class="flex flex-col items-center gap-4">
          <h2 class="text-lg font-bold text-gray-900 text-center">灵感社区</h2>
          <div class="w-full max-w-3xl">
            <input
              type="text"
              placeholder="搜索模版、提示词或艺术家..."
              class="w-full px-4 py-2 rounded-xl border border-gray-100 bg-white text-gray-900 shadow-sm focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
            />
          </div>
          <div class="w-full max-w-3xl">
            <div class="flex flex-wrap gap-2 justify-start">
            <button 
              v-for="category in categories" 
              :key="category"
              @click="activeCategory = category"
              :class="[
                'px-4 py-2 rounded-xl font-medium whitespace-nowrap transition-all duration-200',
                activeCategory === category 
                  ? 'bg-[#FF9F1C] text-white' 
                  : 'bg-white text-gray-700 border border-gray-200 hover:bg-gray-50'
              ]"
            >
              {{ category }}
            </button>
          </div>
        </div>
      </div>
    </div>
    </div>

    <!-- Main Content -->
    <main class="flex-1 ml-20">
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 pt-28">
        <div class="px-4 py-6 sm:px-0">

          <!-- Community Works Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div v-for="work in communityWorks" :key="work.id" class="bg-white rounded-xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300">
              <div class="relative group aspect-square overflow-hidden">
                <img :src="work.image" :alt="work.title" class="w-full h-full object-cover hover:scale-105 transition-all duration-300 cursor-pointer">
                <div class="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300"></div>
                <div class="absolute inset-0 flex flex-col items-center justify-center gap-3 opacity-0 group-hover:opacity-100 transition-all duration-300">
                  <button class="bg-green-500 text-white px-5 py-2 rounded-full text-sm font-semibold hover:bg-green-600 transition">查看详情</button>
                  <button class="bg-white/40 backdrop-blur-md text-gray-900 px-5 py-2 rounded-full text-sm font-semibold hover:bg-white/60 transition">复制提示词</button>
                </div>
              </div>
              <div class="p-4">
                <h3 class="text-lg font-semibold text-gray-900 mb-2">{{ work.title }}</h3>
                <p class="text-sm text-gray-600 mb-3 line-clamp-2">{{ work.description }}</p>
                <div class="flex items-center space-x-2 mb-3 text-xs text-gray-500">
                  <span class="bg-gray-100 px-3 py-1 rounded-full">{{ work.creator }}</span>
                  <span class="bg-gray-100 px-3 py-1 rounded-full">{{ work.category }}</span>
                </div>
                <div class="flex justify-between items-center text-xs text-gray-500 border-t pt-3">
                  <div class="flex space-x-3">
                    <span class="flex items-center space-x-1">👍 {{ work.likes }}</span>
                    <span class="flex items-center space-x-1">💬 {{ work.comments }}</span>
                    <span class="flex items-center space-x-1">⭐ {{ work.favorites }}</span>
                  </div>
                  <button class="bg-[#FF9F1C] text-white px-3 py-1 rounded-lg hover:bg-[#FFB347] transition-colors">复制提示词</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Load More -->
          <div class="mt-12 flex justify-center">
            <button class="bg-[#FF9F1C] text-white px-6 py-2 rounded-xl hover:bg-[#FFB347] hover:scale-105 transition-all duration-200">加载更多</button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

interface CommunityWork {
  id: number
  title: string
  description: string
  image: string
  creator: string
  category: string
  likes: number
  comments: number
  favorites: number
}

const categories = ['全部', '人像', '奇幻', '建筑', '自然', '动漫', '3D']
const activeCategory = ref('全部')

const communityWorks = ref<CommunityWork[]>([
  {
    id: 1,
    title: '优雅人像',
    description: '专业影棚人像，优雅女性，柔和灯光，时尚摄影...',
    image: 'https://images.unsplash.com/photo-1603132789551-47b97377046e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHdvbWFuJTIwZWxlZ2FudHxlbnwxfHx8fDE3NzU0NzU0OTR8MA&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '艺术大师',
    category: '人像',
    likes: 2834,
    comments: 124,
    favorites: 586
  },
  {
    id: 2,
    title: '龙之守护者',
    description: '威严的巨龙，奇幻风景，史诗级画面，体积光照，电影感...',
    image: 'https://images.unsplash.com/photo-1610926597998-fc7f2c1b89b0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcmFnb24lMjBmYW50YXN5JTIwYXJ0fGVufDF8fHx8MTc3NTUxOTY3OXww&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '幻想视界',
    category: '奇幻',
    likes: 4521,
    comments: 287,
    favorites: 932
  },
  {
    id: 3,
    title: '现代建筑',
    description: '未来派建筑设计，简洁线条，玻璃幕墙，建筑摄影...',
    image: 'https://images.unsplash.com/photo-1652876256405-3902cc201b22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhcmNoaXRlY3R1cmUlMjBtb2Rlcm4lMjBidWlsZGluZ3xlbnwxfHx8fDE3NzU1MDQ0MzB8MA&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '城市设计',
    category: '建筑',
    likes: 1923,
    comments: 89,
    favorites: 412
  },
  {
    id: 4,
    title: '深海世界',
    description: '水下场景，海洋生物，生物发光生物，深海环境...',
    image: 'https://images.unsplash.com/photo-1680201540929-4fd82ca3add0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx1bmRlcndhdGVyJTIwb2NlYW4lMjBjcmVhdHVyZXN8ZW58MXx8fHwxNzc1NTY4MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '水之创意',
    category: '自然',
    likes: 3156,
    comments: 198,
    favorites: 678
  },
  {
    id: 5,
    title: '角色研究',
    description: '细节角色肖像，电影级灯光，超写实渲染，8K画质...',
    image: 'https://images.unsplash.com/photo-1653071163845-c5851ddedf95?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMG1hbiUyMGJlYXJkZWR8ZW58MXx8fHwxNzc1NTY4MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '肖像专家',
    category: '人像',
    likes: 2645,
    comments: 156,
    favorites: 521
  },
  {
    id: 6,
    title: '动漫风格',
    description: '动漫角色插画，鲜艳色彩，细节眼睛，漫画艺术风格...',
    image: 'https://images.unsplash.com/photo-1770116119330-2c80bc762d0b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhbmltZSUyMGNoYXJhY3RlciUyMGNvbG9yZnVsfGVufDF8fHx8MTc3NTU2ODEzMnww&ixlib=rb-4.1.0&q=80&w=1080',
    creator: '动漫艺术家',
    category: '动漫',
    likes: 5234,
    comments: 341,
    favorites: 1203
  }
])
</script>