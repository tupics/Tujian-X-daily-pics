import "android.os.Environment"
import "android.graphics.Typeface"


--打印字符
function Toast(str)
  local toast = luajava.bindClass("android.widget.Toast")
  toast.makeText(activity, tostring(str),toast.LENGTH_SHORT).show()
end


ThemeColor,TextColor=...--接收主页传来的主题配色

--字符常量
statusBarColor="#00796B";
colorPrimary="#009688";
colorAccent="#4DB6AC";
APP_PACKAGENAME=activity.getPackageName()
Bold=Typeface.defaultFromStyle(Typeface.BOLD)
APP_CACHEPATH=tostring(activity.getExternalCacheDir())
SDCARD_PATH=tostring(Environment.getExternalStorageDirectory())
APP_VERSIONCODE=activity.getPackageManager().getPackageInfo(APP_PACKAGENAME, 0).versionCode
APP_VERSIONNAME=activity.getPackageManager().getPackageInfo(APP_PACKAGENAME, 0).versionName


--主题
function switchtheme(pattern,layout)
--  local h=tonumber(os.date("%H"))
  this.ActionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(ThemeColor)))
  --  this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(Color.parseColor(ThemeColor))
  this.ActionBar.setElevation(6)
  if layout~=nil then
    this.setContentView(loadlayout(layout))
  end
end