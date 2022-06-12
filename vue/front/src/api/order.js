import request from '@/utils/request'
import qs from 'qs'

export function orderList(data) {
  return request({
    url: '/front/order_list.zl?act=index',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo(params) {
  return request({
    url: '/front/order_list.zl?act=view',
    method: 'get',
    params
  })
}

export function setBuyerConfirm(params) {
  return request({
    url: '/front/order_list.zl?act=set_buyer_confirm',
    method: 'get',
    params
  })
}

export function continuePay(params) {
  return request({
    url: '/front/order_pay.zl',
    method: 'get',
    params
  })
}
