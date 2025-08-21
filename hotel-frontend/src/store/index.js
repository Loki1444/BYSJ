import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: JSON.parse(sessionStorage.getItem('user')) || null,
    token: sessionStorage.getItem('token') || null
  },
  mutations: {
    SET_USER (state, user) {
      state.user = user
      sessionStorage.setItem('user', JSON.stringify(user))
    },
    SET_TOKEN (state, token) {
      state.token = token
      sessionStorage.setItem('token', token)
    },
    CLEAR_AUTH (state) {
      state.user = null
      state.token = null
      sessionStorage.removeItem('user')
      sessionStorage.removeItem('token')
    }
  },
  actions: {
    login ({ commit }, { user, token }) {
      commit('SET_USER', user)
      commit('SET_TOKEN', token)
    },
    logout ({ commit }) {
      commit('CLEAR_AUTH')
    }
  },
  getters: {
    isAuthenticated: state => !!state.token,
    currentUser: state => state.user
  }
})
