<template>
  <div class="min-h-screen bg-gray-50 flex">
    <!-- Left Sidebar Navigation -->
    <aside class="fixed left-0 top-0 h-full w-20 bg-white shadow-lg flex flex-col items-center py-8 space-y-8 z-10">
      <router-link 
        to="/" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-lg p-3': $route.name === 'Generation' }"
      >
        <span class="text-2xl">✏️</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">创作</span>
      </router-link>
      
      <router-link 
        to="/community" 
        class="group flex flex-col items-center"
        :class="{ 'bg-[#FF9F1C] rounded-lg p-3': $route.name === 'Community' }"
      >
        <span class="text-2xl">👥</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">社区</span>
      </router-link>
      
      <router-link 
        to="/assets" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-lg p-3': $route.name === 'Assets' }"
      >
        <span class="text-2xl">🎨</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">资产</span>
      </router-link>
      
      <router-link 
        to="/profile" 
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-lg p-3': $route.name === 'Profile' }"
      >
        <span class="text-2xl">👤</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">我的</span>
      </router-link>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 ml-20">
      <!-- Top Navigation Bar -->
      <nav class="bg-white shadow-sm border-b">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex items-center h-16">
            <h1 class="text-xl font-bold text-gray-900">智绘乡野</h1>
          </div>
        </div>
      </nav>
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
          <h2 class="text-2xl font-bold text-gray-900">社区</h2>
          <p class="mt-4 text-gray-600">这里是社区页面，展示用户生成的图像和讨论。</p>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
// Community page placeholder
</script>