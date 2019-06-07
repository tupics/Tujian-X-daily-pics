require "import"
import "imports"

import "android.app.*"
import "android.os.*"
import "android.widget.*"

import "android.view.*"
import "android.view.animation.*"
import "android.view.animation.Animation$AnimationListener"
import "android.view.inputmethod.InputMethodManager"

import "android.animation.*"

import "android.net.*"

import "android.text.*"
import "android.text.style.*"

import "android.content.*"
import "android.content.res.*"
import "android.content.pm.PackageManager"
import "android.content.pm.ApplicationInfo"
import "android.content.ContentResolver"

import "android.graphics.*"
import "android.graphics.Matrix"
import "android.graphics.Bitmap"
import "android.graphics.BitmapFactory"
import "android.graphics.Typeface"
import "android.graphics.drawable.*"
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"

import "android.renderscript.*"
import "android.renderscript.Element"
import "android.renderscript.Allocation"
import "android.renderscript.ScriptIntrinsicBlur"
import "android.renderscript.RenderScript"

import "java.lang.Math"

import "java.security.*"

import "java.io.*"
import "java.io.File"
import "java.io.InputStream"

import "java.util.*"

import "java.net.URL"

import "android.content.res.ColorStateList"
import "android.content.pm.PackageManager"
import "android.content.Intent"
import "android.net.Uri"
import "android.util.Base64"
import "http"

import "androidx.*"
import "androidx.core.app.ActivityCompat"

import "android.webkit.WebSettings"
import "android.webkit.MimeTypeMap"

import "android.provider.Settings"

import "android.Manifest"


--MUK的函数--
function 状态栏颜色(n)
  window=activity.getWindow()
  window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
  window.setStatusBarColor(n)
  if n==0x3f000000 then
    if 获取SDK版本()>=23 then
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      window.setStatusBarColor(0xffffffff)
    end
  end
end

function 主题(str)
  --str="夜"
  全局主题值=str
  if 全局主题值=="日" then
    primaryc="#448aff"
    secondaryc="#fdd835"
    textc="#212121"
    stextc="#424242"
    backgroundc="#ffffffff"
    barbackgroundc="#efffffff"
    cardbackc="#ffffffff"
    viewshaderc="#00000000"
    grayc="#ECEDF1"
    状态栏颜色(0x3f000000)
    activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)
   elseif 全局主题值=="夜" then
    primaryc="#ff3368c0"
    secondaryc="#ffbfa328"
    textc="#808080"
    stextc="#666666"
    backgroundc="#ff191919"
    barbackgroundc="#ef191919"
    cardbackc="#ff212121"
    viewshaderc="#80000000"
    grayc="#212121"
    状态栏颜色(0xff191919)
    activity.setTheme(android.R.style.Theme_DeviceDefault_NoActionBar)
  end
end

function 设置主题(str)
  activity.setTheme(str)
end

function 转0x(j)
  if #j==7 then
    jj=j:match("#(.+)")
    jjj=tonumber("0xff"..jj)
   else
    jj=j:match("#(.+)")
    jjj=tonumber("0x"..jj)
  end
  return jjj
end

function 判断悬浮窗权限()
  if (Build.VERSION.SDK_INT >= 23 and not Settings.canDrawOverlays(this)) then
    return false
   elseif Build.VERSION.SDK_INT < 23 then
    return ""
   else
    return true
  end
end

function 获取悬浮窗权限()
  intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
  intent.setData(Uri.parse("package:" .. activity.getPackageName()));
  activity.startActivityForResult(intent, 100);
end

--[[if Settings.canDrawOverlays(this)==false then

  intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
  intent.setData(Uri.parse("package:" .. activity.getPackageName()));
  this.startActivity(intent);

  双按钮对话框("烦人但是必不可少的权限(； ･`д･´)","MUKSK的正常运行需要以下权限：\n悬浮窗权限（显示步骤教程）\n存储权限（保存数据）","开启权限","退出",function()
    获取权限()
    权限=1
  end,function()
    关闭对话框(an)
    关闭页面()
  end,0)

end]]

