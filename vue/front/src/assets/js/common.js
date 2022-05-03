export function get_all_order_status()
{
  return [
    {name:'待付款', value:'WAIT_BUYER'},
    {name:'待发货', value:'WAIT_SELLER_SEND'},
    {name:'待收货', value:'WAIT_BUYER_CONFIRM'},
    {name:'已收货', value:'BUYER_CONFIRM'},
    {name:'已关闭', value:'CLOSE'}
  ];
}

export function get_order_status_name(all_status, status_value)
{
  if(all_status == null)
    all_status = get_all_order_status();
  for(var i = 0; i < all_status.length;i++) {
    if(all_status[i].value == status_value) {
      return all_status[i].name;
    }
  }
  return '未知状态';
}

let api_base_url = process.env.VUE_APP_API_BASE_URL
let last_char = api_base_url.charAt(api_base_url.length - 1)
let img_base_url = api_base_url
if (last_char == '/') {
  img_base_url = api_base_url.substr(0, api_base_url.length-1)
}

export function getImagePath(image) {
  let returl = image ? image : '/assets/image/defaultpic.jpg'
  if(returl.indexOf("http://") == -1 && returl.indexOf("https://") == -1) {
    returl = img_base_url + returl
  }
  return returl
}
