<template>
  <div class="user-admin-wrapper clearfix">
    <div class="user-menu-left">
      <div :class="'user-menu-item' + (activeTag == 'index' ? ' user-menu-active' : '')" @click="clickTag('index')">概览</div>
      <div :class="'user-menu-item' + (activeTag == 'orderList' ? ' user-menu-active' : '')" @click="clickTag('orderList')">订单列表</div>
    </div>
    <div class="user-content-right">
      <router-view />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeTag: 'index',
    }
  },
  mounted() {
    if(this.$route.path == '/user_admin/index') {
      this.activeTag = 'index'
    } else if(this.$route.path == '/user_admin/order_list') {
      this.activeTag = 'orderList'
    }
  },
  methods: {
    clickTag(tagName) {
      this.activeTag = tagName
      if(this.activeTag == 'index') {
        this.$router.push('/user_admin/index')
      } else if(this.activeTag == 'orderList') {
        this.$router.push('/user_admin/order_list')
      }
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
.user-admin-wrapper {
  height: 100%;
}
.user-menu-left {
  float: left;
  border-right: 1px solid #EBEEF5;
  width: 216px;
  height: 100%;
  margin-top: 8px;
  padding-top: 10px;
}
.user-menu-item {
  // margin-top: 20px;
  height: 56px;
  line-height: 56px;
  font-size: 14px;
  color: #303133;
  padding: 0 20px;
  list-style: none;
  cursor: pointer;
  transition: border-color .3s,background-color .3s,color .3s;
  box-sizing: border-box;
  white-space: nowrap;
}
.user-menu-item:hover {
  background-color: #ecf5ff;
}
.user-content-right {
  float: left;
  width: calc(100% - 216px);
  height: 100%;
  overflow-y: auto;
  padding-left: 15px;
  padding-top: 8px;
}
.user-menu-active {
  color: #409eff;
}
</style>
