import request from '@/utils/request'
import qs from 'qs'

export function getList(data) {
  return request({
    url: '/admin/goods_attr_value.zl?act=list',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getAll(data) {
  return request({
    url: '/admin/goods_attr_value.zl?act=all',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function addAttrValue(data) {
  return request({
    url: '/admin/goods_attr_value.zl?act=add',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editAttrValue(data) {
  return request({
    url: '/admin/goods_attr_value.zl?act=edit',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function deleteAttrValue(params) {
  return request({
    url: '/admin/goods_attr_value.zl?act=delete',
    method: 'post',
    params
  })
}

export function getInfo(params) {
  return request({
    url: '/admin/goods_attr_value.zl?act=info',
    method: 'post',
    params
  })
}
