import request from '@/utils/request'
import qs from 'qs'

export function getUserList(data)
{
  return request({
    url: '/admin/front_user_list.zl?act=index',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getUserInfo(params)
{
  return request({
    url: '/admin/front_user_list.zl?act=view',
    method: 'get',
    params
  })
}
