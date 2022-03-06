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
