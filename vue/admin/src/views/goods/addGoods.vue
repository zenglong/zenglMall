<template>
  <div class="form-wrapper" v-loading="loading">
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
      <el-form-item label="商品缩略图">
        <el-upload
          class="thumb-uploader"
          :action="upload_action"
          name="thumbnail_up"
          :show-file-list="false"
          :on-success="handleThumbSuccess"
          :on-error = "handleThumbError"
          :before-upload="beforeThumbUpload">
          <img v-if="form.thumbnail" :src="getImagePath(form.thumbnail)" class="thumb">
          <i v-else class="el-icon-plus thumb-uploader-icon"></i>
        </el-upload>
      </el-form-item>
      <el-form-item label="关键词">
        <el-input v-model="form.keywords" class="myel-inner-item" placeholder="请输入关键词"></el-input>
      </el-form-item>
      <el-form-item label="商品描述">
        <el-input v-model="form.description" type="textarea" class="myel-inner-item form-description" placeholder="请输入商品描述"></el-input>
      </el-form-item>
      <el-form-item label="商品规格">
        <div class="sku-item" v-for="(sku_item, sku_key) in form.sku" :key="'sku_' + sku_key">
          <template v-for="(attr_item, attr_key) in sku_item.attrs" >
            <el-select class="attr-item"
              placeholder="选择规格属性"
              v-model="attr_item.attr_value_id"
              @change="changeAttr(attr_item)"
              :key="'attr_item_' + attr_key">
              <el-option v-for="attr_option in attrs" 
                :key="'attr_value_' + attr_option.attr_value_id" 
                :label="attr_option.attr_name + ': ' + attr_option.attr_value_name"
                :value="attr_option.attr_value_id">
              </el-option>
            </el-select>
            <el-button @click="removeSkuAttr(sku_item, attr_key)" :key="'attr_minus_' + attr_key" v-if="attr_key > 0">
              <i class="el-icon-minus"></i>
            </el-button>
          </template>
          <el-button @click="addSkuAttr(sku_item)"><i class="el-icon-plus"></i></el-button>
          <div class="sku-item-inner">
            <div class="sku-item-input-label">规格标题：</div>
            <el-input v-model="sku_item.name" placeholder="规格标题" class="sku-item-title sku-item-input"></el-input>
            <div class="sku-item-input-label">价格：</div>
            <el-input v-model="sku_item.price" placeholder="规格价格" class="sku-item-price sku-item-input"></el-input>
            <div class="sku-item-input-label">库存：</div>
            <el-input v-model="sku_item.num" placeholder="规格库存" @change="changeSkuNum()" class="sku-item-num sku-item-input"></el-input>
            <div style="clear:both"></div>
          </div>
          <upload @set_thumbnail="setThumbnail(arguments, sku_item)" :prop_thumbnail="sku_item.thumbnail"></upload>
          <el-button @click="removeSku(sku_key)" type="danger">
            <i class="el-icon-minus">移除商品规格</i>
          </el-button>
        </div>
        <el-button class="add-sku-btn" type="default" @click="addSku()"><i class="el-icon-plus"></i> 添加商品规格</el-button>
      </el-form-item>
      <el-form-item label="商品内容">
        <div id="div1"></div>
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
        <el-button type="default" round @click="returnToList()">取消</el-button>
        <el-button type="primary" round class="save-button" @click="onSubmit()" :loading="save_loading">保存</el-button>
      </div>
    </el-form>
  </div>
</template>

<script>
import { getList as getCategoryList } from '@/api/category'
import { getAll as getAttrs } from '@/api/goods_attr_value'
import { addGoods, getInfo, editGoods } from '@/api/goods'
import { getImagePath } from '@/assets/js/common'
import { mapGetters } from 'vuex';
import upload from './upload'
import E from "wangeditor"

