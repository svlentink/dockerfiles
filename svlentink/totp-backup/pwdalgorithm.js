(function (glob) { // IIFE pattern
  'use strict'
  
  var Logger = function (path) {
    var pathStr = ''
    if (typeof path === 'object') { // e.g. ['SVL','chords','minor'] => 'SVL.chords.minor'
      for (var i = 0; i < path.length; i++) {
        if (typeof path[i] === 'string') pathStr += ((i === 0) ? '' : '.') + path[i]
        else console.log('Error in logger; path array contains non-string item.')
      }
    } else {
      if (typeof path === 'string') pathStr = path
      else console.log('No valid path provided, please provide, this is useful for debugging')
    }

    this.err = this.error
    this.getPath = function () { return pathStr }
  }
  Logger.prototype.trace = function (desc, obj) {
    logMsg(4, this.getPath(), desc, obj)
  }
  
  var PwdAlgo = function (rules, specialchars) {
    if (typeof rules !== 'object' || !rules.length) throw "Input should be an array"
    this.getRules = function () { return rules }
    if (specialchars) this.getSpecials = function () { return specialchars }
    else this.getSpecials = function () { return "!#$%&*@^" }
  }
  PwdAlgo.prototype.secretParser = function(str) {
    /*
    * If you have accounts.google.com
    * 'google' is your domain and 'com' your tld
    */
    return function (domain,tld) {
      
    }
  }
  
var testWebSite = 'facebook' // the website name we are going to use
function getCurrentWebsiteName () {
  if (!window) throw ""
  var fqdn = window.location.hostname.split('.')
  var apex = fqdn.slice(fqdn.length -2) // get last two, which is the apex
  var dom = apex[0]
  var tld = apex[1]
}
function isVowel (chr) {
  if (chr.length !== 1) throw new TypeError('We desire a char, not a string')
  return 'aeiou'.indexOf(chr) !== -1
}
function countVowels (str) {
  var count = 0;
  for (var i = 0; i < str.length; i++) count += isVowel(str[i])
  return count
}
function convertWebsiteName (name) {
  name = name || getCurrentWebsiteName()
  var l = name.length // letters
  var v = countVowels(name) // vowels
  var c = l-v // consonants
  return {
    letters : {
      count  : l,
      isEven : !(l%2),
      first : name[0],
      last : name[name.length-1]
    },
    vowels : {
      count  : v,
      isEven : !(v%2)
    },
    consonants : {
      count  : c,
      isEven : !(c%2)
    }
  }
}
convertWebsiteName(testWebSite)
}(typeof window !== 'undefined' ? window : global))
