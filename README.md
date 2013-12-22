scs-playground
==============

# SCS (Slim, Coffeescript and SASS) playground

## Why?

1. I need a place to test SCS saytax.
2. It's annoying to build SCS files each time once they are modified.

## What?

SCS playground is a simple framework with guard which can build the slim/coffeescript/sass files to html/javascript/css files automatically when you modify them.

## How?

### Install

1. Prepare ruby.
2. Prepare your JavaScript runtime, such as node.js.
3. Run "bundle install".

### Play

1. Run "guard".
2. Write your slim, coffeescript and sass files in src folder.
3. Guard would build the html, javascript and css files in app folder automatically.

## Folders

├── app
│   ├── css -- where to generate the css files
│   │   └── app.css
│   ├── html -- where to generate the html files
│   │   └── index.html
│   ├── images
│   └── js -- where to generate the javascript files
│       └── app.js
├── config
│   └── compass.rb
├── Gemfile
├── Gemfile.lock
├── Guardfile
├── LICENSE
├── README.md
└── src
    ├── coffeescript
    │   └── app
    │       └── js -- where to put the coffeescript files
    │           └── app.js.coffee
    ├── sass -- where to put sass files
    │   └── app.css.sass
    └── slim -- where to put slim files
        └── index.html.slim

## Authors

Sibevin Wang

## Copyright

Copyright (c) 2013 Sibevin Wang. Released under the MIT license.
