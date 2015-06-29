###
# /v3/user下的接口
###

debuglog = require("debug")("wanba_tools::users")
request = require 'request'
RequestUrIs = require "../enums/request_uris"
helps = require "../utils/helps"

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
getInfo = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_INFO_URI, method, params)
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
getMultiInfo = (params, method='POST',  callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_MULTI_INFO_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
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
sendGamebarMsg = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.SEND_GAMEBAR_MSG, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

###
# 判断玩家是否登录平台, 可以用来openkey 续期（openkey 有效时间2个小时）
# callback 没有错误就表示玩家已登录
###
isLogin = (params, method='POST', callback) ->
  options  = _makeReqOptions(@, RequestUrIs.IS_LOGIN_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return


###############################################################################################################
# 以下接口可能是与其它（空间，朋友....）有关， 但与玩吧无关的，
###############################################################################################################

#获取登录用户各类增值服务信息
# member_vip   string  是否查询QQ会员信息，1为查询，0或者不写为不查询。
# blue_vip   string  是否查询蓝钻信息，1为查询，0或者不写为不查询。
# yellow_vip   string  是否查询黄钻信息，1为查询，0或者不写为不查询。
# red_vip    string  是否查询红钻信息，1为查询，0或者不写为不查询。
# green_vip    string  是否查询绿钻信息，1为查询，0或者不写为不查询。
# pink_vip   string  是否查询粉钻信息，1为查询，0或者不写为不查询。
# superqq    string  是否查询超级qq信息，1为查询，0或者不写为不查询。
# is_3366    string  是否查询3366信息，1为查询，0或者不写为不查询。
#
# 如果不传私有参数，或传入的私有参数的值都为“0”，只返回蓝钻和黄钻的相关信息。
totalVipInfo = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.TOTAL_VIP_INFO_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

# 用户是否黄钻
isVip = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.IS_VIP_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

# 查询用户好友是否开通vip
#     fopenids 必须 string 需要获取数据的openid列表，中间以_隔开，每次最多100个。
friendsVipInfo = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.FRIENDS_VIP_INFO_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

#用户是否安装了应用
isSetup = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.IS_SETUP_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    isSetuped = if body.setuped == 1 then true else false
    return callback null, isSetuped
  return


#用户在应用中的用户标识
getAppFlag = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_APP_FLAG_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body.customflag
  return

#清除用户在应用中的用户标识（例如领取奖励后）
#  用户标识customflag是一个4字节的数字，其含义如下：
#  d0~d7：用户在应用中所属的用户群ID，1表示濒临沉默用户，2表示沉默用户。
#  d29：高潜付费用户标志，1表示该用户是高潜付费用户，0表示该用户不是高潜付费用户。
#  另外，customflag是四字节无符号数字，使用时应当做unsigned int来解析，如果开发语言（如java）中没有unsigned int类型，请使用long类型来解析，否则可能会出现溢出情况。
#  例如：customflag=2684354562，二进制bit位d31~d0依次为 10100000 00000000 00000000 00000010，其d0~d7位为00000010，即该用户的群用户ID为2，是沉默用户；其d29位为1，所以也是高潜付费用户。
#  具体见：
#     http://wiki.open.qq.com/wiki/v3/user/del_app_flag
#
#  params:
#     acttype  是  unsigned int  指定操作类型。
#       1：清除用户customflag中的用户群ID信息。
#       3：清除用户高潜付费标识位。
#     usergroupid 否  unsigned int  用户群ID，当acttype=1时需传入。
#       请通过v3/user/get_app_flag查询用户标识customflag中的用户群ID。
delAppFlag = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.DEL_APP_FLAG_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return

#验证用户是否从选区界面进入多区多服应用
#   具体见：http://wiki.open.qq.com/wiki/v3/user/is_area_login
#   params:
#     seqid 必须  string  标识单次多区多服登录的特征码，通过该seqid可找到用户登录的唯一记录。由平台直接传给应用，应用原样传给平台即可。
#     用户点击某一大区服务器登录后，服务器端会验证用户登录态，登记登录请求信息，并产生seqid，然后跳转到应用服务器，在跳转URL中带有seqid以及openid，openkey参数，见接口说明中流程图。
isAreaLogin = (params, method, callback) ->
  options = _makeReqOptions(@, RequestUrIs.IS_AREA_LOGIN_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null
  return


module.exports =
  getInfo: getInfo
  getMultiInfo: getMultiInfo
  sendGamebarMsg: sendGamebarMsg
  isLogin:isLogin

  totalVipInfo:totalVipInfo
  isVip: isVip
  friendsVipInfo: friendsVipInfo
  isSetup: isSetup
  getAppFlag: getAppFlag
  delAppFlag: delAppFlag
  isAreaLogin: isAreaLogin


