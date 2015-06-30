###
# 推广类接口
###

debuglog = require("debug")("wanba_tools::generalizes")
request = require 'request'
RequestUrIs = require "../enums/request_uris"
helps = require "../utils/helps"

_makeReqOptions = helps.makeReqOptions


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
setAchievement = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.SET_ACHIEVEMENT_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 查询用户在应用中的等级相关信息
# params:
#   fopenids  必须  string  需要获取等级的用户对应的openid列表，多个openid之间用“_”分隔，每次最多可传入50个openid。
#   area_name 可选  string  用户所在的分区的名称，对于多区多服应用，可传入该参数获取指定分区中用户的等级：
#   如果传入area_name，即可获取指定分区里的用户的等级；
#   如果不传area_name或者area_name为空，则获取默认的area_name的用户等级。
###
getAchievement = (params, method="POST", callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_ACHIEVEMENT_URI, method, params)
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
getGamebarRanklist = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_GAMEBAR_RANKLIST_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

###
# 验证好友邀请的invkey
# params
#   invkey: 加密串 （canvasURL返回参数）
#   itime: 邀请时间（canvasURL返回参数）
#   iopenid: 发起邀请者的openid （canvasURL返回参数）
# return boolean is_right(true, false)
###
verifyInvkey = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.VERIFY_INVKEY_URI, method, params)
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    isRight = false
    isRight = true if body.is_right == 1
    return callback null, isRight
  return


module.exports =
  setAchievement:setAchievement
  getAchievement:getAchievement
  getGamebarRanklist:getGamebarRanklist
  verifyInvkey: verifyInvkey


