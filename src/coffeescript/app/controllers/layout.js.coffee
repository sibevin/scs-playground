angular.module("scsBlogApp").controller "LayoutCtrl", [
  '$scope', '$cookies', '$filter', 'TabSwitcher'
  ($scope,   $cookies,   $filter,   TabSwitcher) ->

    $scope.switchMenu = (tab, is_switch = true) ->
      if is_switch
        $scope.menu_ts.switch(tab)
      else
        $scope.menu_ts.setTab(tab)
      $cookies.menu_ts = $scope.menu_ts.getTab()

    $scope.switchFooter = (tab, is_switch = true) ->
      if is_switch
        $scope.footer_ts.switch(tab)
      else
        $scope.footer_ts.setTab(tab)
      $cookies.footer_ts = $scope.footer_ts.getTab()
      $scope.query_keywords = ""

    initVars = ->
      $scope.menu_ts = new TabSwitcher("paper")
      $scope.footer_ts = new TabSwitcher("close")
      $scope.display_mode_ts = new TabSwitcher("web")

      stored_menu_ts = $cookies.menu_ts
      if stored_menu_ts != undefined
        $scope.menu_ts.setTab(stored_menu_ts)

      stored_footer_ts = $cookies.footer_ts
      if stored_footer_ts!= undefined
        $scope.footer_ts.setTab(stored_footer_ts)

    init = ->
      initVars()

    init()
]
