###
# /v3/relation 下的接口(关系链类)
###

debuglog = require("debug")("wanba_tools::relations")
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
getAppFriends = (params, method, callback) ->
  options  = _makeReqOptions(@, RequestUrIs.GET_APP_FRIENDS_URI, method, params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

#验证是否平台好友
#  params:
#     charset   string  指定请求及响应的字符集，取值为gbk或utf-8（只有pf=qqgame或pf=3366时，可以输入该参数）。默认值为utf-8，其他非法取值也认为是utf-8。
#     fopenid 必须  string  待验证的好友QQ号码转化得到的ID。
#  return:
#     is_friend 是否为好友（0： 不是好友； >=1： 是好友）。当pf=qqgame或pf=3366时，表示是否为QQ好友。
#     is_gamefriend 是否为QQGame好友（0： 不是QQGame好友； >=1： 是QQGame好友）。（只有pf=qqgame时，返回此参数）
isFriend = (params, method, callback) ->
  options  = _makeReqOptions(@, RequestUrIs.IS_FRIEND_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    result =
      is_friend: body.is_friend>0
      is_gamefriend: body.is_gamefriend>0
    return callback null, result
  return

###############################################################################################################
# 以下接口可能是与其它（空间，朋友....）有关， 但与玩吧无关的，
###############################################################################################################

###
# 为用户推荐选择的好友
#   调用本接口前，请按照模版提交API接口权限申请（申请方式详见这里），以获取接口调用权限。
#   具体见：http://wiki.open.qq.com/wiki/v3/relation/get_rcmd_friends
#
# params:
#   installed 必须  string  标识需要获取的推荐好友是否已安装应用。
#     0：获取的均为未安装应用的好友；
#     1：获取的均为已安装应用的好友；
#     2：获取所有推荐好友，不区分是否安装应用。
#
# return：
#   items 获取的推荐好友信息。最多可获取50个推荐好友信息。
#   openid  好友对应的唯一ID。
###
getRcmdFriends = (params, method, callback) ->
  options  = _makeReqOptions(@, RequestUrIs.GET_RCMD_FRIENDS_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    result =
      items: body.items
      openid: body.openid
    return callback null, result
  return

module.exports =
  getAppFriends:getAppFriends
  isFriend: isFriend
  getRcmdFriends: getRcmdFriends

