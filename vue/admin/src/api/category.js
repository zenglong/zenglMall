import request from '@/utils/request'
import qs from 'qs'

export function getList(params)
{
  return request({
    url: '/admin/category.zl?act=treeList',
    method: 'get',
    params
  })
}

export function getSelList(params)
{
  return request({
    url: '/admin/category.zl?act=selTreeList',
    method: 'get',
    params
  })
}

export function getInfo(params)
{
  return request({
    url: '/admin/category.zl?act=info',
    method: 'get',
    params
  })
}

export function addCategory(data) {
  return request({
    url: '/admin/category.zl?act=add',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editCategory(data) {
  return request({
    url: '/admin/category.zl?act=edit',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function deleteCategory(params)
{
  return request({
    url: '/admin/category.zl?act=delete',
    method: 'get',
    params
  })
}
