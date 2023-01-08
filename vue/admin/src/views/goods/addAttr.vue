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
import { addAttr, editAttr, getInfo } from '@/api/goods_attr'

export default {
  props: {
    prop_attr_id: {
      type: Number,
      default: 0,
    }
  },
  data() {
    return {
      loading: false,
      add_button_loading: false,
      form: {
        id: 0,
        name: '',
      }
    }
  },
  mounted() {
    if(this.prop_attr_id > 0) {
      this.form.id = this.prop_attr_id
      this.getInfo(this.form.id)
    }
  },
  methods: {
    getInfo(id) {
      this.loading = true
      getInfo({id}).then(response => {
        this.form.id = response.data.attr.id
        this.form.name = response.data.attr.name
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    closeDialog(refresh = false, is_edit = false) {
      if(refresh) {
        if(is_edit) {
          this.$emit('close_refresh_edit_event')
        }
        else
          this.$emit('close_refresh_event')
      }
      else {
        this.$emit('close_event')
      }
    },
    onSubmit() {
      this.add_button_loading = true
      if(this.form.id > 0) {
        editAttr({...this.form}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          });
          this.add_button_loading = false
          this.closeDialog(true, true)
        }).catch(error => {
          this.add_button_loading = false
        })
      }
      else {
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
}
</script>
