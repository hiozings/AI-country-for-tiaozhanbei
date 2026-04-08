import { createRouter, createWebHistory } from 'vue-router'
import Generation from '../views/Generation.vue'
import Community from '../views/Community.vue'
import Assets from '../views/Assets.vue'
import Profile from '../views/Profile.vue'

const routes = [
  {
    path: '/',
    name: 'Generation',
    component: Generation
  },
  {
    path: '/community',
    name: 'Community',
    component: Community
  },
  {
    path: '/assets',
    name: 'Assets',
    component: Assets
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router