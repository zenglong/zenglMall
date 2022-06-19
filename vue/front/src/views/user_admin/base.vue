<template>
  <div class="user-admin-wrapper clearfix">
    <div class="user-menu-left">
      <div :class="'user-menu-item' + (activeTag == 'index' ? ' user-menu-active' : '')" @click="clickTag('index')">概览</div>
      <div :class="'user-menu-item' + (activeTag == 'orderList' ? ' user-menu-active' : '')" @click="clickTag('orderList')">订单列表</div>
      <div :class="'user-menu-item' + (activeTag == 'userInfo' ? ' user-menu-active' : '')" @click="clickTag('userInfo')">修改信息</div>
      <div :class="'user-menu-item' + (activeTag == 'password' ? ' user-menu-active' : '')" @click="clickTag('password')">修改密码</div>
      <div :class="'user-menu-item' + (activeTag == 'logout' ? ' user-menu-active' : '')" @click="clickTag('logout')">退出登录</div>
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
    } else if(this.$route.path == '/user_admin/user_info') {
      this.activeTag = 'userInfo'
    } else if(this.$route.path == '/user_admin/password') {
      this.activeTag = 'password'
    }
  },
  methods: {
    clickTag(tagName) {
      this.activeTag = tagName
      if(this.activeTag == 'index') {
        this.$router.push('/user_admin/index')
      } else if(this.activeTag == 'orderList') {
        this.$router.push('/user_admin/order_list')
      } else if(this.activeTag == 'userInfo') {
        this.$router.push('/user_admin/user_info')
      } else if(this.activeTag == 'password') {
        this.$router.push('/user_admin/password')
      } else if(this.activeTag == 'logout') {
        this.$confirm('确定退出吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$store.dispatch('user/logout').then((response) => {
            this.$message({
              message: response.msg,
              type: 'success'
            })
            window.location.reload()
          }).catch(error => {
          })
        }).catch(() => {
        })
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
