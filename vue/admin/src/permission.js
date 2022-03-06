import router from './router'
import store from './store'
import NProgress from 'nprogress' // progress bar
import Layout from '@/layout'
import { Message } from 'element-ui'
import 'nprogress/nprogress.css' // progress bar style
import { getToken } from './store/module/user'
import settings from '@/store/module/settings'

const title = settings.state.title

export function getPageTitle(pageTitle) {
  if (pageTitle) {
    return `${pageTitle} - ${title}`
  }
  return `${title}`
}

const allowedRoutes = [
  'admin/index',
  'admin/users',
  'front/users',
  'front/userinfo',
  'category/index',
  'goods/index',
  'goods/addGoods',

  'menu/index',
  'menu/AddMenu',
  'member/index',
  'member/addMember',
  'Authorize/index',
  'Authorize/addGroup'
]

function addChildrenRoutes(route) {
  let newroute = {
    id: route['id'],
    path: '/' + route['name'],
    component: () => import('@/views/' + (allowedRoutes.indexOf(route['name']) !== -1 ? route['name'] : 'admin/empty')),
    hidden: route['hidden'] ? true : false,
    meta: { title: route['title'], icon: route['icon'], affix: false }
  }
  if(route['children'] && route['children'].length > 0) {
    newroute['children'] = []
    for(let k in route['children']) {
      newroute['children'].push(addChildrenRoutes(route['children'][k]))
    }
  }

  return newroute
}

function addNewRoutes(newroutes, routes) {
  for (let k in routes) {
    // console.log('addNewRoutes:', routes[k])
    let newroute = {
      id: routes[k]['id'],
      path: '/' + routes[k]['name'],
      component: Layout,
      hidden: routes[k]['hidden'] ? true : false,
      meta: { title: routes[k]['title'], icon: routes[k]['icon'] },
    }
    if(!routes[k]['children']) {
      newroute['children'] = [addChildrenRoutes(routes[k])]
    }
    else {
      // newroute['alwaysShow'] = true
      newroute['children'] = []
      let route_children = routes[k]['children']
      // console.log('route_children', route_children)
      for(let kv in route_children) {
        newroute['children'].push(addChildrenRoutes(route_children[kv]))
      }
    }
    newroutes.push(newroute)
  }
}

NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/admin/login'] // no redirect whitelist

let getinfo_data = false

router.beforeEach(async(to, from, next) => {
  // console.log('to.path:', to.path)

  NProgress.start()

  document.title = getPageTitle(to.meta.title)

  const hasToken = getToken()

  if (hasToken) {
    // console.log('to.path:' , to.path)
    // console.log('getinfo_data: ' , getinfo_data)
    if (to.path === '/admin/login') {
      next({ path: '/admin/index' })
      NProgress.done()
    }
    else {
      const hasRoutes = store.getters.routes && store.getters.routes.length > 0
      // console.log('store.getters.routes:', store.getters.routes)
      if(hasRoutes) {
        next()
      } else if (!getinfo_data) {
        try {
          console.log('permission get info...')

          const { routes } = await store.dispatch('user/getInfo')

          let newroutes = []
          addNewRoutes(newroutes, routes)

          console.log('newrouters:', newroutes)
          router.addRoutes(newroutes)
          router.options.routes.push(...newroutes)
          console.log('router.options.routes:', router.options.routes)
          await store.dispatch('user/setRoutes', newroutes)

          getinfo_data = true
          if(newroutes.length > 0) {
            next({path: newroutes[0]['path'], replace: true})
          }
          else
            next({ ...to, replace: true })

        } catch (error) {
          // await store.dispatch('user/resetToken')
          Message.error(error || 'Has Error')
          // next(`/admin/login?redirect=${to.path}`)
          NProgress.done()
        }
      } else {
        Message.error('未获取到权限信息')
        NProgress.done()
      }
    }
  } else {
    /* has no token*/

    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next()
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      next(`/admin/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  console.log('router.afterEach')
  // finish progress bar
  NProgress.done()
})

export function setGetInfoDataValue(val = false)
{
  getinfo_data = val
}
