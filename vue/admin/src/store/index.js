import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import user from './module/user'
import app from './module/app'
import settings from './module/settings'
import tagsView from './module/tagsView'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    user,
    app,
    settings,
    tagsView
  },
  getters
})

export default store
