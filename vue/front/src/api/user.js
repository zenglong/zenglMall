import request from '@/utils/request'
import qs from 'qs'

export function login(data) {
  return request({
    url: '/front/login.zl',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function register(data) {
  return request({
    url: '/front/login.zl?act=register',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo() {
  return request({
    url: '/front/get_info.zl',
    method: 'post',
  })
}

export function logout() {
  return request({
    url: '/front/logout.zl',
    method: 'post',
  })
}

export function adminIndex(params) {
  return request({
    url: '/front/admin.zl',
    method: 'get',
    params
  })
}
