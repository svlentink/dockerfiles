# Password Algorithm

TODO, in progress, just skip this.

## Variables

```javascript
var d = destination //e.g. 'yourmail.co.uk', 'someblog.com', 'macbook'
var u = userid //e.g. 'myeamil@as.login', 'someusername'
var 
```

## Function

```javascript
lc(inp,x) // last x char of input, default x=1 (recursive function, third param is pointer)
fc(inp,x) // first x char of input
up(inp) // uppercase
lo(inp) // lowercase
rb(inp,{x:y}) // replace all x by y, default {e:3,s:5,l:7,o:0,a:'@'}
tr(inp,x) // truncate, default x=16
cv(inp) // count vowels
ie(inp) // is even, counts if the length of the string is even, returns 1 or 0
'somestring'.length // length is a build in javascript function

```

## Example usage
```javascript
// provided by environment
var d = 'somedomain.tld'

// example password generation part
var fixedstr = '3@T' //fixed string (eat; a number, special char and uppercase)
var pwd = lc(d,cv(d)) + '_' + fixedstr + d.length
```

## Links

+ http://masterpasswordapp.com/algorithm.html
+ http://www.acleandesign.com/2008/05/password-algorithms-create-and-remember-unique-passwords-for-every-account/
+ https://security.stackexchange.com/questions/53507/what-is-a-good-algorithm-for-memorizing-a-password-in-a-few-minutes
+ https://www.dailyblogtips.com/develop-an-algorithm-for-your-online-passwords-and-never-forget-one-again/
+ https://security.stackexchange.com/questions/6095/xkcd-936-short-complex-password-or-long-dictionary-passphrase
+ https://stackoverflow.com/questions/98768/should-i-impose-a-maximum-length-on-passwords


