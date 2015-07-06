blog_app = angular.module('scsBlogApp', ['tau-utils'])

angular.element(document).ready ->
  angular.bootstrap(document, ['scsBlogApp'])