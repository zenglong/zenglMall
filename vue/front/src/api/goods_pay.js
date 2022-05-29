import request from '@/utils/request'
import qs from 'qs'

export function getPayInfo(params)
{
  return request({
    url: '/front/goods_pay.zl?act=get_pay_info',
    method: 'get',
    params
  })
}

export function doPay(data)
{
  return request({
    url: '/front/goods_pay.zl?act=do_pay',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function payReturn(params)
{
  return request({
    url: '/front/return.zl',
    method: 'get',
    params
  })
}
