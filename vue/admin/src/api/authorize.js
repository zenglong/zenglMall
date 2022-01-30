import request from '@/utils/request'
import qs from 'qs'

export function getList(params)
{
  return request({
    url: '/admin/Authorize/index',
    method: 'post',
    params
  })
}

export function getGroupInfo(params)
{
  return request({
    url: '/admin/Authorize/editGroup',
    method: 'get',
    params
  })
}

export function addGroup(data)
{
  return request({
    url: '/admin/Authorize/addGroup',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editGroup(data)
{
  return request({
    url: '/admin/Authorize/editGroup',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getAccess(params)
{
  return request({
    url: '/admin/Authorize/access',
    method: 'get',
    params
  })
}

export function setAccess(data)
{
  return request({
    url: '/admin/Authorize/access',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function groupUser(params)
{
  return request({
    url: '/admin/Authorize/groupUser',
    method: 'post',
    params
  })
}

export function groupUserAdd(data)
{
  return request({
    url: '/admin/Authorize/groupUserAdd',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function groupUserDel(data)
{
  return request({
    url: '/admin/Authorize/groupUserDel',
    method: 'post',
    data: qs.stringify(data)
  })
}
