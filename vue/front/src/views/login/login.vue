<template>
  <div class="login-wrapper">
    <el-form class="login-form" label-position="left">
      <el-form-item label="">
        <el-input v-model="form.username" placeholder="用户名"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="form.password" placeholder="密码" type="password"></el-input>
      </el-form-item>
      <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:20px;" @click="login()">登 录</el-button>
    </el-form>
    <div class="link-wrapper">
      <router-link to="/register">用户注册</router-link>
    </div>
  </div>
</template>

<script>
import { getLoginRedirectName } from '@/assets/js/common'
import Cookies from "js-cookie"

export default {
  data() {
    return {
      redirect: '/',
      loading: false,
      form: {
        username: '',
        password: '',
      }
    }
  },
  mounted() {
    if(Cookies.get(getLoginRedirectName())) {
      this.redirect = Cookies.get(getLoginRedirectName())
      console.log('mounted redirect',this.redirect)
    }
  },
  methods: {
    login() {
      this.$store.dispatch('user/login', this.form).then(() => {
        if(Cookies.get(getLoginRedirectName())) {
          Cookies.remove(getLoginRedirectName())
        }
        console.log('user login redirect',this.redirect)
        this.$router.push({ path: this.redirect })
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.login-form {
  width: 40%;
  margin:0 auto;
  margin-top: 60px;
}
.link-wrapper {
  margin: 0 auto;
  width: 40%;
  a {
    color: #337ab7;
    text-decoration: none;
  }
}
</style>
