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
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 pt-48">
        <div class="px-4 py-6 sm:px-0">

          <!-- Community Works Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div v-for="work in communityWorks" :key="work.id" class="rounded-xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300 bg-white">
              <div class="relative overflow-hidden rounded-xl group">
                <img :src="work.image" :alt="work.title" class="w-full aspect-square object-cover transition-all duration-300 group-hover:scale-105 cursor-pointer">
                <div class="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300"></div>
                <div class="absolute inset-0 flex flex-col items-center justify-center gap-3 opacity-0 group-hover:opacity-100 transition-all duration-300">
                  <button class="bg-green-500 text-white px-5 py-2 rounded-full text-sm font-semibold hover:bg-green-600 transition">查看详情</button>
                  <button class="bg-white/40 backdrop-blur-md text-gray-900 px-5 py-2 rounded-full text-sm font-semibold hover:bg-white/60 transition">复制提示词</button>
                </div>
              </div>
              <div class="p-4">
                <h3 class="text-lg font-semibold text-gray-900 mb-2">{{ work.title }}</h3>
                <div class="flex flex-wrap gap-2 items-center text-xs text-gray-500 mb-3">
                  <span class="bg-gray-100 px-3 py-1 rounded-full">{{ work.creator }}</span>
                  <span class="bg-gray-100 px-3 py-1 rounded-full">{{ work.category }}</span>
                </div>
                <div class="flex justify-between items-center text-xs text-gray-500">
                  <div class="flex space-x-3">
                    <span class="flex items-center space-x-1">👍 {{ work.likes }}</span>
                    <span class="flex items-center space-x-1">💬 {{ work.comments }}</span>
                    <span class="flex items-center space-x-1">⭐ {{ work.favorites }}</span>
                  </div>
                  <button class="bg-[#FF9F1C] text-white px-3 py-1 rounded-lg hover:bg-[#FFB347] transition-colors text-xs">复制提示词</button>
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
import imgCommunity01 from '../img/1775659070206.jpeg'
import imgCommunity02 from '../img/1775659074810.jpeg'
import imgCommunity03 from '../img/1775659079565.jpeg'
import imgCommunity04 from '../img/1775659083309.jpeg'
import imgCommunity05 from '../img/1775659088386.jpeg'
import imgCommunity06 from '../img/photo-1610926597998-fc7f2c1b89b0.jpeg'

interface CommunityWork {
  id: number
  title: string
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
  { id: 1, title: '河畔民居', image: imgCommunity01, creator: '艺术大师', category: '人像', likes: 2834, comments: 124, favorites: 586 },
  { id: 2, title: '山间小屋', image: imgCommunity02, creator: '自然拾光', category: '自然', likes: 1985, comments: 67, favorites: 342 },
  { id: 3, title: '古建风情', image: imgCommunity03, creator: '建筑观感', category: '建筑', likes: 1423, comments: 44, favorites: 178 },
  { id: 4, title: '静谧山坡', image: imgCommunity04, creator: '乡野旅人', category: '生活', likes: 2541, comments: 98, favorites: 430 },
  { id: 5, title: '宁静田野', image: imgCommunity05, creator: '田园诗人', category: '自然', likes: 1789, comments: 63, favorites: 301 },
  { id: 6, title: '古风雕塑', image: imgCommunity06, creator: '古巷旧影', category: '人像', likes: 2160, comments: 115, favorites: 487 }
])
</script>