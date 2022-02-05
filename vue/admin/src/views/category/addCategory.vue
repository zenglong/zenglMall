<template>
  <div v-loading="loading">
    <el-form :model="form" label-width="120px" style="margin-top: 10px">
      <el-form-item label="分类名">
        <el-input v-model="form.name" class="myel-inner-item" placeholder="请输入分类名"></el-input>
      </el-form-item>
      <el-form-item label="描述">
        <el-input
          type="textarea"
          :rows="2"
          placeholder="请输入分类描述"
          v-model="form.description">
        </el-input>
      </el-form-item>
      <el-form-item label="类型">
        <el-select v-model="form.type" placeholder="请选择类型">
          <el-option
            v-for="item in types"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="上级分类">
        <el-select-tree
          width="120px"
          placeholder="选择上级分类"
          check-strictly
          :data="treeData"
          v-model="form.pid"
          clearable
          :props="{
            value: 'id',
            label: (data) => data.name,
            children: 'children'
          }"
        ></el-select-tree>
        <div> 不选上级分类则表示设置为顶级分类</div>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit()" :loading="add_button_loading" round>提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getSelList,addCategory,getInfo,editCategory } from '@/api/category'
import ElSelectTree from 'el-select-tree';

export default {
  components: {
    ElSelectTree
  },
  props: {
    addCloseDialog: {
      type: Function,
      default: null
    },
    cid: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      loading: false,
      add_button_loading: false,
      value: 2,
      treeData: [],
      types: [
        {
          value: 0,
          label: '普通分类',
        },
        {
          value: 1,
          label: '外部链接',
        }
      ],
      form: {
        id: 0,
        name: '',
        description: '',
        type: 0,
        pid: null,
      }
    }
  },
  mounted() {
    if(this.cid > 0) {
      this.getInfo()
    }
    else {
      this.getSelList()
    }
  },
  methods: {
    closeDialog() {
      if(this.addCloseDialog) {
        this.addCloseDialog()
      }
    },
    getSelList() {
      this.loading = true
      getSelList().then(response => {
        this.treeData = response.data.categories
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    getInfo() {
      this.loading = true
      getInfo({id: this.cid}).then(response => {
        this.form = response.data.category
        if(!this.form.pid) {
          this.form.pid = null
        }
        this.getSelList()
      }).catch(error => {
        this.loading = false
      })
    },
    onSubmit() {
      this.add_button_loading = true
      if(this.form.id > 0) {
        editCategory({...this.form}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          });
          this.add_button_loading = false
          this.closeDialog()
        }).catch(error => {
          this.add_button_loading = false
        })
      }
      else {
        addCategory({...this.form}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          });
          this.add_button_loading = false
          this.closeDialog()
        }).catch(error => {
          this.add_button_loading = false
        })
      }
    }
  }
}
</script>