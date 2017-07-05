(function (glob) { // IIFE pattern
  'use strict'
  console.log('Starting TOTP-backup')
  
  var TOTP = {data:{}}
  var file = process.env.SECRETSFILE
  
  var qrcode = require('qrcode-terminal');
  var prompt = require('prompt');
  var fs = require('fs')
  
  fs.readFile(file, {encoding: 'utf-8'}, function(err,data){
    if (err) return console.log(err)
    if (data) TOTP.data = JSON.parse(data.toString())
  })
  
  function printCode(name) {
    var secret = TOTP.data[name]
    if (!secret) return console.log('invalid key')
    var method = 'totp'
    var uri = 'otpauth://' + method + '/' + name + '?secret=' + secret
    console.log('QRcode for', name)
    qrcode.generate(uri)
  }
  function saveToDisk() {
    fs.writeFile(file, JSON.stringify(TOTP.data), 'utf8', () => {})
    console.log('writen to disk',file)
  }
  TOTP.save = function() {
    prompt.get(['name', 'secret'], function (err, result) {
      var n = result.name
      var s = result.secret
      if (n && s) {
        TOTP.data[n] = s
        saveToDisk()
        printCode(n)
      } else console.log('Invalid input')
      chooseAction()
    })
  }
  TOTP.get = function() {
    prompt.get('name', function(err, result) {
      var n = result.name
      printCode(n)
      chooseAction()
    })
  }
  TOTP.rm = function() {
    prompt.get(['name'], function(err,result){
      var n = result.name
      console.log('Deleted',n,TOTP.data[n])
      delete TOTP.data[n]
      saveToDisk()
      chooseAction()
    })
  }
  TOTP.list = function() {
    console.log(TOTP.data)
    chooseAction()
  }
  TOTP.exit = function() {
    console.log('Exiting', TOTP.data)
  }
  function chooseAction() {
    var options = ['list','save','rm','get','exit']
    console.log('What do you want to do?',options)
    prompt.get(['action'],function (err, result){
      if (err) return console.log(err)
      var a = result.action
      if (options.indexOf(a) !== -1) TOTP[a]()
      else {
        console.log('invalid option')
        chooseAction()
      }
    })
  }
  
  chooseAction()
  
}(typeof window !== 'undefined' ? window : global))