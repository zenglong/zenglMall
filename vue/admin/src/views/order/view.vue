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
        <span>{{ info.buyer_remark }}</span>
      </el-form-item>
      <el-form-item label="商家备注">
        <div id="div1"></div>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getInfo } from '@/api/order'
import { getImagePath, get_order_status_name } from '@/assets/js/common'
import { mapGetters } from 'vuex';
import E from "wangeditor"

export default {
  data() {
    return {
      loading: false,
      VUE_APP_API_BASE_URL: '',
      upload_action: '',
      editor: null,
      info: {}
    }
  },
  computed: {
    ...mapGetters([
      'token',
    ]),
  },
  mounted() {
    this.VUE_APP_API_BASE_URL = process.env.VUE_APP_API_BASE_URL
    this.upload_action = this.VUE_APP_API_BASE_URL + '/admin/upload.zl?act=thumbImg&token=' + this.token
    let that = this
    const editor = new E("#div1")
    editor.config.height = 250
    editor.config.uploadImgMaxLength = 1
    editor.config.uploadImgMaxSize = 2 * 1024 * 1024 // 2M
    editor.config.uploadImgParams = {
      baseurl: this.VUE_APP_API_BASE_URL
    }
    editor.config.zIndex = 1
    editor.config.uploadImgHooks = {
      customInsert: function(insertImgFn, result) {
        // result 即服务端返回的接口
        console.log('customInsert', result)

        if(result.msg != '') {
          that.$message.error(result.msg);
        }
        else {
          insertImgFn(result.url)
        }
        // insertImgFn 可把图片插入到编辑器，传入图片 src ，执行函数即可
        // insertImgFn(result.data[0])
      }
    }
    editor.config.uploadFileName = 'upload'
    editor.config.uploadImgServer = this.VUE_APP_API_BASE_URL + '/admin/upload.zl?act=ckImage&token=' + this.token
    editor.create()
    this.editor = editor
    let order_id = this.$route.query.id
    if(order_id > 0) {
      this.getInfo(order_id)
    }
  },
  methods: {
    get_order_status_name(status) {
      return get_order_status_name(null, status)
    },
    getImagePath(image) {
      return getImagePath(image)
    },
    getInfo(order_id) {
      this.loading = true
      getInfo({id: order_id}).then(response => {
        this.info = response.data.info
        this.editor.txt.html(this.info.seller_remark)
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
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
</style>
