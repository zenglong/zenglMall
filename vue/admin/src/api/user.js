import request from '@/utils/request'
import qs from 'qs'

export function login(data) {
  // console.log(data)
  return request({
    url: '/admin/login.zl',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo() {
  return request({
    url: '/admin/get_info.zl',
    method: 'post',
    // params: qs.stringify({ token })
  })
}

export function logout() {
  return request({
    url: '/admin/logout.zl',
    method: 'post',
  })
}
