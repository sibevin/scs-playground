blog_app = angular.module('scsBlogApp', ['tau-utils', 'ngCookies', 'focus-if'])

angular.element(document).ready ->
  angular.bootstrap(document, ['scsBlogApp'])