function 安装apk(安装包路径)
  import "android.content.Intent"
  import "android.net.Uri"
  intent = Intent(Intent.ACTION_VIEW)
  intent.setDataAndType(Uri.parse("file:///"..安装包路径), "application/vnd.android.package-archive")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(intent)
end

function 浏览器打开(pageurl)
  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

function 设置图片(preview,url)
  preview.setImageBitmap(loadbitmap(url))
end

function 字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/"..t..".ttf"))
end

function 开关颜色(id,color,color2)
  id.ThumbDrawable.setColorFilter(PorterDuffColorFilter(转0x(color),PorterDuff.Mode.SRC_ATOP))
  id.TrackDrawable.setColorFilter(PorterDuffColorFilter(转0x(color2),PorterDuff.Mode.SRC_ATOP))
end


function 提示(t)
  local tsbj={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    gravity="center";
    --background="#ffffffff";
    --padding="8dp";
    --paddingTop="64dp";
    {
      CardView;
      layout_width="-1";
      layout_height="-2";
      Elevation="0";
      layout_margin="8dp";
      radius="4dp";
      background="#ef424242";
      {
        LinearLayout;
        layout_width=activity.getWidth()-16;
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="16dp";
          paddingLeft="16dp";
          paddingTop="12dp";
          paddingBottom="12dp";
          gravity="center";
          Text=t;
          textColor="#ffffffff";
        };
      };
    };
  };
  Toast.makeText(activity,t,Toast.LENGTH_LONG).setGravity(Gravity.BOTTOM|Gravity.CENTER, 0, 0).setView(loadlayout(tsbj)).show()
end

local ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
local ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)

function 波纹(id,lx,numfy)
  if type(lx)=="number" then
    for index,content in pairs(id) do
      if numfy=="方" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{lx})))
       elseif numfy=="圆"
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{lx})))
      end
    end
   else
    for index,content in pairs(id) do
      if lx=="圆白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="方白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="圆黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="方黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="圆主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f448aff})))
      end
      if lx=="方主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f448aff})))
      end
      if lx=="圆自适应" then
        if 全局主题值=="日" then
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
      if lx=="方自适应" then
        if 全局主题值=="日" then
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
    end
  end
end

