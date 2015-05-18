
should = require "should"
_ = require 'underscore'
config = require('../config/config')

WanbaTools = require "../wanba_tools"

options = config

params =
  openid: "11111111111111111"
  openkey: "2222222222222222"

wbt = new WanbaTools(options)
console.dir wbt

method = "POST"

describe "test relation", ->
  before () ->

  describe "getAppFriends", ->
    it "should get app friends", (done) ->
      wbt.getAppFriends params, method, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

  describe "isFriend", ->
    it "should is friends", (done) ->
      options =
        openid: params.openid
        openkey: params.openkey
        fopenid: params.openid
      wbt.isFriend params, method, (err, result) ->
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

