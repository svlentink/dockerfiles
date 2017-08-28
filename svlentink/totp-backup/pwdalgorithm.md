# Password Algorithm

TODO, in progress, just skip this.

## Structure

This concept consists of three
## Passphrase

The password algorithm uses a passphrase as input.
You should change this passphrase at least once a year.

```javascript
var p = "My v3ry lo0ong passphrase."
```

You could use a separate `p` for different subsets of logins.
E.g. one for work, one for social media, one for banking etc.

## Variables

```javascript
// environment specific
var d = destination //e.g. 'yourmail.co.uk', 'someblog.com', 'macbook'
// changable, needed for login but avoid using in alogrithm
var u = userlogin //e.g. 'myeamil@as.login', 'someusername'
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

## FAQ

### Why a passphrase, couldn't we just include it as a variable in an algorithm.

Spot on! This assumtion is correct.
Techniqually this is the right way to go, reducing complexity.
However, we want to store the algorithms in non-volatile storage,
since the entering/remembering the algorithms is less simple.

### How to store your secrets

It advisable to store it physically
(the algorithms printed and the passphrases written down).

One example of storage a passphrase in disguise,
is by using acronyms or reference structure.

An example: "NIV 1John4:18:13:16"
refers to "fear has to do with punishment. The one who fears is not made perfect in love.",
by using "NIV"=version, "1John"=book, "4"=chapter,
"18"=verse,"13"=index of first word, "16"=amount of words.
