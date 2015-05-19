###
# 玩吧的sign参数生成和验证
###
debuglog = require("debug")("utils::signature")
crypto = require 'crypto'
request = require 'request'
_ = require 'underscore'
helps = require "../utils/helps"

###
# 生成签名
# params:
#   url: 访问的url(不包含host)
#   method:访问的方法， 默认GET
#   params: 访问的参数
#   exclusive: 不参与计算的参数名。 一般情况只有sig不参与计算（只是默认的，不需要特别指定），但有些api可能会有特殊要求)
# return sign 字符串（返回""说明签名失败，如参数错误等）
###
makeSignature = (url, method="GET", params={}, exclusive=[]) ->
  return "" unless url? and _.isString(url) and url.length>0
  return "" unless method? and _.isString(method) and method.length>0
  return "" unless params? and _.isObject(params) and not _.isEmpty(params)
  #去除不参与计算得参数
  exclusive or= []
  exclusive.push "sign"
  args = _.omit params, exclusive
  #先将所有参与计算的参数按规定生成源串
  str = helps.raw(args)
  str = "#{method}&#{encodeURIComponent(url)}&#{encodeURIComponent(str)}"
  console.log "str: #{str}"
  #加密编码生成最终的sign
  digest = crypto.createHmac('sha1', "#{@appkey}&")
    .update(str)
    .digest("base64")
  #return encodeURIComponent(digest)
  return digest

module.exports =
  makeSignature: makeSignature
