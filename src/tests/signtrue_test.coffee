
should = require "should"
_ = require 'underscore'
config = require('../config/config')

WanbaTools = require "../wanba_tools"

options =
  appid : config.appid
  appkey: config.appkey

testSign = "FdJkiDYwMj5Aj1UG2RUPc83iokk="
url = '/v3/user/get_info'
method = "GET"
params =
  openid: "11111111111111111"
  openkey: "2222222222222222"
  appid:config.appid
  pf:"qzone"
  format:"json"
  userip:"112.90.139.30"

wbt = new WanbaTools(options)
console.dir wbt

describe "test signature", ->
  before () ->

  describe "makeSignature", ->
    it "should make signature", (done) ->
      sign = wbt.makeSignature url, method, params
      console.log "sign: #{sign}"
      console.log sign==testSign
      done()

