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

NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/', '/login', '/register', '/goods/list', '/goods/info'] // no redirect whitelist

let getinfo_data = false

router.beforeEach(async(to, from, next) => {
  // console.log('to.path:', to.path)

  NProgress.start()

  document.title = getPageTitle(to.meta.title)

  const hasToken = getToken()

  if (hasToken) {
    next()
  } else {
    /* has no token*/
    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next()
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      next(`/login`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  // console.log('router.afterEach')
  // finish progress bar
  NProgress.done()
})

export function setGetInfoDataValue(val = false)
{
  getinfo_data = val
}
