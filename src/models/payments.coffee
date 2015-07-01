###
# 支付相关的接口
###

debuglog = require("debug")("wanba_tools::users")
request = require 'request'
RequestUrIs = require "../enums/request_uris"
helps = require "../utils/helps"

_makeReqOptions = helps.makeReqOptions

###
# 积分购买道具
# params 同getInfo
#   zoneid 是  int 区ID，用于区分用户是在哪一款平台下(Android、IOS等)?这个说明有歧义：怀疑应该是应用的分区（默认1）
#   itemid 是  string  道具ID
#   count  否  int 兑换道具数量
# return  见API http://wiki.open.qq.com/wiki/v3/user/buy_playzone_item
#   吐槽：奇葩的腾讯， API中得返回参数竟然和实际不一样？
###
buyPlayzoneItem = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.BUY_PLAYZONE_ITEM_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    #return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 查询达人信息
# params 同getInfo
#   zoneid 是  int 区ID，用于区分用户是在哪一款平台下(Android、IOS等)?这个说明有歧义：怀疑应该是应用的分区（默认1）
#
# return 见API http://wiki.open.qq.com/wiki/v3/user/get_playzone_userinfo#3_.E7.A4.BA.E4.BE.8B.E4.BB.A3.E7.A0.81
#
###
getPlayzoneUserinfo = (params, method='POST',  callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_PLAYZONE_USERINFO_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.code} message: #{body.message}") if body.code? and body.code != 0
    console.dir body
    return callback new Error("message: missing userinfo") unless body.data[0]
    return callback null, body.data[0]
  return

module.exports =
  buyPlayzoneItem: buyPlayzoneItem
  getPlayzoneUserinfo: getPlayzoneUserinfo


