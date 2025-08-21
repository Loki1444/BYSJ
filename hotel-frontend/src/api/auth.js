import axios from 'axios'

export default {
  // 登录
  login (data) {
    return axios.post('/auth/login', data)
  },

  // 获取用户信息
  getUserInfo () {
    return axios.get('/auth/info')
  },

  // 退出登录
  logout () {
    return axios.post('/auth/logout')
  }
}
