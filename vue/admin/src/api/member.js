import request from '@/utils/request'
import qs from 'qs'

export function getList(params)
{
  return request({
    url: '/admin/member/index',
    method: 'post',
    params
  })
}

export function addMember(data)
{
  return request({
    url: '/admin/member/addMember',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function editMember(data)
{
  return request({
    url: '/admin/member/editMember',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getUserInfo(params)
{
  return request({
    url: '/admin/member/getUserInfo',
    method: 'get',
    params
  })
}
