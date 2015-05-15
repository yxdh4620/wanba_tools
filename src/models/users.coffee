###
# /v3/user下的接口
###

debuglog = require("debug")("wanba_tools::users")
request = require 'request'
RequestUrIs = require "../enums/request_uris"
helps = require "../utils/helps"

_makeReqOptions = (self, uri, method, params) ->
  params.appid = self.appid
  params.pf or= self.pf
  params.format or= self.format
  params.sig = self.makeSignature uri, method, params
  options =
    url: "#{self.host}#{uri}"
    json: true
    method: method
    body: params
  return options

_makeReqOptions = helps.makeReqOptions

###
# 获取玩家信息（QQ昵称、头像、性别）
# params:
#     openid  必须  string  与APP通信的用户key。从平台跳转到应用时会调用应用的CanvasURL，平台会在CanvasURL后带上本参数。由平台直接传给应用，应用原样传给平台即可。
#     openkey 必须  string  session key。
#     userip    string  用户的IP。
#
# 内部补充得参数：
#     appid 必须  unsigned int  应用的唯一ID。可以通过appid查找APP基本信息。
#     sig 必须  string  请求串的签名，以appkey作为密钥，具体签名算法见腾讯开放平台第三方应用签名参数sig的说明。
#     pf  必须  string  应用的来源平台。从平台跳转到应用时会调用应用的CanvasURL，平台会在CanvasURL后带上本参数。由平台直接传给应用，应用原样传给平台即可。
#     format    string  定义API返回的数据格式。取值说明：为xml时表示返回的格式是xml；为json时表示返回的格式是json。
#           注意：json、xml为小写，否则将不识别。format不传或非xml，则返回json格式数据。
# return json 根据应用平台的不同，返回的数据会不相同
###
getInfo = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_INFO_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 获取多个玩家信息（QQ昵称、头像、性别）, 只返回安装了应用玩家信息
# params:
#     openid  必须  string  与APP通信的用户key。从平台跳转到应用时会调用应用的CanvasURL，平台会在CanvasURL后带上本参数。由平台直接传给应用，应用原样传给平台即可。
#     openkey 必须  string  session key。
#     fopenids 必须 string 需要获取数据的openid列表，中间以_隔开，每次最多100个。
#     userip    string  用户的IP。
#
# 内部补充得参数：
#     appid 必须  unsigned int  应用的唯一ID。可以通过appid查找APP基本信息。
#     sig 必须  string  请求串的签名，以appkey作为密钥，具体签名算法见腾讯开放平台第三方应用签名参数sig的说明。
#     pf  必须  string  应用的来源平台。从平台跳转到应用时会调用应用的CanvasURL，平台会在CanvasURL后带上本参数。由平台直接传给应用，应用原样传给平台即可。
#     format    string  定义API返回的数据格式。取值说明：为xml时表示返回的格式是xml；为json时表示返回的格式是json。
#           注意：json、xml为小写，否则将不识别。format不传或非xml，则返回json格式数据。
# return {
#   "ret": 0
#   "is_lost": 0
#   "items"[
#     {玩家信息},{玩家信息}
#   ]
# }
###
getMultiInfo = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_MULTI_INFO_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 上传玩家在应用中得等级信息
# params 同getInfo
#   user_attr: json {level uint 必须， key1:uint, key2:uint}
# return {
#   "ret":0
#   "is_lost":0
# }
#
###
setAchievement = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.SET_ACHIEVEMENT_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return
###
# 拉取排行榜列表
# params 同getInfo
#   rankdim 否  int 拉取纬度，需与排行榜配置信息表中一致
#   rank_start  否  int 拉取排行的起始位置（默认0）
#   pull_cnt  否  int 拉取排行的个数（最小为3，最大为50，默认3）
#   direction 否  int 拉取排行的方向（-1往前拉取，0向后拉取，默认0）
###
getGamebarRanklist = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_GAMEBAR_RANKLIST_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 积分购买道具
# params 同getInfo
#   zoneid 是  int 区ID，用于区分用户是在哪一款平台下(Android、IOS等)?这个说明有歧义：怀疑应该是应用的分区（默认1）
#   itemid 是  string  道具ID
#   count  否  int 兑换道具数量
# return  见API http://wiki.open.qq.com/wiki/v3/user/buy_playzone_item
#   吐槽：奇葩的腾讯， API中得返回参数竟然和实际不一样？
###
buyPlayzoneItem = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.BUY_PLAYZONE_ITEM_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
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
getPlayzoneUserinfo = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_PLAYZONE_USERINFO_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 发送玩吧消息
# params 同getInfo
#   frd 是  string  好友openid
#   msgtype 是  int 消息类型，1-pk消息，2-送心消息，3-超越消息
#   content 是  string  超越消息的积分文字，形如“10秒”，“100分”之类
#   qua 是  string  手机空间版本标识，例如：V1_AND_QZ_4.9.3_148_RDM_T
###
sendGamebarMsg = (params, callback) ->
  options = _makeReqOptions(@, RequestUrIs.SEND_GAMEBAR_MSG, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

###
# 判断玩家是否登录平台, 可以用来openkey 续期（openkey 有效时间2个小时）
# callback 没有错误就表示玩家已登录
###
isLogin = (params, callback) ->
  options  = _makeReqOptions(@, RequestUrIs.IS_LOGIN_URI, "POST", params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    console.dir body
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

module.exports =
  getInfo: getInfo
  getMultiInfo: getMultiInfo
  setAchievement:setAchievement
  getGamebarRanklist:getGamebarRanklist
  buyPlayzoneItem: buyPlayzoneItem
  getPlayzoneUserinfo: getPlayzoneUserinfo
  sendGamebarMsg: sendGamebarMsg
  isLogin:isLogin



