
should = require "should"
_ = require 'underscore'
#config = require('../config/config')
config = require "../config/test_config"
WanbaTools = require "../wanba_tools"

wbtOptions = config

wbt = new WanbaTools(wbtOptions)
console.dir wbt

params =
  openid: config.openid
  openkey: config.openkey

#在params 错误时， POST告知哪个参数错误，但GET方式没有告诉是哪个参数错误
#  所以请尽可能使用POST方式，另外GET方式时有些请求参数的长度可能会超过2048
method = 'POST'

describe "test users", ->
  before () ->

  describe "getInfo", ->
    it "should get info", (done) ->
      options =
        "openid": "#{params.openid}"
        "openkey": "#{params.openkey}"
      wbt.getInfo  options, method, (err, info) ->
        console.error "ERROR:: #{err}" if err?
        console.dir info
        done()

  describe "getMultiInfo", ->
    it "should get multi info", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        fopenids : "4831900A609894979F91ADCB5483D71F_5E9E03D7B42C82242643EFC27D28DC82"
      wbt.getMultiInfo options, method, (err, info) ->
        console.error "ERROR:: #{err}" if err?
        console.dir info
        done()

  describe "sendGamebarMsg", ->
    it "should send gamebar msg", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        frd :"222222222222"
        msgtype : "1"
        content : "100分"
        qua : "V1_AND_QZ_4.9.3_148_RDM_T"
      wbt.sendGamebarMsg options, method, (err) ->
        console.error "ERROR:: #{err}" if err?
        done()

  describe "isLogin", ->
    it "should is login", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
      wbt.isLogin options, method, (err) ->
        console.error "ERROR:: #{err}" if err?
        done()

# =======================================================================================

  describe "totalVipInfo", ->
    it "should total vip info", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        member_vip: 1
        blue_vip:1
        yellow_vip:1
        red_vip:1
        green_vip:1
        pink_vip:1
        superqq:1
        is_3366:1
      wbt.totalVipInfo options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "isVip", ->
    it "should is vip", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey


      wbt.isVip options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "friendsVipInfo", ->
    it "should friends vip info", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        fopenids:params.openid
      wbt.friendsVipInfo options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "isSetup", ->
    it "should is setup", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey

      wbt.isSetup options, method, (err, isSetuped) ->
        console.error "ERROR:: #{err}" if err?
        console.log isSetuped
        done()

  describe "getAppFlag", ->
    it "should get app flag", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
      wbt.getAppFlag options, method, (err, customflag) ->
        console.error "ERROR:: #{err}" if err?
        console.log "customflag: #{customflag}"
        done()

  describe "delAppFlag", ->
    it "should del app flag", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        acttype: 1
        usergroupid: 2323
      wbt.delAppFlag options, method, (err) ->
        console.error "ERROR:: #{err}" if err?
        done()

  describe "isAreaLogin", ->
    it "should is area login", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        seqid: "afdasfadsfasd"
      wbt.isAreaLogin options, method, (err) ->
        console.error "ERROR:: #{err}" if err?
        done()


