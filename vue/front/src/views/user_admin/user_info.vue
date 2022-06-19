<template>
  <div>
    <el-form class="user-form" v-loading="loading">
      <el-form-item label="当前用户">
        <div>{{ user_info.username }}</div>
      </el-form-item>
      <el-form-item label="用户昵称" class="my-form-item">
        <el-input v-model="user_info.nickname" placeholder="用户昵称"></el-input>
      </el-form-item>
      <el-form-item label="邮箱" class="my-form-item">
        <el-input v-model="user_info.email" placeholder="邮箱"></el-input>
      </el-form-item>
      <el-form-item label="收货人真实姓名" class="my-form-item">
        <el-input v-model="user_info.true_name" placeholder="收货人真实姓名"></el-input>
      </el-form-item>
      <el-form-item label="收货人电话" class="my-form-item">
        <el-input v-model="user_info.phone" placeholder="收货人电话"></el-input>
      </el-form-item>
      <el-form-item label="收获地址" class="my-form-item">
        <el-input v-model="user_info.address" type="textarea" rows="5" placeholder="收获地址"></el-input>
      </el-form-item>
      <el-button :loading="modify_loading" type="primary" style="width:150px;margin-bottom:20px;" @click="modifyInfo()">修改信息</el-button>
    </el-form>
  </div>
</template>

<script>
import { getUserInfo, modifyUserInfo } from '@/api/user'

export default {
  data() {
    return {
      loading: false,
      modify_loading: false,
      user_info: {
        username: '',
        nickname: '',
        email: '',
        true_name: '',
        phone: '',
        address: '',
      }
    }
  },
  mounted() {
    this.getUserInfo()
  },
  methods: {
    getUserInfo() {
      this.loading = true
      getUserInfo().then(response => {
        this.user_info = response.data.user_info
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    modifyInfo() {
      this.modify_loading = true
      modifyUserInfo({
        nickname: this.user_info.nickname,
        email: this.user_info.email,
        true_name: this.user_info.true_name,
        phone: this.user_info.phone,
        address: this.user_info.address,
      }).then(response => {
        this.$message({
          message: response.msg,
          type: 'success'
        })
        this.modify_loading = false
      }).catch(error => {
        this.modify_loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.my-form-item {
  ::v-deep .el-input__inner {
    width: 80%;
  }
  ::v-deep .el-textarea__inner {
    width: 80%;
  }
}
</style>
