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

export function getUserInfo(params) {
  return request({
    url: '/front/user_info.zl?act=get_info',
    method: 'get',
    params
  })
}

export function modifyUserInfo(data) {
  return request({
    url: '/front/user_info.zl?act=modify',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function modifyPassword(data) {
  return request({
    url: '/front/user_info.zl?act=modify_password',
    method: 'post',
    data: qs.stringify(data)
  })
}
