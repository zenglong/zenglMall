<template>
  <div class="info-wrapper" v-loading="loading">
    <div class="info-header">
      <div class="goods-thumb">
        <img :src="getImagePath(goods_info.thumbnail)" />
      </div>
      <div class="name-wrapper">
        <div class="goods-name">{{ goods_info.name }}</div>
        <div class="goods-price">{{ goods_info.price }}</div>
      </div>
    </div>
    <div class="info-main">
      <div class="main-header">商品描述</div>
      <div class="main-content" v-html="goods_info.content"></div>
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
      goods_info: {}
    }
  },
  mounted() {
    if(this.$route.query.gid) {
      this.gid = parseInt(this.$route.query.gid)
      this.getGoodsInfo()
    }
  },
  methods: {
    getImagePath(image) {
      return getImagePath(image)
    },
    getGoodsInfo() {
      this.loading = true
      getGoodsInfo({
        gid: this.gid
      }).then(response => {
        this.goods_info = response.data.goods_info
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.info-wrapper {
  background-color: white;
}
</style>
