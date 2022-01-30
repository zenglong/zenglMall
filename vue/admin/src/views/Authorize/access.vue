<template>
  <div v-loading="loading">
    <el-tree
      :data="access_rules"
      show-checkbox
      node-key="id"
      ref="tree"
      highlight-current
      :props="defaultProps">
    </el-tree>
    <el-button-group style="margin-top: 20px; margin-left: 20px">
      <el-button type="primary" @click="onSubmit('activityForm')" :loading="add_button_loading">提交</el-button>
    </el-button-group>
  </div>
</template>

<script>
import { getAccess, setAccess } from '@/api/authorize'

export default {
  props: {
    accessCloseDialog: {
      type: Function,
      default: null
    },
    group_id: {
      type: Number,
      default: 0
    }
  },
  mounted() {
    if(this.group_id > 0) {
      this.getAccess()
    }
  },
  data() {
    return {
      loading: false,
      add_button_loading: false,
      access_rules: [],
      defaultProps: {
        children: 'children',
        label: 'label'
      }
    }
  },
  methods: {
    closeDialog() {
      if(this.accessCloseDialog) {
        this.accessCloseDialog()
      }
    },
    getAccess() {
      this.loading = true
      getAccess({id: this.group_id}).then(response => {
        this.access_rules = response.data.tree_data
        this.$refs.tree.setCheckedKeys(response.data.checked_keys)
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    onSubmit() {
      this.add_button_loading = true
      let checked_keys = this.$refs.tree.getCheckedKeys()
      setAccess({id: this.group_id, rules: checked_keys}).then(response => {
        this.$message({
            message: response.msg,
            type: 'success'
          })
          this.add_button_loading = false
          this.closeDialog()
      }).catch(error => {
        this.add_button_loading = false
      })
    }
  }
}
</script>