function 双按钮对话框(bt,nr,qd,qx,qdnr,qxnr,gb)
  if 全局主题值=="日" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        textColor=primaryc;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginRight="24dp";
          layout_marginBottom="8dp";
          Text=nr;
          textColor=textc;
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 单按钮对话框(bt,nr,qd,qdnr,gb)
  if 全局主题值=="日" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        textColor=primaryc;
      };
      {
        RelativeLayout;
        layout_width="-1";
        layout_height="-1";
        {
          ScrollView;
          layout_width="-1";
          layout_height="-1";
          layout_marginBottom=dp2px(24+8+16+8)+sp2px(16);
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="14sp";
            layout_marginTop="8dp";
            layout_marginLeft="24dp";
            layout_marginRight="24dp";
            layout_marginBottom="8dp";
            Text=nr;
            textColor=textc;
          };
        };
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          gravity="bottom|center";
          {
            LinearLayout;
            orientation="horizontal";
            layout_width="-1";
            layout_height="-2";
            gravity="right|center";
            background=barbackgroundc;
            {
              CardView;--24+8
              layout_width="-2";
              layout_height="-2";
              radius="4dp";
              background=primaryc;
              layout_marginTop="8dp";
              layout_marginLeft="8dp";
              layout_marginRight="24dp";
              layout_marginBottom="24dp";
              Elevation="1dp";
              onClick=qdnr;
              {
                TextView;--16+8
                layout_width="-1";
                layout_height="-2";
                textSize="16sp";
                paddingRight="16dp";
                paddingLeft="16dp";
                paddingTop="8dp";
                paddingBottom="8dp";
                Text=qd;
                textColor=backgroundc;
                BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
              };
            };
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end
--/MUK函数--

--文件操作--
function 写入文件(路径,内容)
  xpcall(function()
    f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
    io.open(tostring(路径),"w"):write(tostring(内容)):close()
  end,function()
    提示("写入文件 "..路径.." 失败")
  end)
end

function 读取文件(路径)
  if 文件是否存在(路径) then
    rtn=io.open(路径):read("*a")
   else
    rtn=""
  end
  return rtn
end

function 复制文件(from,to)
  xpcall(function()
    LuaUtil.copyDir(from,to)
  end,function()
    提示("复制文件 从 "..from.." 到 "..to.." 失败")
  end)
end

function 创建文件夹(file)
  xpcall(function()
    File(file).mkdir()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 创建文件(file)
  xpcall(function()
    File(file).createNewFile()
  end,function()
    提示("创建文件 "..file.." 失败")
  end)
end

function 创建多级文件夹(file)
  xpcall(function()
    File(file).mkdirs()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 文件是否存在(file)
  return File(file).exists()
end

function 删除文件(file)
  xpcall(function()
    LuaUtil.rmDir(File(file))
  end,function()
    提示("删除文件(夹) "..file.." 失败")
  end)
end

function 文件修改时间(path)
  f = File(path);
  time = f.lastModified()
  return time
end

function 内置存储路径(t)
  return Environment.getExternalStorageDirectory().toString().."/"..t
end

function 解压缩(压缩路径,解压缩路径)
  xpcall(function()
    ZipUtil.unzip(压缩路径,解压缩路径)
  end,function()
    提示("解压文件 "..压缩路径.." 失败")
  end)
end

function 压缩(原路径,压缩路径,名称)
  xpcall(function()
    LuaUtil.zip(原路径,压缩路径,名称)
  end,function()
    提示("压缩文件 "..原路径.." 至 "..压缩路径.."/"..名称.." 失败")
  end)
end

function 重命名文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("重命名文件 "..旧.." 失败")
  end)
end

function 移动文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("移动文件 "..旧.." 至 "..新.." 失败")
  end)
end

--/文件操作--

--获取设备--
function 获取设备标识码()
  import "android.provider.Settings$Secure"
  return Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)
end

function 获取IMEI()
  import "android.content.Context"
  return activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()
end

function 获取状态栏高度()
  return activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
end

function 获取设备型号()
  return Build.MODEL
end

function 获取ROM类型()
  return string.upper(Build.MANUFACTURER)
end

function 获取SDK版本()
  return tonumber(Build.VERSION.SDK)
end

function 获取安卓版本()
  return Build.VERSION.RELEASE
end

function 获取屏幕尺寸()
  import "android.util.DisplayMetrics"
  local dm = DisplayMetrics();
  activity.getWindowManager().getDefaultDisplay().getMetrics(dm);
  diagonalPixels = Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2));
  return diagonalPixels / (160 * dm.density);
end

function 获取手机内置存储剩余空间()
  fs = StatFs(Environment.getDataDirectory().getPath())
  return 格式化文件大小(fs.getAvailableBytes())
end

function 获取手机内置存储空间()
  path = Environment.getExternalStorageDirectory()
  stat = StatFs(path.getPath())
  blockSize = stat.getBlockSize()
  totalBlocks = stat.getBlockCount()
  return 格式化文件大小(blockSize * totalBlocks)
end
--/获取设备--

--一些函数--
function 格式化文件大小(fileSize)
  if (fileSize < 1024) then
    return fileSize + 'B';
   elseif (fileSize < (1024*1024)) then
    temp = fileSize / 1024;
    --temp = temp.toFixed(2);
    temp=四舍五入(temp,2)
    return temp .. 'KB';
   elseif (fileSize < (1024*1024*1024)) then
    temp = fileSize / (1024*1024);
    --temp = temp.toFixed(2);
    temp=四舍五入(temp,2)
    return temp .. 'MB';
   else
    temp = fileSize / (1024*1024*1024);
    --temp = temp.toFixed(2);
    temp=四舍五入(temp,2)
    return temp .. 'GB';
  end
