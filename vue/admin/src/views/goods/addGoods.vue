<template>
  <div class="form-wrapper">
    <el-form :model="form" label-width="120px" style="margin-top: 10px" :inline="false">
      <el-form-item label="商品名称">
        <el-input v-model="form.name" class="myel-inner-item" placeholder="请输入商品名称"></el-input>
      </el-form-item>
      <el-form-item label="商品价格">
        <el-input v-model="form.price" class="myel-inner-item" placeholder="请输入商品价格"></el-input>
      </el-form-item>
      <el-form-item label="商品市场价格">
        <el-input v-model="form.market_price" class="myel-inner-item" placeholder="请输入商品市场价格"></el-input>
      </el-form-item>
      <el-form-item label="商品库存">
        <el-input v-model="form.store_num" class="myel-inner-item" placeholder="请输入商品库存"></el-input>
      </el-form-item>
      <el-form-item label="关键词">
        <el-input v-model="form.keywords" class="myel-inner-item" placeholder="请输入关键词"></el-input>
      </el-form-item>
      <el-form-item label="商品描述">
        <el-input v-model="form.description" type="textarea" class="myel-inner-item form-description" placeholder="请输入商品描述"></el-input>
      </el-form-item>
      <el-form-item label="商品内容">
        <ckeditor v-model="form.content"></ckeditor>
      </el-form-item>
      <el-form-item label="商品分类">
        <el-cascader :options="categories" 
          class="search-item search-cid"
          v-model="form.cid"
          clearable
          :props="{ checkStrictly: true, value: 'id', label: 'name' }"
          :loading="category_loading"></el-cascader>
      </el-form-item>
      <div class="save-botton-wrapper">
        <el-button type="default" round>取消</el-button>
        <el-button type="primary" round class="save-button">保存</el-button>
      </div>
    </el-form>
  </div>
</template>

<script>
import { getList as getCategoryList } from '@/api/category'
import Vue from 'vue';
import CKEditor from 'ckeditor4-vue';
Vue.use( CKEditor );

export default {
  data() {
    return {
      category_loading: false,
      editor: null,
      categories: [],
      form: {
        name: '',
        price: '',
        market_price: '',
        store_num: '',
        keywords: '',
        description: '',
        content: 'hi商品内容',
        cid: null,
      }
    }
  },
  mounted() {
    this.getCategoryList()
  },
  methods: {
    returnToList() {
      this.$router.replace('/goods/index')
    },
    getCategoryList() {
      this.category_loading = true
      getCategoryList().then(response => {
        this.categories = response.data.categories
        this.category_loading = false
      }).catch(error => {
        this.category_loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.clearfix:after{
  visibility:hidden;
  display:block;
  font-size:0;
  content: " ";
  clear:both;
  height:0;
}
.form-wrapper {
  margin-top: 35px;
  padding-right: 15px;
  padding-bottom: 50px;
}
.myel-inner-item {
  ::v-deep .el-input__inner {
    width: 550px;
    height: 35px;
    line-height: 35px;
    border-radius: 36px;
  }
}
.form-description {
  ::v-deep .el-textarea__inner {
    width: 550px;
    border-radius: 15px;
  }
}
.save-botton-wrapper {
  text-align: center;
}
</style>
