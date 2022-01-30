import request from '@/utils/request'

export function getList(params)
{
  return request({
    url: '/admin/index.zl',
    method: 'get',
    params
  })
}
