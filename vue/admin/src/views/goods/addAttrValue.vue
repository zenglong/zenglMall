<template>
  <div>
    <el-form label-width="120px" style="margin-top: 10px">
      <el-form-item label="属性值名">
        <el-input v-model="form.name" class="myel-inner-item" placeholder="请输入属性值名"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit()" :loading="add_button_loading" round>提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { addAttrValue, editAttrValue, getInfo } from '@/api/goods_attr_value'

export default {
  props: {
    prop_aid: {
      type: Number,
      default: 0,
    },
    prop_id: {
      type: Number,
      default: 0,
    }
  },
  data() {
    return {
      add_button_loading: false,
      form: {
        id: 0,
        aid: 0,
        name: '',
      }
    }
  },
  mounted() {
    if(this.prop_aid > 0) {
      this.form.aid = this.prop_aid
      if(this.prop_id > 0) {
        this.form.id = this.prop_id
        this.getInfo()
      }
    }
  },
  methods: {
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
    getInfo() {
      this.loading = true
      getInfo({id: this.form.id}).then(response => {
        this.form.aid = response.data.attr_value.aid
        this.form.name = response.data.attr_value.name
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    onSubmit() {
      this.add_button_loading = true
      if(this.form.id > 0) {
        editAttrValue({...this.form}).then(response => {
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
        addAttrValue({...this.form}).then(response => {
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

<style lang="scss" scoped>

</style>
