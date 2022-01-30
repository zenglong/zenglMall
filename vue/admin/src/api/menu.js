import request from '@/utils/request'
import qs from 'qs'

export function getList(params)
{
  return request({
    url: '/admin/menu/index',
    method: 'post',
    params
  })
}

export function changMenuStatus(params)
{
  return request({
    url: '/admin/menu/changMenuStatus',
    method: 'post',
    params
  })
}

export function getParents(params)
{
  return request({
    url: '/admin/menu/index',
    method: 'post',
    params
  })
}

export function addMenu(data)
{
  return request({
    url: '/admin/menu/addMenu',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editMenu(data)
{
  return request({
    url: '/admin/menu/editMenu',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function delMenu(params)
{
  return request({
    url: '/admin/menu/delMenu',
    method: 'post',
    params
  })
}

export function getMenuInfo(params)
{
  return request({
    url: '/admin/menu/editMenu',
    method: 'get',
    params
  })
}
