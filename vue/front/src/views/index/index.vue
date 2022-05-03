<template>
  <div v-loading="loading">
    <div class="thumb-goods clearfix">
      <div class="thumb-good-item" :title="thumb_good.name" 
        v-for="thumb_good, key in thumb_goods" :key="key" @click="goodsInfo(thumb_good.id, thumb_good.cid)">
        <div class="thumb-image">
          <img :src="thumb_good.thumbnail" />
        </div>
        <div class="thumb-name">{{ thumb_good.name }}</div>
        <div class="thumb-price"><i>¥</i><span class="thumb-price-text">{{ thumb_good.price }}</span></div>
      </div>
    </div>
  </div>
</template>

<script>
import { getIndexData } from '@/api/index'

export default {
  data() {
    return {
      loading: false,
      thumb_goods: []
    }
  },
  mounted() {
    this.getIndexData()
  },
  methods: {
    goodsInfo(gid, cid) {
      this.$router.push('/goods/info?gid='+gid+"&cid="+cid)
    },
    getIndexData() {
      this.loading = true
      getIndexData({
        is_post: 'yes'
      }).then(response => {
        this.loading = false
        this.thumb_goods = response.data.thumb_goods
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
.thumb-good-item {
  opacity: 1;
  background: #fff;
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
