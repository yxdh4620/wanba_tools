
should = require "should"
_ = require 'underscore'
config = require('../config/config')

WanbaTools = require "../wanba_tools"

options = config

wbt = new WanbaTools(options)
console.dir wbt

params =
  openid: "11111111111111111"
  openkey: "2222222222222222"

describe "test users", ->
  before () ->

  describe "getInfo", ->
    it "should get info", (done) ->
      wbt.getInfo  params, (err, info) ->
        console.error "ERROR:: #{err}" if err?
        console.dir info
        done()

  describe "getMultiInfo", ->
    it "should get multi info", (done) ->
      params.fopenids = "#{params.openid}_#{params.openid}"
      wbt.getMultiInfo params, (err, info) ->
        console.error "ERROR:: #{err}" if err?
        console.dir info
        delete params.fopenids
        done()

  describe "setAchievement", ->
    it "should set achievement", (done) ->
      params.user_attr =
        level:1
        key1:2292992
      wbt.setAchievement params, (err) ->
        console.error "ERROR:: #{err}" if err?
        delete params.user_attr
        done()

  describe "getGamebarRanklist", ->
    it "should get gamebar ranklist", (done) ->
      params.rankdim = "key1"
      params.rank_start = 0
      params.pull_cnt = 50
      params.direction = 0
      wbt.getGamebarRanklist params, (err, ranklist) ->
        console.error "ERROR:: #{err}" if err?
        console.dir ranklist
        delete params.rankdim
        delete params.rank_start
        delete params.pull_cnt
        delete params.direction
        done()

  describe "buyPlayzoneItem", ->
    it "should buy playzone itemt", (done) ->
      params.zoneid = 1
      params.itemid = 'fiash_001'
      params.count = 2
      wbt.buyPlayzoneItem params, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        delete params.zoneid
        delete params.itemid
        delete params.count
        done()

  describe "getPlayzoneUserinfo", ->
    it "should get playzone userinfo", (done) ->
      params.zoneid = 1
      wbt.getPlayzoneUserinfo params, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        delete params.zoneid
        done()

  describe "sendGamebarMsg", ->
    it "should send gamebar msg", (done) ->
      params.frd = "222222222222"
      params.msgtype = "1"
      params.content = "100分"
      params.qua = "V1_AND_QZ_4.9.3_148_RDM_T"
      wbt.sendGamebarMsg params, (err) ->
        console.error "ERROR:: #{err}" if err?
        delete params.frd
        delete params.msgtype
        delete params.content
        delete params.qua
        done()

  describe "isLogin", ->
    it "should is login", (done) ->
      wbt.isLogin params, (err) ->
        console.error "ERROR:: #{err}" if err?
        done()


