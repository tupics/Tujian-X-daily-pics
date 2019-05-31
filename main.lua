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

--检测是否启动过了，打开welcome.lua
import "java.io.File"--导入File类
if File("/sdcard/Android/data/ml.cerasus.pics/cachemain/welcome.tj").exists() ==false
  then
  f=File(tostring(File(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/welcome.tj")).getParentFile())).mkdirs()
  io.open(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/welcome.tj"),"w"):write(tostring("Welcome to use Tujian X")):close()
  activity.newActivity('welcome/main.lua')
  activity.finish()
  if tointeger(sdk) <= 28
    then
    申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})
  end
 else
  activity.newActivity("zahui/main.lua")
  activity.finish()
end

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏

if Build.VERSION.SDK_INT >= 21 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff757575);
end

