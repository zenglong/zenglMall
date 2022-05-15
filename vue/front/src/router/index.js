import Vue from 'vue'
import Router from 'vue-router'
import Layout from '@/layout'

const originalPush = Router.prototype.push

Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(Router)

export const constantRoutes = [
  {
    path: '/',
    component: Layout,
    children: [
      {
        path: '/',
        component: () => import('@/views/index/index')
      },
      {
        path: '/login',
        component: () => import('@/views/login/login')
      },
      {
        path: '/goods/list',
        component: () => import('@/views/goods/list')
      },
      {
        path: '/goods/info',
        component: () => import('@/views/goods/info')
      },
      {
        path: '/goods/pay',
        component: () => import('@/views/goods/pay')
      }
    ]
  },
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
