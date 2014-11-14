fission = require './app'
adminView = require './pages/admin/admin.View'

router = fission.router

router.route '/',
  title: 'Admin'
  view:adminView
  el:'content'

router.start()