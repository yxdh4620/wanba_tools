
should = require "should"
_ = require 'underscore'
#config = require('../config/config')
config = require "../config/test_config"
WanbaTools = require "../wanba_tools"

wbtOptions= config

params =
  openid: config.openid
  openkey: config.openkey

wbt = new WanbaTools(wbtOptions)
console.dir wbt

method = "POST"

describe "test relation", ->
  before () ->

  describe "getAppFriends", ->
    it "should get app friends", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
      wbt.getAppFriends options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "isFriend", ->
    it "should is friends", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        fopenid: "4831900A609894979F91ADCB5483D71F"
      wbt.isFriend options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "getRcmdFriends", ->
    options =
      pf: "qzone"
      openid: params.openid
      openkey: params.openkey
      installed:2
    it "should get rcmd friends", (done) ->
      wbt.getRcmdFriends options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

