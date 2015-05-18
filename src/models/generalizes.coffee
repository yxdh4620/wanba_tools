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
getGamebarRanklist = (params, method='POST', callback) ->
  options = _makeReqOptions(@, RequestUrIs.GET_GAMEBAR_RANKLIST_URI, method, params)
  console.dir options
  request options, (err, res, body) ->
    return callback err if err?
    return callback new Error("errCode: #{body.ret} message: #{body.msg}") if body.ret? and body.ret != 0
    return callback null, body
  return

module.exports =
  setAchievement:setAchievement
  getGamebarRanklist:getGamebarRanklist
