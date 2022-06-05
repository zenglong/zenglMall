<template>
  <div class="user-index-wrapper" v-loading="loading">
    <div class="user-title">会员中心</div>
    <div class="user-name">用户名：{{ user_info.username }}</div>
    <div class="user-email">邮箱：{{ user_info.email }}</div>
  </div>
</template>

<script>
import { adminIndex } from '@/api/user'

export default {
  data() {
    return {
      loading: false,
      user_info: {},
    }
  },
  mounted() {
    this.adminIndex()
  },
  methods: {
    adminIndex() {
      this.loading = true
      adminIndex().then(response => {
        this.user_info = response.data.user_info
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
.user-index-wrapper {
  padding-left: 15px;
}
.user-title {
  margin-top: 20px;
}
.user-name, .user-email {
  margin-top: 20px;
}
</style>
