angular.module("scsBlogApp").controller "LayoutCtrl", [
  '$scope', '$filter', 'TabSwitcher'
  ($scope,   $filter,   TabSwitcher) ->
    initVars = ->
      $scope.menu_ts = new TabSwitcher("paper")
      $scope.footer_ts = new TabSwitcher("close")
      $scope.display_mode_ts = new TabSwitcher("web")

    init = ->
      initVars()

    init()
]
