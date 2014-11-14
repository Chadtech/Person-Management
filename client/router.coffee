fission = require './app'
adminView = require './pages/admin/admin.View'
accountView = require './pages/account/account.View'
missingPage = require './pages/missingPage/missingPage.View'

router = fission.router

router.route '/',
  title: 'Admin'
  view: adminView
  el: 'content'

#router.route '/:id',
#  title: 'ID'
#  view: accountView
#  el: 'content'

router.route '*',
  title: 'ERROR'
  view: missingPage
  el: 'content'

router.start()