end

function 四舍五入(num,n)
  local n=n-1
  ws="0"
  for i=0,n do
    if ws=="0" then
      ws="0."
    end
    ws=ws.."0"
  end
  import "java.text.DecimalFormat"
  import "android.icu.text.DecimalFormat"
  formatter = DecimalFormat(ws);
  local s = formatter.format(num);
  ws=nil
  return s;
end

function 获取视频第一帧(path)
  import "android.media.MediaMetadataRetriever"
  media = MediaMetadataRetriever()
  media.setDataSource(tostring(path))
  return media.getFrameAtTime()
end

function 背景圆角(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end

function 匹配汉字(s)
  local ss = {}
  for k = 1, #s do
    local c = string.byte(s,k)
    if not c then break end
    if (c>=48 and c<=57) or (c>= 65 and c<=90) or (c>=97 and c<=122) then
      if not string.char(c):find("%w") then
        table.insert(ss, string.char(c))
      end
     elseif c>=228 and c<=233 then
      local c1 = string.byte(s,k+1)
      local c2 = string.byte(s,k+2)
      if c1 and c2 then
        local a1,a2,a3,a4 = 128,191,128,191
        if c == 228 then a1 = 184
         elseif c == 233 then a2,a4 = 190,c1 ~= 190 and 191 or 165
        end
        if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then
          k = k + 2
          table.insert(ss, string.char(c,c1,c2))
        end
      end
    end
  end
  return table.concat(ss)
end

function px2dp(pxValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (pxValue / scale + 0.5)
end

function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale + 0.5)
end

function sp2px(spValue)
  local fontScale = this.getResources().getDisplayMetrics().scaledDensity
  return (spValue * fontScale + 0.5)
end

function 随机数(最小值,最大值)
  return math.random(最小值,最大值)
end

function 静态渐变(a,b,id,fx)
  if fx=="竖" then
    fx=GradientDrawable.Orientation.TOP_BOTTOM
  end
  if fx=="横" then
    fx=GradientDrawable.Orientation.LEFT_RIGHT
  end
  drawable = GradientDrawable(fx,{
    a,--右色
    b,--左色
  });
  id.setBackgroundDrawable(drawable)
end

function 对话框按钮颜色(dialog,button,WidgetColor)
  if button==1 then
    dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
   elseif button==2 then
    dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
   elseif button==3 then
    dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
  end
end

function 关闭对话框(an)
  an.dismiss()
end

function 检测键盘状态()
  imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
  isOpen=imm.isActive()
  return isOpen==true or false
end

function 隐藏键盘()
  activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function 显示键盘(id)
  activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function 关闭页面()
  activity.finish()
end

function 复制文本(文本)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(文本)
end

function QQ群(h)
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..h.."&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ(h)
  url="mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 全屏()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 退出全屏()
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 图片高斯模糊(id,tp,radius1,radius2)
  function blur( context, bitmap, blurRadius)
    renderScript = RenderScript.create(context);
    blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
    inAllocation = Allocation.createFromBitmap(renderScript, bitmap);
    outputBitmap = bitmap;
    outAllocation = Allocation.createTyped(renderScript, inAllocation.getType());
    blurScript.setRadius(blurRadius);
    blurScript.setInput(inAllocation);
    blurScript.forEach(outAllocation);
    outAllocation.copyTo(outputBitmap);
    inAllocation.destroy();
    outAllocation.destroy();
    renderScript.destroy();
    blurScript.destroy();
    return outputBitmap;
  end
  bitmap=loadbitmap(tp)
  function blurAndZoom(context,bitmap,blurRadius,scale)
    return zoomBitmap(blur(context,zoomBitmap(bitmap, 1 / scale), blurRadius), scale);
  end

  function zoomBitmap(bitmap,scale)
    w = bitmap.getWidth();
    h = bitmap.getHeight();
    matrix = Matrix();
    matrix.postScale(scale, scale);
    bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
    return bitmap;
  end


  加深后的图片=blurAndZoom(activity,bitmap,radius1,radius2)
  id.setImageBitmap(加深后的图片)
end

function 获取应用信息(archiveFilePath)
  pm = activity.getPackageManager()
  info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
  if info ~= nil then
    appInfo = info.applicationInfo;
    appName = tostring(pm.getApplicationLabel(appInfo))
    packageName = appInfo.packageName; --安装包名称
    version=info.versionName; --版本信息
    icon = pm.getApplicationIcon(appInfo);--图标
  end
  return packageName,version,icon
end

function 编辑框颜色(eid,color)
  eid.getBackground().setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP))
