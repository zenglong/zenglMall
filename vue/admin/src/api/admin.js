import request from '@/utils/request'

export function getList(params)
{
  return request({
    url: '/admin/index.zl',
    method: 'get',
    params
  })
}

export function getAdminUserList(params)
{
  return request({
    url: '/admin/admin_user_list.zl',
    method: 'get',
    params
  })
}
