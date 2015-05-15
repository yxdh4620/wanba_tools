###
# /v3/relation 下的接口(关系链类)
###

debuglog = require("debug")("wanba_tools::users")
request = require 'request'
RequestUrIs = require "../enums/request_uris"
helps = require "../utils/helps"

_makeReqOptions = helps.makeReqOptions

###
# 获取已安装应用的好友列表
# return
# {
# "ret":0,
# "is_lost":0,
# "items":[
# {"openid":"9CE729C9927532BABBB57F6AB000925B"},
# {"openid":"08B8273CACFBE0D9F57CAB4E7D8BDBF0"}
# ]
# }
###
getAppFriends = (params, callback) ->
  options  = _makeReqOptions(@, RequestUrIs.GET_APP_FRIENDS_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

#isFriend = ()

module.exports =
  getAppFriends:getAppFriends


