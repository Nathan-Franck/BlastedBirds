var coffeescript = require('coffee-script')
var compiled = coffeescript.compile(
    "\
foo = (sup) ->\n\
    return 'hi'\n\
\n\
\n\
for i in [0...10]\n\
    for j in [0...10]\n\
        console.log 'foo'\n\
        foo 'hio'\
    "
);
console.log(compiled);