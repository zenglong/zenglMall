import request from '@/utils/request'
import qs from 'qs'

export function orderList(data) {
  return request({
    url: '/front/order_list.zl?act=index',
    method: 'post',
    data: qs.stringify(data)
  })
}
