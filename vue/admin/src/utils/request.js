import axios from "axios"
import store from "@/store"
import { Message } from 'element-ui'

const service = axios.create({
  baseURL: process.env.VUE_APP_API_BASE_URL,
  timeout: 120000, // request timeout
  headers: {
    'Content-Type':'application/x-www-form-urlencoded'
  }
})

service.interceptors.request.use(
  config => {
    if (store.getters.token) {
      config.headers['X-Token'] = store.getters.token
    }
    return config
  }
)

service.interceptors.response.use(
  response => {
    const res = response.data
    if (res.code !== 0) {
      Message({
        message: res.msg || 'Error',
        type: 'error',
        duration: 5 * 1000
      })

      return Promise.reject(new Error(res.msg || 'Error'))
    } else {
      return res
    }
  },
  error => {
    console.log('err' + error) // for debug
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service
