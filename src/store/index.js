import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: '',
    userId: '',
    userName: '',
    uImg: '',
    role:'',
  },
  mutations: {
    setRole(state, role){
      state.role = role
      localStorage.role = role
    },
    //存储token方法
    //设置token等于外部传递进来的值 
    setToken(state, token) {
      state.token = token
      localStorage.token = token //同步存储token至localStorage
    },
    //存储用户id
    setUserId(state, userId) {
      state.userId = userId
      localStorage.userId = userId
    },

    setUserName(state, userName){
      state.userName = userName
      localStorage.userName = userName
    },
    setUImg(state, uImg){
      state.uImg = uImg
      localStorage.uImg = uImg
    }
    
  },
  getters: {
    getRole(state){
      if (!state.role) {
        state.role = localStorage.getItem('role')
      }
      return state.role
    },
    //获取token方法
    //判断是否有token,如果没有重新赋值，返回给state的token
    getToken(state) {
      if (!state.token) {
        state.token = localStorage.getItem('token')
      }
      return state.token
    },
    getUserId(state) {
      if (!state.userId) {
        state.userId = localStorage.getItem('userId')
      }
      return state.userId
    },
    getUserName(state) {
      if (!state.userName) {
        state.userName = localStorage.getItem('userName')
      }
      return state.userName
    },
    getUImg(state) {
      if (!state.uImg) {
        state.uImg = localStorage.getItem('uImg')
      }
      return state.uImg
    }

  },
  actions: {
  },
  modules: {
  }
})
