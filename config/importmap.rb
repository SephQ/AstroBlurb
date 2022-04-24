# Pin npm packages by running ./bin/importmap

pin "application", preload: true

# https://dev.to/coorasse/rails-7-bootstrap-5-and-importmaps-without-nodejs-4g8
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true