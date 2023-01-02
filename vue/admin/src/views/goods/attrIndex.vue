<template>
  <div class="app-container">
    <div class="search-header">
      <el-button type="primary" @click="addAttr()" round class="add-button">添加属性</el-button>
    </div>

    <el-dialog v-draggable class="dialogWraper" :title="dialogTitle" :visible.sync="dialogVisible"
      :close-on-click-modal="false"
      width="50%"
      :lock-scroll="true">
      <add-attr v-if="dialogVisible" @close_event="closeDialog()" @close_refresh_event="closeDialog(true)"></add-attr>
    </el-dialog>
  </div>
</template>

<script>
import addAttr from './addAttr'
import DlgDraggable from "vue-element-dialog-draggable"
import Vue from 'vue'
Vue.use(DlgDraggable, {
  containment: true //Constrains dragging to within the bounds of the window.  Default: false.
})

export default {
  components: {
    addAttr
  },
  data() {
    return {
      dialogTitle: '',
      dialogVisible: false,
    }
  },
  methods: {
    closeDialog(refresh = false) {
      this.dialogVisible = false
      if(refresh) {
        // TODO
      }
    },
    addAttr() {
      this.dialogTitle = '添加属性'
      this.dialogVisible = true
    },
  }
}
</script>

<style lang="scss" scoped>

</style>
