<template>
  <div :class="'app-wrapper' + (gray_background ? ' app-gray-background' : '') + (is_user_admin ? ' app-wrapper-useradmin' : '')">
    <div class="header-wrapper">
      <div class="header-inner clearfix">
        <div class="site-name" @click="clickSiteName()">zenglMall</div>
        <div class="category-wrapper clearfix">
          <div class="category-loading" v-if="category_loading">加载中...</div>
          <div :class="'category-item' + ((cid == category.id || getPid == category.id) ? ' category-current' : '')" 
            v-for="category,key in categories" :key="key" @click="clickCategory(category.id)">
            {{ category.name }}
          </div>
          <div class="category-item" v-if="!category_loading" @click="clickUserMember()">会员中心</div>
        </div>
      </div>
    </div>
    <div class="category-childs-wrapper" v-if="cid !== null && cid > 0 && sub_categories.length > 0">
      <div class="category-childs-inner clearfix">
        <div :class="'category-child-item' + (cid !== null && cid == sub_category.id ? ' category-current' : '')" 
          v-for="sub_category, sub_key in sub_categories" :key="sub_key" 
          @click="clickCategory(sub_category.id)">
          {{ sub_category.name }}
        </div>
      </div>
    </div>
    <div :class="'app-content' + (cid > 0 && sub_categories.length > 0 ? ' category-has-sub' : '') + 
        (is_user_admin ? ' app-user-admin' : '')">
      <router-view />
    </div>
    <div class="app-bottom">
      <div class="app-bottom-inner">&copy; zenglMall</div>
    </div>
  </div>
</template>

<script>
import { getCategoryList } from '@/api/category'

export default {
  name: 'Layout',
  data() {
    return {
      cid: null,
      gray_background: false,
      cateInfo: null,
      category_loading: false,
      categories: [],
      sub_categories: [],
      is_user_admin: false,
    }
  },
  watch: {
    $route(to) {
      if(to.path.indexOf("/user_admin/") == 0) {
        this.is_user_admin = true
      }
      else 
        this.is_user_admin = false
      this.checkGrayBackGround(to.path)
      if(to.query.cid) {
        this.cid = parseInt(to.query.cid)
        this.setSubCategories()
      }
      else {
        this.cid = null
      }
    }
  },
  computed: {
    getPid() {
      if(this.cid === null) {
        return 0
      }
      if(this.cateInfo !== null) {
        return parseInt(this.cateInfo.pid)
      }
      return 0
    }
  },
  mounted() {
    if(this.$route.path.indexOf("/user_admin/") == 0) {
      this.is_user_admin = true
    }
    else {
      this.is_user_admin = false
    }
    this.checkGrayBackGround(this.$route.paht)
    if(this.$route.query.cid) {
      this.cid = parseInt(this.$route.query.cid)
    }
    else {
      this.cid = null
    }
    this.getCategoryList()
  },
  methods: {
    clickUserMember() {
      this.$router.push('/user_admin/index')
    },
    checkGrayBackGround(path) {
      if(path == '/' || path == '/goods/index' || path == '/goods/list') {
        this.gray_background = true
      }
      else {
        this.gray_background = false
      }
    },
    setSubCategories() {
      if(this.cid === null) {
        this.cateInfo = null
        this.sub_categories = []
        return
      }
      for(let i = 0; i < this.categories.length; i++) {
        if(this.categories[i].id == this.cid) {
          this.cateInfo = null
          if(this.categories[i].childcnt > 0) {
            this.sub_categories = this.categories[i].children
          }
          else {
            this.sub_categories = []
          }
          break
        }
        else if(this.categories[i].childcnt > 0) {
          let children = this.categories[i].children
          for(let j = 0; j < children.length; j++) {
            if(children[j].id == this.cid) {
              this.sub_categories = children
              this.cateInfo = children[j]
              break
            }
          }
        }
      }
    },
    clickCategory(cid) {
      this.$router.push('/goods/list?cid=' + cid)
    },
    clickSiteName() {
      this.cid = null
      this.$router.push('/')
    },
    getCategoryList() {
      this.category_loading = true
      getCategoryList({
        is_post: 'yes',
      }).then(response => {
        this.categories = response.data.categories
        this.cateInfo = response.data.cateInfo
        this.setSubCategories()
        this.category_loading = false
      }).catch(error => {
        this.category_loading = false
      })
    }
  }
}
</script>

<style>
::-webkit-scrollbar {
  /*滚动条整体样式*/
  width : 5px !important;  /*高宽分别对应横竖滚动条的尺寸*/
  height: 5px !important;
  cursor: pointer !important;
}
::-webkit-scrollbar-thumb {
  /*滚动条里面小方块*/
  border-radius   : 10px !important;
  background-color: #DDDEE0 !important;
}
::-webkit-scrollbar-thumb:hover {
  /*滚动条里面小方块*/
  border-radius   : 10px !important;
  background-color: #b3b3b4 !important;
}
</style>

<style lang="scss" scoped>
.clearfix:after{
  visibility:hidden;
  display:block;
  font-size:0;
  content: " ";
  clear:both;
  height:0;
}
.header-wrapper {
  position: fixed;
  height: 55px;
  border-bottom: 2px solid #f10214;
  background-color: #fff;
  box-shadow: 2px 2px 2px rgb(0 0 0 / 20%);
  width: 100%;
  z-index: 1;
}
.category-childs-wrapper {
  position: fixed;
  top: 55px;
  height: 38px;
  width: 100%;
  background-color: #fff;
  border-bottom: 1px solid #dadada;
  z-index: 1;
}
.header-inner {
  width: 1200px;
  margin: 0 auto;
  padding-top: 15px;
}
.category-childs-inner {
  width: 1200px;
  margin: 0 auto;
  padding-top: 15px;
}
.category-child-item {
  cursor: pointer;
  width: 150px;
  font-size: 16px;
  line-height: 10px;
  color: #333;
  float: left;
  text-align: center;
}
.site-name {
  font-size: 18px;
  line-height: 30px;
  width: 150px;
  float: left;
  text-align: center;
  border-right: 1px solid #dadada;
  color: #666;
  font-weight: 700;
}
.category-wrapper {
  font-size: 16px;
  float: left;
}
.category-item {
  float: left;
  width: 150px;
  color: #333;
  font-size: 16px;
  font-weight: 700;
  line-height: 27px;
  text-align: center;
  border-right: 1px solid #dadada;
}
.category-item:hover, .site-name:hover, .category-child-item:hover{
  color: #c81623;
  cursor: pointer;
}
.category-current {
  color: #c81623;
}
.category-loading {
  font-size: 16px;
  line-height: 27px;
  color: gray;
  width: 150px;
  text-align: center;
}
.app-wrapper {
  background-color: white;
  width: 100%;
}
.app-wrapper-useradmin {
  height: 100%;
}
.app-gray-background {
  background-color: #f4f4f4;
}
.app-content {
  padding-top: 55px;
  width: 1200px;
  margin: 0 auto;
}
.app-user-admin {
  height: calc(100% - 55px - 60px);
  width: calc(100% - 100px);
}
.category-has-sub {
  padding-top: 93px;
}
.app-bottom {
  border-top: 1px solid #dedede;
  background-color: #f4f4f4;
  margin-top: 20px;
  padding-top: 20px;
  padding-bottom: 50px;
}
.app-bottom-inner {
  width: 1200px;
  margin: 0 auto;
}
</style>
