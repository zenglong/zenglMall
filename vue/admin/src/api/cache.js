import request from '@/utils/request'

export function clearCache(params)
{
  return request({
    url: '/admin/admin/clearCache',
    method: 'post',
    params
  })
}
