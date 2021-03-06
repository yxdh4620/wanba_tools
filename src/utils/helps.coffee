###
# 公共的帮助类(这里的接口只提供本项目自身调用， 不提供对外调用)
###

debuglog = require("debug")("utils::helps")
_ = require 'underscore'
xml2js = require('xml2js')
querystring = require "querystring"
#xmlParser = require('xml2json')

rank = (args) ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    #newArgs[key.toLowerCase()] = args[key]
    newArgs[key] = args[key]
  return newArgs

rankAndEncode = (args) ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    #newArgs[key.toLowerCase()] = encodeURIComponent(args[key])
    #newArgs[key.toLowerCase()] = escape(args[key])
    #newArgs[key.toLowerCase()] = args[key]
    #newArgs[key] = escape(args[key])
    #newArgs[key] = encodeURIComponent(args[key])
    newArgs[key] = args[key]
  return newArgs

#将传人的参数转为一个get 请求参数的字符串
raw = (args)  ->
  keys = _.keys(args)
  keys = keys.sort()
  newArgs = {}
  keys.forEach (key) ->
    newArgs[key] = args[key]
  str = ""
  for k,v of newArgs
    v = JSON.stringify(v) if _.isObject(v)
    str += "&"+k+"="+v
  str =  str.substr(1)
  return str

xml2json = (xml, callback) ->
  xml2js.parseString xml, {
    trim: true,
    explicitArray: false
  }, (err, json) ->
    return callback err if err?
    data = if json? then json.xml else {}
    return callback null, data

json2xml = (obj) ->
  builder = new xml2js.Builder()
  xml = builder.buildObject({xml:obj})
  return xml

makeReqOptions = (self, uri, method, params) ->
  params.appid = self.appid
  params.pf or= self.pf
  params.format or= self.format
  params.sig = self.makeSignature uri, method, params
  if method == "POST"
    options =
      url: "#{self.host}#{uri}"
      json: true
      method: method
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
      body: querystring.stringify(params)
    console.dir options
    return options
  #params.sig =encodeURIComponent(params.sig)
  options =
    url: "#{self.host}#{uri}?#{querystring.stringify(params)}"
    json: true
    method:method
  console.dir options
  return options

module.exports =
  rank:rank
  rankAndEncode:rankAndEncode
  raw:raw
  xml2json:xml2json
  json2xml:json2xml
  makeReqOptions:makeReqOptions

