
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
        fopenid: params.openid
      wbt.isFriend options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "getAppFriends", ->
    options =
      openid: params.openid
      openkey: params.openkey
      fopenid: params.openid
    it "should get app friends", (done) ->
      wbt.getAppFriends options, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

