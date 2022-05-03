import request from '@/utils/request'
import qs from 'qs'

export function getCategoryList(data)
{
  return request({
    url: '/front/category.zl?act=treeList',
    method: 'post',
    data: qs.stringify(data)
  })
}
