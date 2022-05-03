import request from '@/utils/request'
import qs from 'qs'

export function getGoodsList(data)
{
  return request({
    url: '/front/goods.zl?act=list',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getGoodsInfo(data)
{
  return request({
    url: '/front/goods.zl?act=info',
    method: 'post',
    data: qs.stringify(data)
  })
}
