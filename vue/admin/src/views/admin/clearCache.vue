<template>
  <div class="app-container">
    <el-button-group style="margin-top: 20px; margin-left: 20px">
      <el-button type="primary" @click="clearCache()" :loading="loading">清理缓存</el-button>
    </el-button-group>
  </div>
</template>

<script>
import { clearCache } from '@/api/cache'

export default {
  data() {
    return {
      loading: false
    }
  },
  methods: {
    clearCache() {
      this.loading = true
        clearCache().then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.loading = false
        }).catch(error => {
          this.loading = false
        })
    }
  }
}
</script>
