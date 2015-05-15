debuglog = require("debug")("wanba_tools")
assert = require "assert"
fs = require 'fs'
path = require 'path'

###
# 玩吧的工具类（SDK）
###
class WanbaTools

  constructor: (options) ->
    debuglog "LOG [wanba_tools::constructor] start"

    @appid = options.appid
    @appkey = options.appkey
    @host = options.host
    @pf = options.pf || 'wanba_ts'
    @format = options.format || "json"
    assert @appid, "missing wanba appid"
    assert @appkey, "missing wanba appkey"
    models_path = path.join __dirname, './models'
    fs.readdirSync(models_path).forEach (file)=>
      obj = require "#{models_path}/#{file}"
      for key, v of obj
        @[key] =v
      return
    return

  setPf: (pf) -> @pf = pf

  setFormat: (format) -> @format = format

module.exports = WanbaTools
