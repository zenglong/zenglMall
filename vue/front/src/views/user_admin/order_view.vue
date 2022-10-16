<template>
  <div class="form-wrapper" v-loading="loading">
    <el-form :model="info" label-width="150px" style="margin-top: 10px" :inline="false">
      <el-form-item label="订单号">
        <span>{{ info.oid }}</span>
      </el-form-item>
      <el-form-item label="支付宝交易号">
        <span>{{ info.tid ? info.tid : '无' }}</span>
      </el-form-item>
      <el-form-item label="商品名称">
        <span>{{ info.name }}</span>
      </el-form-item>
      <el-form-item label="商品描述">
        <span>{{ info.description }}</span>
      </el-form-item>
      <el-form-item label="商品缩略图">
        <img v-if="info.thumbnail" :src="getImagePath(info.thumbnail)" width="210" height="210" />
        <span v-else>无</span>
      </el-form-item>
      <el-form-item label="订单数量">
        <span>{{ info.num }}</span>
      </el-form-item>
      <el-form-item label="订单金额">
        <span>{{ info.amount }}</span>
      </el-form-item>
      <el-form-item label="收货人电话">
        <span>{{ info.phone }}</span>
      </el-form-item>
      <el-form-item label="真实姓名">
        <span>{{ info.true_name }}</span>
      </el-form-item>
      <el-form-item label="收货地址">
        <span>{{ info.address }}</span>
      </el-form-item>
      <el-form-item label="创建时间">
        <span>{{ info.create_time }}</span>
      </el-form-item>
      <el-form-item label="更新时间">
        <span>{{ info.update_time }}</span>
      </el-form-item>
      <el-form-item label="支付时间">
        <span>{{ info.pay_time ? info.pay_time : '无' }}</span>
      </el-form-item>
      <el-form-item label="设置成待收货状态的时间">
        <span>{{ info.send_time ? info.send_time : '无' }}</span>
      </el-form-item>
      <el-form-item label="确认收货时间">
        <span>{{ info.confirm_time ? info.confirm_time : '无' }}</span>
      </el-form-item>
      <el-form-item label="订单状态">
        <span>{{ get_order_status_name(info.status) }}</span>
      </el-form-item>
      <el-form-item label="买家备注">
        <span>{{ info.buyer_remark ? info.buyer_remark : '无' }}</span>
      </el-form-item>
      <el-form-item label="商家备注" class="seller-remark-label">
        <div class="seller-remark" v-html="info.seller_remark ? info.seller_remark : '<p>无</p>'"></div>
      </el-form-item>
      <div class="save-botton-wrapper">
        <el-button type="primary" round v-if="info.status == 'WAIT_BUYER'" class="continue-pay-btn"
          @click="continuePay()"
          :loading="continue_pay_loading">
          继续付款
        </el-button>
        <el-button type="danger" round v-else-if="info.status == 'WAIT_BUYER_CONFIRM'" class="buyer-confirm-btn"
          @click="setBuyerConfirm()"
          :loading="set_status_loading">
          确认收货
        </el-button>
        <el-button type="default" class="return-to-list" round @click="returnToList()">返回</el-button>
      </div>
    </el-form>

    <div v-if="do_pay">
      <form id='alipaysubmit' name='alipaysubmit' :action='gateway_url' style='display:none;' ref="alipayForm">
        <template v-for="(param, key) in params">
          <div :key="key"><input :name='key' :value="param" /></div>
        </template>
        <div><input type='submit' value='ok'></div>
      </form>
    </div>
  </div>
</template>

<script>
import { getInfo, setBuyerConfirm, continuePay } from '@/api/order'
import { getImagePath, get_order_status_name } from '@/assets/js/common'

export default {
  props: {
    order_id: {
      type: Number,
      default: 0,
    },
    updateCallback: {
      type: Function,
      default: null,
    }
  },
  data() {
    return {
      loading: false,
      continue_pay_loading: false,
      set_status_loading: false,
      do_pay: false,
      params: {},
      gateway_url: '',
      immediate_pay: false,
      info: {}
    }
  },
  mounted() {
    if(this.order_id > 0) {
      this.getInfo(this.order_id)
    }
  },
  methods: {
    continuePay() {
      this.continue_pay_loading = true
      continuePay({id: this.order_id}).then(response => {
        this.params = response.data.params
        this.gateway_url = response.data.gateway_url + '?charset=' + this.params['charset']
        this.immediate_pay = response.data.immediate_pay ? true : false
        this.do_pay = true
        // this.continue_pay_loading = false
        this.$nextTick(() => {
          this.$refs.alipayForm.submit();
        })
      }).catch(error => {
        this.continue_pay_loading = false
      })
    },
    returnToList() {
      this.$parent.$parent.showOrderInfo = false
    },
    get_order_status_name(status) {
      return get_order_status_name(null, status)
    },
    getImagePath(image) {
      return getImagePath(image)
    },
    getInfo(order_id) {
      this.loading = true
      getInfo({id: order_id}).then(response => {
        this.info = response.data.order_info
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    setBuyerConfirm() {
      this.$confirm('是否确认收货?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.set_status_loading = true
        setBuyerConfirm({id: this.order_id}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.set_status_loading = false
          this.getInfo(this.order_id)
          if(this.updateCallback !== null) {
            this.updateCallback()
          }
        }).catch(error => {
          this.set_status_loading = false
        })
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
.form-wrapper {
  margin-top: 35px;
  padding-right: 15px;
  padding-bottom: 50px;
}
.continue-pay-btn, .buyer-confirm-btn {
  margin-left: 75px;
}
.return-to-list {
  margin-left: 30px;
}
.seller-remark {
  line-height: 20px;
}
.seller-remark-label {
  ::v-deep .el-form-item__label {
    line-height: 48px;
  }
}
</style>
