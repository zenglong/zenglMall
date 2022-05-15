<template>
  <div class="info-wrapper" v-loading="loading">
    <div class="info-header clearfix">
      <div class="goods-thumb">
        <img :src="getImagePath(goods_info.thumbnail)" />
      </div>
      <div class="name-wrapper">
        <div class="goods-name">{{ goods_info.name }}</div>
        <div class="goods-price-wrapper">
          <div class="goods-price clearfix">
            <div class="goods-price-txt">{{ goods_price_txt }}</div>
            <div class="goods-price-value">¥{{ goods_info.price }}</div>
          </div>
          <div class="market-price goods-price clearfix">
            <div class="goods-price-txt">市 场 价</div>
            <div class="market-price-value goods-price-value">¥{{ goods_info.market_price }}</div>
          </div>
          <div class="market-price goods-price clearfix">
            <div class="goods-price-txt">{{ goods_store_txt }}</div>
            <div class="market-price-value goods-price-value">{{ goods_info.store_num }}</div>
          </div>
        </div>
        <div class="goods-btn-wrapper clearfix">
          <input type="number" v-model="buy_num" class="goods-buy-input" />
          <a class="goods-buy-button" href="javascript:void(0)" @click="goodsPay()">立即购买</a>
        </div>
      </div>
    </div>
    <div class="info-main">
      <div class="main-header">
        <div class="header-desc-txt">商品描述</div>
      </div>
      <div class="main-content" v-html="goods_info.content"></div>
    </div>
    <div class="relation-wrapper">
      <div class="relation-header">相关商品</div>
      <div class="thumb-goods clearfix">
        <div class="thumb-good-item" :title="good_item.name" v-for="good_item, key in goods_list" :key="key" 
          @click="goodsInfo(good_item.id, good_item.cid)">
          <div class="thumb-image">
            <img :src="getImagePath(good_item.thumbnail)" />
          </div>
          <div class="thumb-name">{{ good_item.name }}</div>
          <div class="thumb-price"><i>¥</i><span class="thumb-price-text">{{ good_item.price }}</span></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getGoodsInfo } from '@/api/goods'
import { getImagePath } from '@/assets/js/common'

export default {
  data() {
    return {
      loading: false,
      gid: 0,
      goods_info: {},
      goods_list: [],
      goods_price_txt: '价　　格',
      goods_store_txt: '库　　存',
      buy_num: 1,
    }
  },
  watch: {
    $route(to) {
      if(to.query.gid) {
        this.gid = parseInt(to.query.gid)
        this.getGoodsInfo()
      }
    },
  },
  mounted() {
    if(this.$route.query.gid) {
      this.gid = parseInt(this.$route.query.gid)
      this.getGoodsInfo()
    }
  },
  methods: {
    goodsPay() { // 商品购买
      this.$router.push('/goods/pay?gid='+this.goods_info.id+"&num="+this.buy_num)
    },
    goodsInfo(gid, cid) {
      this.$router.push('/goods/info?gid='+gid+"&cid="+cid)
    },
    getImagePath(image) {
      return getImagePath(image)
    },
    getGoodsInfo() {
      this.loading = true
      getGoodsInfo({
        gid: this.gid
      }).then(response => {
        this.goods_info = response.data.goods_info
        this.goods_list = response.data.goods_list
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.clearfix:after{
  visibility:hidden;
  display:block;
  font-size:0;
  content: " ";
  clear:both;
  height:0;
}
.info-wrapper {
  background-color: white;
  margin-top: 15px;
}
.goods-thumb {
  float: left;
}
.name-wrapper {
  width: 600px;
  float: left;
  margin-left: 25px;
}
.goods-name {
  font: 700 16px Arial,"microsoft yahei";
  color: #666;
  padding-top: 10px;
  line-height: 28px;
  margin-bottom: 5px;
}
.goods-price-wrapper {
  padding: 10px;
  background: #f3f3f3;
}
.goods-price-txt {
  float: left;
  line-height: 30px;
  font-family: simsun;
  color: #999;
}
.goods-price-value {
  float: left;
  margin-left: 20px;
  font-size: 22px;
  color: #e4393c;
  font-family: "microsoft yahei";
}
.market-price {
  margin-top: 8px;
}
.market-price-value {
  color: #999;
  line-height: 30px;
  font-size: 16px;
  font-family: simsun;
}
.goods-btn-wrapper {
  margin-top: 15px;
}
.goods-buy-input {
  float: left;
  display: block;
  width: 43px;
  height: 42px;
  line-height: 42px;
  border: 1px solid #ccc;
  text-align: center;
  margin-right: 0px;
  margin-top: 3px;
}
.goods-buy-button {
  float: left;
  margin-left: 20px;
  height: 46px;
  line-height: 46px;
  padding: 0 26px;
  font-size: 18px;
  font-family: "microsoft yahei";
  background-color: #df3033;
  color: white;
}

.info-main {
  margin-top: 15px;
}
.main-header {
  background-color: #f7f7f7;
  border: 1px solid #eee;
  border-bottom: 1px solid #e4393c;
}
.header-desc-txt {
  width: 150px;
  height: 36px;
  padding: 10px 25px 10px 25px;
  background-color: #e4393c;
  color: #fff;
  cursor: default;
  text-align: center;
}
.main-content {
  padding-left: 25px;
  padding-right: 25px;
  padding-top: 15px;
  padding-bottom: 5px;
}

.relation-header {
  background-color: #f7f7f7;
  padding: 10px 15px;
  margin-bottom: 15px;
  font: 700 14px "microsoft yahei";
  color: #666;
}

.thumb-good-item {
  opacity: 1;
  background: #fff;
  border: 1px solid #ddd;
  float: left;
  width: 230px;
  height: 322px;
  margin: 0 5px 10px;
  cursor: pointer;
  .thumb-image {
    margin-top: 30px;
    margin-bottom: 40px;
  }
  img {
    width: 150px;
    height: 150px;
    display:block;
    margin: 0 auto;
    max-width: 100%;
    max-height: 100%;
  }
}
.thumb-good-item:hover {
  img, .thumb-name, .thumb-price {
    opacity: 0.6;
    transition: opacity .2s linear;
  }
}
.thumb-name {
  padding: 0 20px;
  height: 48px;
  font-size: 14px;
  line-height: 24px;
  text-align: left;
  color: #666;
  -webkit-transition: color .2s ease;
  transition: color .2s ease;
  word-break: break-all;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.thumb-price {
  margin-top: 10px;
  float: left;
  width: 75px;
  text-align: left;
  line-height: 18px;
  color: #e1251b;
  margin-left: 20px;
  i {
    margin-right: 3px;
    vertical-align: middle;
    font-style: normal;
    font-size: 12px;
    font-weight: 700;
    font-family: MicrosoftYahei-regular,Arial,Helvetica,sans-serif;
  }
  .thumb-price-text {
    font-size: 20px;
    font-weight: 700;
    font-family: arial,sans-serif;
  }
}
</style>
