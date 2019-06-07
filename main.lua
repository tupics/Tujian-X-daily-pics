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
import "android.content.pm.PackageManager"
import "android.Manifest"
import "muk"

--activity.setTitle('MLua')
--activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
activity.setContentView(loadlayout("layout"))
--设置视图("layout")

--隐藏虚拟导航栏
activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE)

sdk = tointeger(Build.VERSION.SDK)

--针对（可能）锤子水波纹问题
if sdk < 28 then
  activity.setTheme(android.R.style.Theme_Material_Light)
end

--检测是否启动过了，打开welcome.lua
import "java.io.File"--导入File类
if File("/sdcard/Android/data/ml.cerasus.pics/cachemain/welcome.tj").exists() ==false
  then
  if tointeger(sdk) <= 28
    then
    申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})
  end
  activity.newActivity('welcome/main.lua')
  activity.finish()
  function onNewIntent(intent)
    --获得传递过来的数据并转化为字符串
    local uriString = tostring(intent.getData())
    if "num1"==uriString then
      activity.newActivity("zahui/main.lua",{"随机"})
      activity.finish()
     elseif "num2"==uriString then
      activity.newActivity("zahui/main.lua",{"插画"})
      activity.finish()
     elseif "num3"==uriString then
      activity.newActivity("zahui/main.lua",{"杂烩"})
      activity.finish()
     else
      activity.newActivity("zahui/main.lua",{nil})
      activity.finish()
    end
  end
 else
  function onNewIntent(intent)
    --获得传递过来的数据并转化为字符串
    local uriString = tostring(intent.getData())
    if "num1"==uriString then
      activity.newActivity("zahui/main.lua",{"随机"})
      activity.finish()
     elseif "num2"==uriString then
      activity.newActivity("zahui/main.lua",{"插画"})
      activity.finish()
     elseif "num3"==uriString then
      activity.newActivity("zahui/main.lua",{"杂烩"})
      activity.finish()
     else
      activity.newActivity("zahui/main.lua",{nil})
      activity.finish()
    end
  end
end

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏

if Build.VERSION.SDK_INT >= 21 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff757575);
end
