#!/bin/sh
export MONGO_CONNECTION=mongodb://nightscoutuser:MYMONGOPW@127.0.0.1:27017/nightscout
export DISPLAY_UNITS=mg/dl
export API_SECRET=MYAPISECRET
#ENABLE="careportal boluscalc rawbg"
export ENABLE="careportal boluscalc rawbg openaps iob cob sage basal pump cors"
export DEVICESTATUS_ADVANCED="true"
export TIME_FORMAT=24
export SHOW_RAWBG=noise
export ALARM_URGENT_HIGH=off
export ALARM_HIGH=off
export ALARM_URGENT_LOW=off
export ALARM_LOW=off
export SHOW_FORECAST="ar2 openaps"
export ALARM_TIMEAGO_WARN=off
export ALARM_TIMEAGO_URGENT=off
export OPENAPS_ENABLE_ALERTS=false
export LANGUAGE=de
export BG_TARGET_BOTTOM=70
export AUTH_DEFAULT_ROLES="denied"
export INSECURE_USE_HTTP=true
export CORS_ALLOW_ORIGIN=*

export PORT=3000
cd ${HOME}/nightscout-git
node server.js
