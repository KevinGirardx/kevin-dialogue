import { createApp } from 'vue'
import App from './App.vue'
import './global.css'

const myApp = createApp(App)

// Assumes you have a <div id='app'></div> in your index.html
myApp.mount('#app')

