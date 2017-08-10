/*
You may ask, what does this code do?
My children cannot have candy/cookies (healty lifestyle)
they can have some if they manage to change our sheet which keeps track
of the amount we have left (call it inventory).
I started with a txt, xls, html table
and also did base64 etc., just to expose them to computer science early on.
*/
function fck (inpstr, nr) {
  if (nr === 0) return inpstr
  if (typeof inpstr !== 'string') inpstr = JSON.stringify(inpstr)
  var enc = encodeURIComponent(inpstr)
  var arr = enc.split('')
  var str = arr.toString()
  return fck(str,nr-1)
}
function unfck (inpstr, nr) {
  if (nr == 0) return inpstr
  var arr = inpstr.split(',')
  var str = arr.join('')
  var enc = decodeURIComponent(str)
  return unfck(enc,nr-1)
}
//datastr = {a:1}
mess = fck(datastr,3)
console.log(mess)
good = unfck(mess,3)
console.log(good)
