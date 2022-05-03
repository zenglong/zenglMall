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

const whiteList = ['/admin/login'] // no redirect whitelist

let getinfo_data = false

router.beforeEach(async(to, from, next) => {
  // console.log('to.path:', to.path)

  NProgress.start()

  document.title = getPageTitle(to.meta.title)

  next()
  NProgress.done()
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