end

function 下载文件(链接,文件名)
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(链接);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(内置存储("Download",文件名));
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
  提示("正在下载，下载到："..内置存储("Download/"..文件名).."\n请查看通知栏以查看下载进度。")
end

function 获取文件MIME(name)
  ExtensionName=tostring(name):match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  return tostring(Mime)
end

function xdc(url,path)
  require "import"
  import "java.net.URL"
  local ur =URL(url)
  import "java.io.File"
  file=File(path);
  local con = ur.openConnection();
  local co = con.getContentLength();
  local is = con.getInputStream();
  local bs = byte[1024]
  local len,read=0,0
  import "java.io.FileOutputStream"
  local wj= FileOutputStream(path);
  len = is.read(bs)
  while len~=-1 do
    wj.write(bs, 0, len);
    read=read+len
    pcall(call,"ding",read,co)
    len = is.read(bs)
  end
  wj.close();
  is.close();
  pcall(call,"dstop",co)
end
function appDownload(url,path)
  thread(xdc,url,path)
end
function 下载文件对话框(title,url,path,ex)
  local path=内置存储("Download/"..path)
  appDownload(url,path)
  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local 布局={
    LinearLayout,
    id="appdownbg",
    layout_width="fill",
    layout_height="fill",
    orientation="vertical",
    BackgroundDrawable=gd2;
    {
      TextView,
      id="appdownsong",
      text=title,
      --  typeface=Typeface.DEFAULT_BOLD,
      layout_marginTop="24dp",
      layout_marginLeft="24dp",
      layout_marginRight="24dp",
      layout_marginBottom="8dp",
      textColor=primaryc,
      textSize="20sp",
    },
    {
      TextView,
      id="appdowninfo",
      text="已下载：0MB/0MB\n下载状态：准备下载",
      --id="显示信息",
      --  typeface=Typeface.MONOSPACE,
      layout_marginRight="24dp",
      layout_marginLeft="24dp",
      layout_marginBottom="8dp",
      textSize="14sp",
      textColor=textc;
    },
    {
      ProgressBar,
      id="进度条",
      style="?android:attr/progressBarStyleHorizontal",
      layout_width="fill",
      progress=0,
      max=100;
      layout_marginRight="24dp",
      layout_marginLeft="24dp",
      layout_marginBottom="24dp",
    },
  }
  local dldown=AlertDialog.Builder(activity)
  dldown.setView(loadlayout(布局))
  进度条.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(转0x(primaryc),PorterDuff.Mode.SRC_ATOP))
  dldown.setCancelable(false)
  local ao=dldown.show()
  window = ao.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);

  function ding(a,b)--已下载，总长度(byte)
    appdowninfo.Text=string.format("%0.2f",a/1024/1024).."MB/"..string.format("%0.2f",b/1024/1024).."MB".."\n下载状态：正在下载"
    进度条.progress=(a/b*100)
  end

  function dstop(c)--总长度
    --[[if path:find(".bin") then
      lpath=path
      path=path:gsub(".bin",".apk")
      重命名文件(lpath,path)
    end]]
    关闭对话框(ao)

    if url:find("step")~=nil then
      提示("导入中…稍等哦(^^♪")
      解压缩(path,ex)
      删除文件(path)
      提示("导入完成ʕ•ٹ•ʔ")
     else
      提示("下载完成，大小"..string.format("%0.2f",c/1024/1024).."MB，储存在："..path)
      if path:find(".apk$")~=nil then
        双按钮对话框("安装APP",[===[您下载了安装包文件，要现在安装吗？]===],"立即安装","取消",function()关闭对话框(an)安装apk(path)end,function()关闭对话框(an)end)
      end
    end
  end