export default {
  components: {
    upload
  },
  data() {
    return {
      VUE_APP_API_BASE_URL: '',
      upload_action: '',
      loading: false,
      category_loading: false,
      save_loading: false,
      editor: null,
      categories: [],
      attrs: [],
      form: {
        id: 0,
        name: '',
        thumbnail: '',
        price: '',
        market_price: '',
        store_num: '',
        keywords: '',
        description: '',
        content: '',
        cid: null,
        sku: [],
      }
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
    editor.config.height = 500
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
    this.getCategoryList()
    this.getAttrs()
    let goods_id = this.$route.query.id
    if(goods_id > 0) {
      this.form.id = goods_id
      this.getInfo(goods_id)
    }
  },
  methods: {
    changeSkuNum() {
      let store_num = 0
      for(let i=0; i < this.form.sku.length;i++) {
        store_num += parseInt(this.form.sku[i]['num'])
      }
      this.form.store_num = store_num
    },
    changeAttr(attr_item) {
      for(let i=0; i < this.attrs.length;i++) {
        if(attr_item['attr_value_id'] == this.attrs[i]['attr_value_id']) {
          attr_item.attr_id = this.attrs[i]['attr_id']
          break
        }
      }
    },
    getAttrs() {
      getAttrs({}).then(response => {
        this.attrs = response.data.attrs
      }).catch(error => {
      })
    },
    setThumbnail(args, sku_item) {
      sku_item.thumbnail = args[0]
    },
    addSku() {
      this.form.sku.push({
        attrs: [{
          attr_value_id: null,
        }],
        name: '',
        price: null,
        num: null,
        thumbnail: '',
      })
    },
    removeSku(sku_key) {
      this.$confirm('删除['+ this.form.sku[sku_key].name+']商品规格吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.form.sku.splice(sku_key, 1)
      }).catch(() => {
      })
    },
    addSkuAttr(sku_item) {
      sku_item.attrs.push({
        attr_value_id: null,
      })
    },
    removeSkuAttr(sku_item, attr_key) {
      sku_item.attrs.splice(attr_key, 1)
      console.log(this.form.sku)
    },
    getImagePath(image) {
      return getImagePath(image)
    },
    getInfo(goods_id) {
      this.loading = true
      getInfo({id: goods_id}).then(response => {
        this.form = response.data.goods
        this.editor.txt.html(this.form.content)
        this.loading = false
      }).catch(error => {
        this.loading = false
      })
    },
    onSubmit() {
      this.changeSkuNum()
      let form = JSON.parse(JSON.stringify(this.form))
      form.content = this.editor.txt.html()
      if(this.form.cid && this.form.cid.length > 0) {
        form.cid = this.form.cid[this.form.cid.length - 1]
      }
      if(form.sku.length > 0) {
        form.sku = JSON.stringify(form.sku)
      }
      this.save_loading = true
      if(form.id > 0) {
        editGoods({...form}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.save_loading = false
          // this.$router.replace('/goods/index')
          this.$router.go(-1)
        }).catch(error => {
          this.save_loading = false
        })
      } else {
        addGoods({...form}).then(response => {
          this.$message({
            message: response.msg,
            type: 'success'
          })
          this.save_loading = false
          // this.$router.replace('/goods/index')
          this.$router.go(-1)
        }).catch(error => {
          this.save_loading = false
        })
      }
    },
    handleThumbError(err, file, filelist) {
      console.log(err)
      if(file.status === 'fail' && typeof (err.message) !== undefined) {
        // this.uploadErrorMsg = JSON.parse(err.message).msg
        this.$message.error(JSON.parse(err.message).msg)
      }
    },
    handleThumbSuccess(res, file) {
      let last_char = this.VUE_APP_API_BASE_URL.charAt(this.VUE_APP_API_BASE_URL.length - 1)
      let base_url = this.VUE_APP_API_BASE_URL
      if (last_char == '/') {
        base_url = base_url.substr(0, base_url.length-1)
      }
      this.form.thumbnail = base_url + res.data.urlpath
      // this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeThumbUpload(file) {
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isLt2M;
    },
    returnToList() {
      // this.$router.replace('/goods/index')
      this.$router.go(-1)
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

.thumb-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.thumb-uploader .el-upload:hover {
  border-color: #409EFF;
}
.thumb-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.thumb {
  width: 178px;
  height: 178px;
  display: block;
}
.sku-item {
  margin-bottom: 10px;
}

.sku-item-input {
  float: left;
  width: 120px;
  margin-left: 10px;
  margin-right: 15px;
  margin-top: 15px;
  margin-bottom: 15px;
}
.sku-item-title {
  width: 350px;
}
.sku-item-input-label {
  float: left;
  margin-top: 15px;
  margin-bottom: 15px;
}
.attr-item {
  width: 160px;
  margin-right: 15px;
}
</style>
