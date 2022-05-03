import request from '@/utils/request'
import qs from 'qs'

export function getIndexData(data)
{
  return request({
    url: '/front/index.zl',
    method: 'post',
    data: qs.stringify(data)
  })
}
