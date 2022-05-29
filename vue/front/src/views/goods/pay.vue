<template>
  <div class="pay-wrapper" v-loading="loading">
    <el-form class="pay-form">
      <el-form-item label="当前用户">
        <div>{{ user_info.username }}</div>
      </el-form-item>
      <el-form-item label="收货人姓名">
        <el-input v-model="posts_data.true_name" placeholder="收货人姓名"></el-input>
      </el-form-item>
      <el-form-item label="收货人电话">
        <el-input v-model="posts_data.phone" placeholder="收货人电话"></el-input>
      </el-form-item>
      <el-form-item label="收货地址">
        <el-input v-model="posts_data.address" type="textarea" rows="5" placeholder="收货地址"></el-input>
      </el-form-item>
      <el-form-item label="买家备注">
        <el-input v-model="posts_data.buyer_remark" type="textarea" rows="5" placeholder="买家备注"></el-input>
      </el-form-item>
      <el-form-item label="购买商品信息">
        <el-table ref="multipleTable1" border :data="list_data" style="width: 100%; margin-top: 20px; margin-left: 0px" :fit="true">
          <el-table-column prop="thumbnail" label="缩略图" width="250">
            <template slot-scope="scope">
              <img v-if="scope.row.thumbnail" :src="scope.row.thumbnail" width="210" height="210" />
            </template>
          </el-table-column>
          <el-table-column prop="name" label="商品名" min-width="200"></el-table-column>
          <el-table-column prop="price" label="商品价格" min-width="200"></el-table-column>
          <el-table-column prop="buy_num" label="购买数量" min-width="200"></el-table-column>
          <el-table-column prop="pay_money" label="购买金额" min-width="200"></el-table-column>
        </el-table>
      </el-form-item>
      <el-button :loading="pay_loading" type="primary" style="width:150px;margin-bottom:20px;" @click="doPay()">确认支付</el-button>
    </el-form>

    <div v-if="do_pay">
      <form id='alipaysubmit' name='alipaysubmit' :action='gateway_url'>
        <template v-for="(param, key) in params">
          <div :key="key"><input :name='key' :value="param" /></div>
        </template>
        <div><input type='submit' value='ok'></div>
      </form>
    </div>
  </div>
</template>

<script>
import { getPayInfo, doPay } from '@/api/goods_pay'

export default {
  data() {
    return {
      gid: 0,
      buy_num: 0,
      loading: false,
      pay_loading: false,
      do_pay: false,
      params: {},
      gateway_url: '',
      immediate_pay: false,
      user_info: {
        username: '',
      },
      posts_data: {
        true_name: '',
        phone: '',
        address: '',
        buyer_remark: '',
      },
      list_data: [],
    }
  },
  mounted() {
    if(this.$route.query.gid) {
      this.gid = parseInt(this.$route.query.gid)
    }
    if(this.$route.query.num) {
      this.buy_num = parseInt(this.$route.query.num)
    }
    this.getPayInfo()
  },
  methods: {
    getPayInfo() {
      this.loading = true
      getPayInfo({gid: this.gid, buy_num: this.buy_num}).then(response => {
        this.user_info = response.data.user_info
        if(this.user_info.true_name) {
          this.posts_data.true_name = this.user_info.true_name
        }
        if(this.user_info.phone) {
          this.posts_data.phone = this.user_info.phone
        }
        if(this.user_info.address) {
          this.posts_data.address = this.user_info.address
        }
        this.list_data = [response.data.goods_info]
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    doPay() {
      this.pay_loading = true
      doPay({gid: this.gid, 
        buy_num: this.buy_num,
        phone: this.posts_data.phone,
        true_name: this.posts_data.true_name,
        address: this.posts_data.address,
        buyer_remark: this.posts_data.buyer_remark,
      }).then(response => {
        this.params = response.data.params
        this.gateway_url = response.data.gateway_url + '?charset=' + this.params['charset']
        this.immediate_pay = response.data.immediate_pay ? true : false
        this.do_pay = true
        this.pay_loading = false
      }).catch(error => {
        this.pay_loading = false
      })
    }
  }
}
</script>
