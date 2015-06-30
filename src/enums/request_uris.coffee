
module.exports =
  # users.coffee(用户信息等相关)
  GET_INFO_URI : "/v3/user/get_info"
  GET_MULTI_INFO_URI: "/v3/user/get_multi_info"
  SEND_GAMEBAR_MSG: "/v3/user/send_gamebar_msg"
  IS_LOGIN_URI: "/v3/user/is_login"
  TOTAL_VIP_INFO_URI: "/v3/user/total_vip_info"
  IS_VIP_URI:"/v3/user/is_vip"
  FRIENDS_VIP_INFO_URI: "/v3/user/friends_vip_info"
  IS_SETUP_URI: "/v3/user/is_setup"
  GET_APP_FLAG_URI: "/v3/user/get_app_flag"
  DEL_APP_FLAG_URI: "/v3/user/del_app_flag"
  IS_AREA_LOGIN_URI: "/v3/user/is_area_login"

  # relations.coffee(用户关系)
  GET_APP_FRIENDS_URI:"/v3/relation/get_app_friends"
  IS_FRIEND_URI: "/v3/relation/is_friend"
  GET_RCMD_FRIENDS_URI: "/v3/relation/get_rcmd_friends"

  # generalizes.coffee(推广)
  SET_ACHIEVEMENT_URI: "/v3/user/set_achievement"
  GET_ACHIEVEMENT_URI: "/v3/user/get_achievement"
  GET_GAMEBAR_RANKLIST_URI: "/v3/user/get_gamebar_ranklist"

  VERIFY_INVKEY_URI: "/v3/spread/verify_invkey"

  #支付相关(payments.coffee)
  BUY_PLAYZONE_ITEM_URI: "/v3/user/buy_playzone_item"
  GET_PLAYZONE_USERINFO_URI:"/v3/user/get_playzone_userinfo"