end

function 申请权限(权限)
  ActivityCompat.requestPermissions(this,权限,1)
end

function 安装apk(安装包路径)
  import "android.content.Intent"
  import "android.net.Uri"
  intent = Intent(Intent.ACTION_VIEW)
  intent.setDataAndType(Uri.parse("file:///"..安装包路径), "application/vnd.android.package-archive")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(intent)
end

function 浏览器打开(pageurl)
  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

function 设置图片(preview,url)
  preview.setImageBitmap(loadbitmap(url))
end

function 设置开关颜色(id,color,color2)
  id.ThumbDrawable.setColorFilter(PorterDuffColorFilter(转0x(color),PorterDuff.Mode.SRC_ATOP))
  id.TrackDrawable.setColorFilter(PorterDuffColorFilter(转0x(color2),PorterDuff.Mode.SRC_ATOP))
end

function 微信扫一扫()
  import "android.content.Intent"
  import "android.content.ComponentName"
  intent = Intent();
  intent.setComponent( ComponentName("com.tencent.mm", "com.tencent.mm.ui.LauncherUI"));
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  intent.setFlags(335544320);
  intent.setAction("android.intent.action.VIEW");
  activity.startActivity(intent);
end

function 支付宝扫一扫()
  import "android.net.Uri"
  import "android.content.Intent"
  uri = Uri.parse("alipayqr://platformapi/startapp?saId=10000007");
  intent = Intent(Intent.ACTION_VIEW, uri);
  activity.startActivity(intent);
end

function 颜色字体(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(转0x(c)),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end

function 打印(t)
  print(t)
end

function 判断有无网络()
  local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
  if wl==nil then
    netl=false
   else
    netl=true
  end
  return netl
end

function 沉浸状态栏()
  --这个需要系统SDK19以上才能用
  if Build.VERSION.SDK_INT >= 19 then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
  end
end

--/一些函数--

--用户界面--
function 跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,cs)
   else
    activity.newActivity(ym)
  end
end

function 渐变跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out,cs)
   else
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out)
  end
end

function 设置视图(t)
  activity.setContentView(loadlayout(t))
end

function 控件可见(a)
  a.setVisibility(View.VISIBLE)
end

function 控件不可见(a)
  a.setVisibility(View.INVISIBLE)
end

function 控件隐藏(a)
  a.setVisibility(View.GONE)
end

function 显示标题栏()
  activity.ActionBar.show()
end

function 隐藏标题栏()
  activity.ActionBar.hide()
end

function 设置标题栏阴影高度(dp)
  activity.ActionBar.setElevation(dp2px(dp))
end

function 设置标题栏返回图标(boolean)
  activity.ActionBar.setDisplayHomeAsUpEnabled(boolean)
end

function 设置页面标题(t)
  activity.ActionBar.setTitle(t)
end

function 设置页面小标题(t)
  activity.ActionBar.setSubTitle(t)
end

function 设置文本(id,t)
  id.setText(t)
end

function 获取文本(id)
  return id.getText()
end

function 设置控件宽度(id,dp)
  id.setWidth(dp2px(dp))
end

function 设置控件高度(id,dp)
  id.setHeight(dp2px(dp))
end
--/用户界面--