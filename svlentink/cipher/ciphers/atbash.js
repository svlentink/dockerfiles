var fs = require('fs')
var file = '/input.txt'
 

function cipher(str){
  var alphabet = "abcdefghijklmnopqrstuvwxyz";
  var result = '';
  for (var i=0;i<str.length;i++)
    if ( alphabet.indexOf(str[i].toLowerCase()) !== -1)
      result += alphabet[25 - alphabet.indexOf(str[i].toLowerCase())]
    else
      result += str[i]
  return result
}
function decipher(str){
  return cipher(str)
}

fs.readFile(file, {encoding: 'utf-8'}, function(err,data){
  if (err) return console.log(err)
  if (data) console.log(cipher(data))
})



