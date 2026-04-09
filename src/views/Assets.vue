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
    <div class="fixed top-4 left-20 right-4 z-10">
      <div class="bg-white/80 backdrop-blur-sm border border-gray-200/70 rounded-[32px] p-4 shadow-lg">
        <div class="flex items-center justify-between gap-4">
          <h2 class="text-lg font-bold text-gray-900">我的资产</h2>
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
          <div class="grid gap-6 lg:grid-cols-[220px_minmax(0,1fr)]">
            <aside class="bg-white rounded-[32px] border border-gray-200/70 p-4 shadow-lg">
              <div class="space-y-3">
                <button
                  @click="activeSection = '所有图片'"
                  :class="[
                    'w-full text-left px-4 py-3 rounded-2xl font-medium transition-all duration-200',
                    activeSection === '所有图片' ? 'bg-[#FF9F1C] text-white' : 'bg-white text-gray-900 border border-gray-200 hover:bg-gray-50'
                  ]"
                >
                  所有图片
                </button>
                <button
                  @click="activeSection = '小组空间'"
                  :class="[
                    'w-full text-left px-4 py-3 rounded-2xl font-medium transition-all duration-200',
                    activeSection === '小组空间' ? 'bg-[#FF9F1C] text-white' : 'bg-white text-gray-900 border border-gray-200 hover:bg-gray-50'
                  ]"
                >
                  小组空间
                </button>
              </div>
            </aside>
            <div class="space-y-6">
              <div v-for="(items, folderName) in assetFolders" :key="folderName">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">{{ folderName }}</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                  <div v-for="item in items" :key="item.id" class="rounded-xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300 bg-white">
                    <div class="relative overflow-hidden">
                      <img :src="item.preview" :alt="item.name" class="w-full aspect-square object-cover transition-all duration-300 hover:scale-105 cursor-pointer block">
                    </div>
                    <div class="p-4 space-y-2 text-xs text-gray-500">
                      <div class="flex justify-between items-center">
                        <span>{{ item.date }}</span>
                        <span>{{ item.size }}</span>
                      </div>
                      <div class="flex justify-between items-center text-gray-500">
                        <span class="flex items-center gap-1">👍 {{ item.likes }}</span>
                        <span class="flex items-center gap-1">💬 {{ item.comments }}</span>
                      </div>
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
import imgAsset01 from '../img/1775659070206.jpeg'
import imgAsset02 from '../img/1775659074810.jpeg'
import imgAsset03 from '../img/1775659079565.jpeg'
import imgAsset04 from '../img/1775659083309.jpeg'

interface AssetItem {
  id: number
  name: string
  preview: string
  date: string
  size: string
  likes: number
  comments: number
}

const activeSection = ref('所有图片')

const assetFolders = ref<Record<string, AssetItem[]>>({
  '我的图片': [
    { id: 1, name: '优雅人像', preview: imgAsset01, date: '4月6日', size: '2.4 MB', likes: 128, comments: 6 },
    { id: 2, name: '静谧山坡', preview: imgAsset02, date: '4月5日', size: '3.1 MB', likes: 94, comments: 13 },
    { id: 3, name: '古建风情', preview: imgAsset03, date: '4月4日', size: '1.8 MB', likes: 76, comments: 8 },
    { id: 4, name: '河畔小屋', preview: imgAsset04, date: '4月3日', size: '2.0 MB', likes: 101, comments: 11 },
    { id: 5, name: '日光庭院', preview: 'https://images.unsplash.com/photo-1603132789551-47b97377046e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', date: '4月2日', size: '2.7 MB', likes: 89, comments: 7 },
    { id: 6, name: '山间石屋', preview: 'https://images.unsplash.com/photo-1610926597998-fc7f2c1b89b0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', date: '4月1日', size: '2.9 MB', likes: 113, comments: 15 },
    { id: 7, name: '古巷木屋', preview: 'https://images.unsplash.com/photo-1652876256405-3902cc201b22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', date: '3月31日', size: '2.1 MB', likes: 67, comments: 5 },
    { id: 8, name: '江边田园', preview: 'https://images.unsplash.com/photo-1680201540929-4fd82ca3add0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.1.0&q=80&w=1080', date: '3月30日', size: '3.0 MB', likes: 142, comments: 18 }
  ]
})
</script>