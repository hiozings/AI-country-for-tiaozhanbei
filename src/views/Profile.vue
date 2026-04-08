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
        class="group flex flex-col items-center hover:scale-105 transition-transform duration-200"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Assets' }"
      >
        <span class="text-2xl">🎨</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">资产</span>
      </router-link>
      
      <router-link 
        to="/profile" 
        class="group flex flex-col items-center"
        :class="{ 'bg-[#FF9F1C] rounded-xl p-3': $route.name === 'Profile' }"
      >
        <span class="text-2xl">👤</span>
        <span class="text-xs text-gray-600 group-hover:text-[#FF9F1C] mt-2 transition-colors duration-200 text-center">我的</span>
      </router-link>
    </aside>

    <!-- Right Top Actions -->
    <div class="fixed top-4 left-0 right-0 z-10 px-4 sm:px-6 lg:px-8">
      <div class="bg-white/80 backdrop-blur-sm border border-gray-200/70 rounded-[32px] p-4 shadow-lg">
        <div class="flex items-center justify-between gap-4">
          <h2 class="text-lg font-bold text-gray-900">个人中心</h2>
          <div class="flex space-x-4">
            <button type="button" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-xl hover:bg-gray-300 hover:scale-105 transition-all duration-200">保存</button>
            <button type="button" class="bg-[#FF9F1C] text-white px-4 py-2 rounded-xl hover:bg-[#FFB347] hover:scale-105 transition-all duration-200">修改</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <main class="flex-1 ml-20">
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 pt-20">
        <div class="flex gap-8">
          <!-- Left Menu -->
          <div class="w-48">
            <nav class="space-y-2 bg-white rounded-lg shadow p-4">
              <button
                v-for="menu in menuItems"
                :key="menu"
                @click="activeMenu = menu"
                :class="[
                  'w-full text-left px-4 py-2 rounded-lg transition-colors duration-200',
                  activeMenu === menu
                    ? 'bg-[#FF9F1C] text-white'
                    : 'text-gray-700 hover:bg-gray-100'
                ]"
              >
                {{ menu }}
              </button>
            </nav>
          </div>

          <!-- Right Content -->
          <div class="flex-1">
            <!-- Personal Profile Section -->
            <div v-show="activeMenu === '个人资料'" class="space-y-6">
              <!-- Account Type Selection -->
              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">账户类型</h3>
                <div class="grid grid-cols-2 gap-4">
                  <div
                    v-for="type in accountTypes"
                    :key="type.id"
                    @click="profile.accountType = type.id"
                    :class="[
                      'p-4 border-2 rounded-lg cursor-pointer transition-all duration-200',
                      profile.accountType === type.id
                        ? 'border-[#FF9F1C] bg-orange-50'
                        : 'border-gray-200 hover:border-orange-200'
                    ]"
                  >
                    <h4 class="font-semibold mb-2">{{ type.name }}</h4>
                    <p class="text-sm text-gray-600">{{ type.description }}</p>
                  </div>
                </div>
              </div>

              <!-- Avatar Upload -->
              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">头像设置</h3>
                <div class="flex items-center space-x-6">
                  <img :src="profile.avatar" alt="Avatar" class="w-24 h-24 rounded-full object-cover border-4 border-gray-200">
                  <button type="button" class="bg-[#FF9F1C] text-white px-6 py-2 rounded-xl hover:bg-[#FFB347] transition-colors">
                    上传新头像
                  </button>
                </div>
              </div>

              <!-- Personal Info -->
              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">个人信息</h3>
                <div class="space-y-4">
                  <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">显示名称</label>
                    <input
                      v-model="profile.name"
                      type="text"
                      class="w-full px-4 py-2 border border-gray-100 rounded-xl focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
                    >
                  </div>
                  <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">个人简介</label>
                    <textarea
                      v-model="profile.bio"
                      rows="4"
                      class="w-full px-4 py-2 border border-gray-100 rounded-xl focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
                    ></textarea>
                  </div>
                  <div class="text-sm text-gray-500">
                    注册于 {{ profile.registrationDate }}
                  </div>
                </div>
              </div>

              <!-- Social Links -->
              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">社交链接</h3>
                <div class="space-y-4">
                  <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">个人网站</label>
                    <input
                      v-model="profile.website"
                      type="text"
                      class="w-full px-4 py-2 border border-gray-100 rounded-xl focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
                      placeholder="https://yourwebsite.com"
                    >
                  </div>
                  <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">微博</label>
                    <input
                      v-model="profile.weibo"
                      type="text"
                      class="w-full px-4 py-2 border border-gray-100 rounded-xl focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
                      placeholder="@你的微博账号"
                    >
                  </div>
                  <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">微信</label>
                    <input
                      v-model="profile.wechat"
                      type="text"
                      class="w-full px-4 py-2 border border-gray-100 rounded-xl focus:outline-none focus:border-green-500 focus:ring-2 focus:ring-green-500"
                      placeholder="your_wechat_id"
                    >
                  </div>
                </div>
              </div>
            </div>

            <!-- Member Plans Section -->
            <div v-show="activeMenu === '会员方案'" class="bg-white rounded-lg shadow p-6">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">会员方案</h3>
              <p class="text-gray-600">选择适合您的会员计划，获得更多功能和权益。</p>
              <div class="mt-4 space-y-3">
                <div class="p-4 border border-[#FF9F1C] rounded-lg">
                  <h4 class="font-semibold">高级会员</h4>
                  <p class="text-sm text-gray-600">¥99/月</p>
                  <button class="bg-[#FF9F1C] text-white px-4 py-2 rounded-lg mt-2 hover:bg-[#FFB347] transition-colors">升级</button>
                </div>
              </div>
            </div>

            <!-- Billing Section -->
            <div v-show="activeMenu === '账单管理'" class="bg-white rounded-lg shadow p-6">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">账单管理</h3>
              <p class="text-gray-600">管理您的订阅和账单信息。</p>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

interface Profile {
  name: string
  bio: string
  avatar: string
  website: string
  weibo: string
  wechat: string
  accountType: string
  registrationDate: string
}

interface AccountType {
  id: string
  name: string
  description: string
}

const menuItems = ['个人资料', '会员方案', '账单管理']
const activeMenu = ref('个人资料')

const accountTypes: AccountType[] = [
  {
    id: 'personal',
    name: '个人用户',
    description: '适合个人创作者和自由职业者'
  },
  {
    id: 'enterprise',
    name: '企业版用户',
    description: '适合团队协作和企业级应用'
  }
]

const profile = ref<Profile>({
  name: 'Alex Zhang',
  bio: '数字艺术家和AI爱好者。用人工智能的力量创造令人惊叹的视觉效果。',
  avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtYWxlIHVzZXIlMjBhdmF0YXJ8ZW58MXx8fHwxNzc1NTY4MTMwfDA&ixlib=rb-4.1.0&q=80&w=1080',
  website: 'alexzhang.art',
  weibo: '@张艺涵创作',
  wechat: 'artist_zhang',
  accountType: 'personal',
  registrationDate: '2026年3月'
})
</script>