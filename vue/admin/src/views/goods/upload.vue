<template>
  <div>
    <el-upload
      class="thumb-uploader"
      :action="upload_action"
      name="thumbnail_up"
      :show-file-list="false"
      :on-success="handleThumbSuccess"
      :on-error = "handleThumbError"
      :before-upload="beforeThumbUpload">
      <img v-if="thumbnail" :src="getImagePath(thumbnail)" class="thumb">
      <i v-else class="el-icon-plus thumb-uploader-icon"></i>
    </el-upload>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import { getImagePath } from '@/assets/js/common'

export default {
  props: {
    prop_thumbnail: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      VUE_APP_API_BASE_URL: '',
      upload_action: '',
      thumbnail: '',
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
    if(this.prop_thumbnail) {
      this.thumbnail = this.prop_thumbnail
    }
  },
  methods: {
    getImagePath(image) {
      return getImagePath(image)
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
      this.thumbnail = base_url + res.data.urlpath
      this.$emit('set_thumbnail', this.thumbnail)
    },
    beforeThumbUpload(file) {
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isLt2M;
    },
  }
}
</script>

<style lang="scss" scoped>
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
</style>
