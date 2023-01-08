import request from '@/utils/request'
import qs from 'qs'

export function addAttr(data) {
  return request({
    url: '/admin/goods_attr.zl?act=add',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editAttr(data) {
  return request({
    url: '/admin/goods_attr.zl?act=edit',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function deleteAttr(params) {
  return request({
    url: '/admin/goods_attr.zl?act=delete',
    method: 'post',
    params
  })
}

export function getList(data) {
  return request({
    url: '/admin/goods_attr.zl?act=list',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo(params) {
  return request({
    url: '/admin/goods_attr.zl?act=info',
    method: 'post',
    params
  })
}
