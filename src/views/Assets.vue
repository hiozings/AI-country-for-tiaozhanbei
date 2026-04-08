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
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Community' }"
      >
        <span class="text-2xl">👥</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">社区</span>
      </router-link>
      
      <router-link 
        to="/assets" 
        class="group flex flex-col items-center"
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
    <div class="fixed top-4 left-0 right-0 z-10 px-4 sm:px-6 lg:px-8">
      <div class="bg-white/80 backdrop-blur-sm border border-gray-200/70 rounded-[32px] p-4 shadow-lg">
        <div class="grid gap-4 lg:grid-cols-[220px_minmax(0,1fr)] items-center">
          <div class="space-y-3">
            <h2 class="text-lg font-bold text-gray-900">我的资产</h2>
            <div class="space-y-2">
              <button class="w-full text-left px-4 py-2 rounded-xl bg-white text-gray-900 border border-gray-200 hover:bg-gray-50 transition-all duration-200">所有图片</button>
              <button class="w-full text-left px-4 py-2 rounded-xl bg-white text-gray-900 border border-gray-200 hover:bg-gray-50 transition-all duration-200">小组空间</button>
            </div>
          </div>
          <div class="flex justify-end items-start gap-4">
            <button type="button" class="flex items-center space-x-2 bg-white text-gray-700 border border-gray-200 px-4 py-2 rounded-xl hover:bg-gray-50 transition-all duration-200">
              <span>📁</span>
              <span>新建文件夹</span>
            </button>
            <button type="button" class="flex items-center space-x-2 bg-[#FF9F1C] text-white px-4 py-2 rounded-xl hover:bg-[#FFB347] transition-all duration-200">
              <span>⬆️</span>
              <span>上传资产</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <main class="flex-1 ml-20">
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 pt-28">
        <div class="px-4 py-6 sm:px-0">

          <!-- Folders and Files -->
          <div class="space-y-6">
            <div v-for="(items, folderName) in assetFolders" :key="folderName">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">{{ folderName }}</h3>
              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <div v-for="item in items" :key="item.id" class="bg-white rounded-xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300">
                  <div class="relative group aspect-square overflow-hidden">
                    <img :src="item.preview" :alt="item.name" class="w-full h-full object-cover hover:scale-105 transition-all duration-300 cursor-pointer">
                    <div class="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300"></div>
                  </div>
                  <div class="p-4">
                    <h4 class="font-semibold text-gray-900 mb-2 truncate">{{ item.name }}</h4>
                    <div class="flex justify-between items-center text-xs text-gray-500">
                      <span>{{ item.date }}</span>
                      <span v-if="item.size">{{ item.size }}</span>
                    </div>
                    <div class="flex space-x-2 mt-3">
                      <button class="flex-1 bg-[#FF9F1C] text-white px-3 py-1 rounded-lg text-xs hover:bg-[#FFB347] transition-colors">编辑</button>
                      <button class="flex-1 bg-gray-100 text-gray-700 px-3 py-1 rounded-lg text-xs hover:bg-gray-200 transition-colors">删除</button>
                    </div>
                  </div>
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
import { ref } from 'vue'

interface AssetItem {
  id: number
  name: string
  date: string
  size?: string
  preview: string
}

const assetFolders = ref<Record<string, AssetItem[]>>({
  '人像系列': [
    {
      id: 1,
      name: '优雅人像.png',
      date: '4月6日',
      size: '2.4 MB',
      preview: 'https://images.unsplash.com/photo-1603132789551-47b97377046e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHdvbWFuJTIwZWxlZ2FudHxlbnwxfHx8fDE3NzU0NzU0OTR8MA&ixlib=rb-4.1.0&q=80&w=1080'
    },
    {
      id: 2,
      name: '龙之幻想.png',
      date: '4月5日',
      size: '3.1 MB',
      preview: 'https://images.unsplash.com/photo-1610926597998-fc7f2c1b89b0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcmFnb24lMjBmYW50YXN5JTIwYXJ0fGVufDF8fHx8MTc3NTUxOTY3OXww&ixlib=rb-4.1.0&q=80&w=1080'
    }
  ],
  '奇幻收藏': [
    {
      id: 3,
      name: '电影级灯光提示词',
      date: '4月4日',
      preview: 'https://images.unsplash.com/photo-1652876256405-3902cc201b22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhcmNoaXRlY3R1cmUlMjBtb2Rlcm4lMjBidWlsZGluZ3xlbnwxfHx8fDE3NzU1MDQ0MzB8MA&ixlib=rb-4.1.0&q=80&w=1080'
    },
    {
      id: 4,
      name: '建筑场景.png',
      date: '4月3日',
      size: '1.8 MB',
      preview: 'https://images.unsplash.com/photo-1652876256405-3902cc201b22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhcmNoaXRlY3R1cmUlMjBtb2Rlcm4lMjBidWlsZGluZ3xlbnwxfHx8fDE3NzU1MDQ0MzB8MA&ixlib=rb-4.1.0&q=80&w=1080'
    },
    {
      id: 5,
      name: '奇幻提示词模版',
      date: '4月2日',
      preview: 'https://images.unsplash.com/photo-1680201540929-4fd82ca3add0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx1bmRlcndhdGVyJTIwb2NlYW4lMjBjcmVhdHVyZXN8ZW58MXx8fHwxNzc1NTY4MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080'
    },
    {
      id: 6,
      name: '深海世界.png',
      date: '4月1日',
      size: '2.7 MB',
      preview: 'https://images.unsplash.com/photo-1680201540929-4fd82ca3add0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx1bmRlcndhdGVyJTIwb2NlYW4lMjBjcmVhdHVyZXN8ZW58MXx8fHwxNzc1NTY4MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080'
    }
  ]
})
</script>