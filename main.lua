--[[
Copyright [2018－2019] [Tujian X @Createlite]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.ColorFilter"
import "android.view.WindowManager"
import "android.content.pm.ActivityInfo"

--activity.setTitle('MLua')
--activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
activity.setContentView(loadlayout("layout"))
--设置视图("layout")

--检测是否启动过了，打开welcome.lua
function getData(name,key)
  local data=this.getApplicationContext().getSharedPreferences(name,0).getString(key,nil)--325-5273-2
  return data
end

function putData(name,key,value)
  this.getApplicationContext().getSharedPreferences(name,0).edit().putString(key,value).apply()--3255-2732
  return true
end
if not getData("welcome","是否启动过？") then
  putData("welcome","是否启动过？","已经启动过了")
  activity.newActivity('welcome/main.lua')
 else
  activity.newActivity("zahui/main.lua")
end

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏

activity.finish()

if Build.VERSION.SDK_INT >= 21 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff4285f4);
end