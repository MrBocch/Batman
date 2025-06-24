#!/usr/bin/env zsh

# uncomment what you want
# elm make src/Main.elm --output=static/main.js --debug
elm make src/Main.elm --output=static/main.js --optimize

# Minify the output with UglifyJS
# i should pay more attention to the code by the creator of elm
# rather than chatgpt
# https://github.com/elm/compiler/blob/9d97114702bf6846cab622a2203f60c2d4ebedf2/hints/optimize.md

pnpx uglify-js static/main.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | pnpx uglify-js --mangle --output static/main.min.js
