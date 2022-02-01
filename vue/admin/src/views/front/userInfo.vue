<template>
  <div class="app-container">
    <div class="clearfix">
      <el-button type="primary" @click="returnToList()" style="margin-bottom: 10px; float:right; margin-right: 20px" round>返回</el-button>
    </div>
    <el-descriptions title="用户信息" v-loading="loading" :column="2" border>
      <el-descriptions-item label="用户ID">{{ user_info.id }}</el-descriptions-item>
      <el-descriptions-item label="用户名">{{ user_info.username }}</el-descriptions-item>
      <el-descriptions-item label="用户昵称">
        <span v-if="user_info.nickname == ''">[未设置]</span>
        <span v-else>{{user_info.nickname}}</span>
      </el-descriptions-item>
      <el-descriptions-item label="邮箱">{{user_info.email}}</el-descriptions-item>
      <el-descriptions-item label="收货人电话">
        <span v-if="user_info.phone == ''">[未设置]</span>
        <span v-else>{{user_info.phone}}</span>
      </el-descriptions-item>
      <el-descriptions-item label="收货人真实姓名">
        <span v-if="user_info.true_name == ''">[未设置]</span>
        <span v-else>{{user_info.true_name}}</span>
      </el-descriptions-item>
      <el-descriptions-item label="注册时间">{{ user_info.reg_time }}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{ user_info.update_time }}</el-descriptions-item>
      <el-descriptions-item label="收货地址">
        <span v-if="user_info.address == ''">[未设置]</span>
        <span v-else>{{user_info.address}}</span>
      </el-descriptions-item>
    </el-descriptions>
  </div>
</template>

<script>
import { getUserInfo } from '@/api/front'

export default {
  props: {
    id: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loading: false,
      user_info: {},
    }
  },
  mounted() {
    if(this.id > 0) {
      this.getUserInfo(this.id)
    }
  },
  methods: {
    returnToList() {
      this.$parent.showUserList()
    },
    getUserInfo(id) {
      this.loading = true
      getUserInfo({ id }).then(response => {
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
</style>