import Cookies from "js-cookie"
import router, { resetRouter } from '@/router'
import { login, getInfo, logout } from '@/api/user'
import Layout from '@/layout'

const MyTokenKey = 'my_vue_index_token'

export function getToken() {
  return Cookies.get(MyTokenKey)
}

export function removeToken() {
  return Cookies.remove(MyTokenKey)
}

export function setToken(token) {
  return Cookies.set(MyTokenKey, token)
}

let getinfo_data = null

const state = {
  token: getToken(),
  avatar: '',
  name: '',
  routes: [],
}

const mutations = {
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_ROUTES: (state, routes) => {
    state.routes = routes
  }
}

const actions = {
  // 用户登录
  login({commit}, userInfo) {
    console.log(userInfo)
    const { username, password } = userInfo

    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password, submit: 'yes' }).then(response => {
        if(response.data.token) {
          commit('SET_TOKEN', response.data.token)
          setToken(response.data.token)
        }
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      if(getinfo_data === null) {
        getInfo(state.token).then(response => {
          const { data } = response

          if (!data) {
            reject('校验失败，请重新登录.')
          }

          const { routes, name, avatar } = data
          getinfo_data = data

          // roles must be a non-empty array
          if (!routes || routes.length <= 0) {
            commit('SET_TOKEN', '')
            commit('SET_ROUTES', [])
            removeToken()
            reject('用户还没有分配任何权限!')
          }

          // commit('SET_ROUTES', routes)
          commit('SET_NAME', name)
          commit('SET_AVATAR', avatar)
          resolve(data)
        }).catch(error => {
          reject(error)
        })
      } else {
        resolve(getinfo_data)
      }
    })
  },

  setRoutes({commit, state}, newroutes) {
    return new Promise((resolve, reject) => {
      commit('SET_ROUTES', newroutes)
      resolve()
    })
  },

  resetToken({ commit }) {
    return new Promise(resolve => {
      commit('SET_TOKEN', '')
      commit('SET_ROUTES', [])
      removeToken()
      resolve()
    })
  },

  // user logout
  logout({ commit, state, dispatch }) {
    return new Promise((resolve, reject) => {
      logout().then(response => {
        commit('SET_TOKEN', '')
        commit('SET_ROUTES', [])
        removeToken()
        resetRouter()

        // reset visited views and cached views
        // to fixed https://github.com/PanJiaChen/vue-element-admin/issues/2485
        dispatch('tagsView/delAllViews', null, { root: true })

        resolve(response)
      }).catch(error => {
        reject(error)
      })
    })
  },
}

export function setUserGetInfoData(val = null)
{
  getinfo_data = val
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
