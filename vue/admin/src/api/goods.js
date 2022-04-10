import request from '@/utils/request'
import qs from 'qs'

export function getList(data)
{
  return request({
    url: '/admin/goods.zl?act=list',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function addGoods(data)
{
  return request({
    url: '/admin/goods.zl?act=add',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo(params)
{
  return request({
    url: '/admin/goods.zl?act=info',
    method: 'post',
    params
  })
}

export function editGoods(data)
{
  return request({
    url: '/admin/goods.zl?act=edit',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function deleteGoods(params)
{
  return request({
    url: '/admin/goods.zl?act=delete',
    method: 'get',
    params
  })
}
