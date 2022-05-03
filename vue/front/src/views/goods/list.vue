<template>
  <div v-loading="loading && !isLoadMore">
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
    <div class="load-more-btn-wrapper" v-if="goods_list.length < total">
      <el-button type="default" @click="loadMore()" v-if="goods_list.length < total" :loading="loading && isLoadMore" 
        class="load-more-btn" size="small"
        round icon="el-icon-arrow-down">
        加载更多
      </el-button>
    </div>
  </div>
</template>

<script>
import { getImagePath } from '@/assets/js/common'
import { getGoodsList } from '@/api/goods'

export default {
  data() {
    return {
      loading: false,
      isLoadMore: false,
      page: 1,
      goods_list: [],
      total: 0,
      cid: null,
    }
  },
  watch: {
    $route(to) {
      if(to.query.cid) {
        this.cid = parseInt(to.query.cid)
        this.page = 1
        this.total = 0
        this.getGoodsList()
      }
    }
  },
  mounted() {
    if(this.$route.query.cid) {
      this.cid = parseInt(this.$route.query.cid)
      this.getGoodsList()
    }
  },
  methods: {
    goodsInfo(gid, cid) {
      this.$router.push('/goods/info?gid='+gid+"&cid="+cid)
    },
    getImagePath(image) {
      return getImagePath(image)
    },
    getGoodsList() {
      this.loading = true
      getGoodsList({
        cid: this.cid,
        page: this.page
      }).then(response => {
        this.loading = false
        if(this.isLoadMore) {
          this.goods_list = this.goods_list.concat(response.data.goods_list)
          this.isLoadMore = false
        }
        else {
          this.goods_list = response.data.goods_list
        }
        this.total = response.data.total
      }).catch(error => {
        this.loading = false
      })
    },
    loadMore() {
      this.isLoadMore = true
      this.page++
      this.getGoodsList()
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

.load-more-btn-wrapper {
  padding-bottom: 15px;
  position: relative;
  height: 50px;
}
.load-more-btn {
  margin: 0 auto;
  display: block;
  width: 150px;
  padding: 6px 15px;
}
</style>
