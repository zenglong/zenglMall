<template>
  <div v-loading="loading">
    {{ msg }}
  </div>
</template>

<script>
import { payReturn } from '@/api/goods_pay'

export default {
  data() {
    return {
      loading: false,
      msg: '支付结果检测中...',
    }
  },
  mounted() {
    // console.log(this.$route.query)
    this.payReturn()
  },
  methods: {
    payReturn() {
      this.loading = true
      payReturn(this.$route.query).then(response => {
        this.msg = response.msg
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    }
  }
}
</script>
