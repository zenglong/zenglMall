<template>
  <div v-loading="loading">
    <el-form label-width="120px" style="margin-top: 10px">
      <el-form-item label="属性名">
        <el-input v-model="form.name" class="myel-inner-item" placeholder="请输入属性名"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit()" :loading="add_button_loading" round>提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { addAttr } from '@/api/goods_attr'

export default {
  data() {
    return {
      loading: false,
      add_button_loading: false,
      form: {
        name: '',
      }
    }
  },
  methods: {
    closeDialog(refresh = false) {
      if(refresh) {
        this.$emit('close_refresh_event')
      }
      else {
        this.$emit('close_event')
      }
    },
    onSubmit() {
      this.add_button_loading = true
      addAttr({...this.form}).then(response => {
        this.$message({
          message: response.msg,
          type: 'success'
        });
        this.add_button_loading = false
        this.closeDialog(true)
      }).catch(error => {
        this.add_button_loading = false
      })
    }
  }
}
</script>
