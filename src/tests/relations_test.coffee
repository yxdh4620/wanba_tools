
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

describe "test relation", ->
  before () ->

  describe "getAppFriends", ->
    it "should get app friends", (done) ->
      wbt.getAppFriends params, (err, result) ->
        console.error "ERROR:: #{err}" if err?
        console.dir result
        done()

