$routes = [
  {
    path: "/index",
    view: "views/pages/homepage",
  },
  {
    path: "/tags",
    view: "views/pages/tags",
  },
  {
    path: "/categories",
    view: "views/pages/categories",
  },
  {
    path: "/404",
    view: "views/errors/404",
    template: "error",
  },
  # /post/2014-06-16-test
=begin
  {
    path: /^\/posts\/.+/,
    view: /views\/posts\/.+/,
    template: "post"
  },
=end
]