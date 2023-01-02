import request from '@/utils/request'
import qs from 'qs'

export function addAttr(data) {
  return request({
    url: '/admin/goods_attr.zl?act=add',
    method: 'post',
    data: qs.stringify(data)
  })
}
