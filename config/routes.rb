$routes = [
  {
    path: "/index",
    view: "views/pages/homepage",
  },
  {
    path: "/posts",
    view: "views/pages/posts",
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
    path: "/works",
    view: "views/pages/works",
  },
  {
    path: "/about",
    view: "views/pages/about",
  },
  {
    path: "/404",
    view: "views/errors/404",
    template: "error",
  },
  # /posts/2014-06-16-test
  {
    path: "/posts/",
    view: /posts\/.+/,
    template: "post"
  },
]