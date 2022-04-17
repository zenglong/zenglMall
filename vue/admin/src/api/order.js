import request from '@/utils/request'
import qs from 'qs'

export function getList(data)
{
  return request({
    url: '/admin/order.zl?act=list',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function getInfo(params)
{
  return request({
    url: '/admin/order.zl?act=view',
    method: 'post',
    params
  })
}

export function modifySellerRemark(data)
{
  return request({
    url: '/admin/order.zl?act=modify_seller_remark',
    method: 'post',
    data: qs.stringify(data)
  })
}

export function setSendStatus(data)
{
  return request({
    url: '/admin/order.zl?act=set_send_status',
    method: 'post',
    data: qs.stringify(data)
  })
}
