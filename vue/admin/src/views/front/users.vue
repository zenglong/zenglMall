<template>
  <div>
    <user-list v-if="action == 'showList'"></user-list>
    <user-info v-else-if="action == 'showInfo'" :id="id"></user-info>
  </div>
</template>

<script>
import userList from './userList'
import userInfo from './userInfo'

export default {
  components: {
    userList,
    userInfo
  },
  data() {
    return {
      id: 0,
      action: '',
    }
  },
  mounted() {
    this.action = 'showList'
  },
  methods: {
    showUserInfo(id) {
      this.id = id
      this.action = "showInfo"
    },
    showUserList() {
      this.action = "showList"
    }
  }
}
</script>