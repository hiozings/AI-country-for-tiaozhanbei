<template>
  <div class="min-h-screen bg-gray-50">
    <nav class="bg-white shadow-sm border-b">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex items-center">
            <h1 class="text-xl font-bold text-gray-900">智绘乡野</h1>
          </div>
          <div class="flex space-x-8">
            <router-link to="/" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">创作</router-link>
            <router-link to="/community" class="text-gray-900 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium" :class="{ 'text-blue-600': $route.name === 'Community' }">社区</router-link>
            <router-link to="/assets" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">资产</router-link>
            <router-link to="/profile" class="text-gray-500 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium">我的</router-link>
          </div>
        </div>
      </div>
    </nav>
    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <div class="px-4 py-6 sm:px-0">
        <h2 class="text-2xl font-bold text-gray-900">社区</h2>
        <p class="mt-4 text-gray-600">这里是社区页面，展示用户生成的图像和讨论。</p>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
// Community page placeholder
</script>