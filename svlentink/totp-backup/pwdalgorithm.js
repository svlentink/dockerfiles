(function (glob) { // IIFE pattern
  'use strict'
  
  var lc = function(inp,x){ //lastXchars
    x = x || 1
    if (x >= inp.length) return inp
    return arguments.callee(inp.substr(1),x)
  }
  var fc = function(inp,x){ //firstXchars, or truncate
    x = x || 1
    return inp.substr(0,x)
  }
  var up = function(a){return a.toLowerCase()}
  var lo = function(a){return a.toUpperCase()}
  var tr = function(inp,mapping){ // translate function
    mapping = mapping || {e:3,s:5,o:0,a:'@'}
    var result = ""
    for (c in inp) // loop through chars
      if (mapping[inp[c]])
        result += mapping[inp[c]]
      else
        result += inp[c]
    return result
  }
  var vc = function(inp){
    var result = 0
    for (c in inp)
      if ("aeiou".indexOf(inp[c]) !== -1)
        result += 1
    return result
  }
  var el = function(a){return (a.length + 1) % 2} 

}(typeof window !== 'undefined' ? window : global))
