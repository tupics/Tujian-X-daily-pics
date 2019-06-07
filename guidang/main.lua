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
import "com.github.ksoichiro.android.observablescrollview.*"--导入ObservableScrollView，容易监听滑动
import "muk"--导入中文函数
import "Createlite@Tujian@SnakerBar"
import "android.content.pm.ActivityInfo"
import 'ml.cerasus.RomUtil.*'

ThemeColor,TextColor=...--载入参数
sdk = tointeger(Build.VERSION.SDK)

隐藏标题栏()

--隐藏虚拟导航栏
activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE)
activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setNavigationBarColor(转0x(ThemeColor));

--设置颜色变量便于调用
primaryc="#3F51B5"
write="#ffffffff"
viewshaderc="#3f000000"
textc="#212121"
w=ThemeColor
b=TextColor

--[[
状态栏沉浸，Android SDK>19时生效
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
]]
--完全沉浸，SDK>21
if ThemeColor == "#FFFFFFFF" or ThemeColor == "#ffffffff" or ThemeColor==nil then--防止全白
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(转0x("#FF757575"));
 else
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(转0x(ThemeColor));
end

状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)

pagea_={
  ObservableScrollView;
  layout_width="-1";
  layout_height="-1";
  id="obs_1";
  {
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    orientation="vertical";
    paddingTop=dp2px(56+48)+状态栏高度;--抵消顶部遮盖部分高度
    {
      LuaWebView;
      id="杂烩";
      layout_width="fill";
      layout_height="fill";
    };
  };
};

pageb_={
  ObservableScrollView;
  layout_width="-1";
  layout_height="-1";
  id="obs_2";
  {
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    orientation="vertical";
    paddingTop=dp2px(56+48)+状态栏高度;--抵消顶部遮盖部分高度
    {
      LuaWebView;
      id="插画";
      layout_width="fill";
      layout_height="fill";
    };
  };
};

--布局表
layout={--页面布局
  LinearLayout;
  layout_height="-1";
  layout_width="-1";
  id="_root";
  orientation="vertical";
  {
    RelativeLayout;--RelativeLayout中
    layout_height="-1";
    layout_width="-1";
    background=write;
    {
      LinearLayout;
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      {--标题栏以下布局
        PageView;--多页面布局
        layout_height="-1";
        layout_width="-1";
        id="_page";
        pages={
          pagea_;--页面a
          pageb_;--页面b
        };
      };
    };
    {
      LinearLayout;
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      {--顶栏布局
        LinearLayout;
        layout_height="-2";
        layout_width="-1";
        background=w;
        elevation="4dp";
        orientation="vertical";
        id="_topbar";
        --[[
        {--状态栏占位布局
          TextView;
          layout_height=状态栏高度;
          layout_width="-1";
          background=w;
        };
      --启用请配合sdk19的状态栏
      ]]
        {--标题栏布局
          LinearLayout;
          layout_height="56dp";
          layout_width="-1";
          background=w;
          gravity="left|center";
          id="_topbar_top";
          {
            RelativeLayout,
            {
              TextView;
              Text="归档";
              textColor=b;
              textSize="20sp";
              paddingLeft="25dp";
              id="_title";
            };
            {
              TextView;
              Text="加载中..";
              textColor=b;
              textSize="12sp";
              layout_below="_title",
              paddingLeft="25dp";
              id="subtitle";
            };

          };
        };
        {--Tab布局
          RelativeLayout;
          layout_height="48dp";
          layout_width="-1";
          background=w;
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            {
              LinearLayout;
              layout_width=activity.getWidth()/2;
              layout_height="-1";
              gravity="center";
              id="jc1";
              onClick=function()_page.showPage(0)end;--切换到第一页（Page计数从0开始）
              {
                TextView;
                layout_width="-2";
                layout_height="-2";
                Text="杂烩";
                textColor=b;
              };
            };
            {
              LinearLayout;
              layout_width=activity.getWidth()/2;
              layout_height="-1";
              gravity="center";
              id="jc2";
              onClick=function()_page.showPage(1)end;--切换到第二页（Page计数从0开始）
              {
                TextView;
                layout_width="-2";
                layout_height="-2";
                Text="插画";
                textColor=b;
                alpha="0.6";
              };
            };
          };
          {
            LinearLayout;
            layout_height="2dp";
            layout_width=activity.getWidth()/2;
            id="page_scroll";
            layout_alignParentBottom="true";
            background=write;
          };
        };
      };
    };
  };
};


设置视图(layout)

品牌=Build.BRAND
if 品牌 == "Smartisan" then
 else
  波纹({jc1,jc2},"方黑")
end

--[[
ControlsRipple(jc1,0x3f000000)
ControlsRipple(jc2,0x3f000000)
]]

_page.setOnPageChangeListener(PageView.OnPageChangeListener{
  --页面状态改变监听
  onPageScrolled=function(a,b,c)
    --页面滚动时
    local w=activity.getWidth()/2
    local wd=c/2
    if a==0 then
      page_scroll.setX(wd)
    end
    if a==1 then
      page_scroll.setX(wd+w)
    end
  end,
  onPageSelected=function(v)
    --页面选中时（停止滚动时）
    local x=1
    local c=0.6
    local c1=c
    local c2=c
    local c3=c
    local c4=c
    if v==0 then
      c1=x
    end
    if v==1 then
      c2=x
    end
    --设置透明度
    jc1.getChildAt(0).setAlpha(c1)
    jc2.getChildAt(0).setAlpha(c2)
  end
})

obs_1.setScrollViewCallbacks(ObservableScrollViewCallbacks{
  --滚动时
  onScrollChanged=function(scrollY,firstScroll,dragging)
    obs1_lst=scrollY
    --SnakeBar(scrollY)
  end,

  --按下
  onDownMotionEvent=function()
    --SnakeBar("按下")
  end,

  --拖拽结束或者取消时
  onUpOrCancelMotionEvent=function(scrollState)
    if(scrollState==ScrollState.DOWN) then
      --SnakeBar("向下滚动");
      translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(), 0})
      translationUp.setInterpolator(DecelerateInterpolator())
      translationUp.setDuration(256)
      translationUp.start()
      alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 1})
      alpha.setDuration(256)--设置动画时间
      alpha.setInterpolator(DecelerateInterpolator())
      alpha.start()
     elseif(scrollState==ScrollState.UP) then
      --SnakeBar("向上滚动");
      if obs1_lst>=5 then
        translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(),-dp2px(56)})
        translationUp.setInterpolator(DecelerateInterpolator())
        translationUp.setDuration(256)
        translationUp.start()
        alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 0})
        alpha.setDuration(256)--设置动画时间
        alpha.setInterpolator(DecelerateInterpolator())
        alpha.start()
       else
        --SnakeBar("向下滚动");
        translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(), 0})
        translationUp.setInterpolator(DecelerateInterpolator())
        translationUp.setDuration(256)
        translationUp.start()
        alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 1})
        alpha.setDuration(256)--设置动画时间
        alpha.setInterpolator(DecelerateInterpolator())
        alpha.start()
      end
     else
      --SnakeBar("停止滚动");
    end

  end
})

obs_2.setScrollViewCallbacks(ObservableScrollViewCallbacks{
  --滚动时
  onScrollChanged=function(scrollY,firstScroll,dragging)
    obs2_lst=scrollY
    --SnakeBar(scrollY,firstScroll,dragging)

    -- param scrollY 在Y轴滚动位置。
    -- firstScroll 是否是第一次（刚开始）滑动
    -- dragging 当前视图是否是因为拖拽而产生滑动
  end,

  --按下
  onDownMotionEvent=function()
    --SnakeBar("按下")
  end,

  --拖拽结束或者取消时
  onUpOrCancelMotionEvent=function(scrollState)
    if(scrollState==ScrollState.DOWN) then
      --SnakeBar("向下滚动");
      translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(), 0})
      translationUp.setInterpolator(DecelerateInterpolator())
      translationUp.setDuration(256)
      translationUp.start()
      alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 1})
      alpha.setDuration(256)--设置动画时间
      alpha.setInterpolator(DecelerateInterpolator())
      alpha.start()
     elseif(scrollState==ScrollState.UP) then
      if obs2_lst>=5 then
        --SnakeBar("向上滚动");
        translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(),-dp2px(56)})
        translationUp.setInterpolator(DecelerateInterpolator())
        translationUp.setDuration(256)
        translationUp.start()
        alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 0})
        alpha.setDuration(256)--设置动画时间
        alpha.setInterpolator(DecelerateInterpolator())
        alpha.start()
       else
        --SnakeBar("向下滚动");
        translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(), 0})
        translationUp.setInterpolator(DecelerateInterpolator())
        translationUp.setDuration(256)
        translationUp.start()
        alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 1})
        alpha.setDuration(256)--设置动画时间
        alpha.setInterpolator(DecelerateInterpolator())
        alpha.start()
      end
     else
      --SnakeBar("停止滚动");
    end

  end
})

--[[


MLua模板 by MUK


]]

控件隐藏(subtitle)
_title.getPaint().setFakeBoldText(true)
ThemeColor,TextColor=...--载入参数
--SnakeBar(ThemeColor,TextColor)--测试

--[[
kbl3=...--接受在杂烩设置的空变量
参数=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if 参数+2 > tonumber(os.time()) then
      activity.finish()
     else
      kbl2="空变量"
      activity.newActivity("zahui/main.lua",android.R.anim.fade_in,android.R.anim.fade_out,{kbl2})
      activity.finish()
      参数=tonumber(os.time())
    end
    return true
  end
end
]]
--动画代码不稳定，未开放

--杂烩归档设置
杂烩.loadUrl("https://dp.chimon.me/fapp/old.php?sort=杂烩")--加载网页
杂烩.getSettings().setSupportZoom(false)--不支持缩放
杂烩.getSettings().setJavaScriptEnabled(true)--设置支持JS，备用
杂烩.getSettings().setUserAgentString("Tujian @Createlite");--辨识UA
杂烩.removeView(杂烩.getChildAt(0))--隐藏进度显示

杂烩.onLongClick=function()
  hitTestResult = 杂烩.getHitTestResult()
  if
    (hitTestResult.getType() == 杂烩.HitTestResult.IMAGE_TYPE
    or
    hitTestResult.getType() == 杂烩.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)
    then
    picUrl = hitTestResult.getExtra()
    project = {"保存图片","设为壁纸"}
    actionListener =
    {
      onClick=function(dialog,which)
        if(which== 0) then
          保存图片("杂烩")--函数在后面，这里是为了方便
        end
        if(which== 1) then
          setWallpaper(""..picUrl.."","杂烩-"..math.random(1,999999999999)..".png")
        end
      end
    }
    AlertDialog.Builder(this)
    .setItems(project,actionListener)
    .show();
  end
end

杂烩.setWebViewClient{
  onPageStarted=function(view,url,favicon)
    控件可见(subtitle)
  end,
  onPageFinished=function(view,url)
    控件隐藏(subtitle)
  end}

--插画归档设置
控件可见(subtitle)
插画.loadUrl("https://dp.chimon.me/fapp/old.php?sort=插画")--加载网页
插画.getSettings().setSupportZoom(false)--不支持缩放
插画.getSettings().setJavaScriptEnabled(true)--设置支持JS，备用
插画.getSettings().setUserAgentString("Tujian @Createlite");--辨识UA
插画.removeView(插画.getChildAt(0))--隐藏进度显示

插画.onLongClick=function()
  hitTestResult = 插画.getHitTestResult()
  if
    (hitTestResult.getType() == 插画.HitTestResult.IMAGE_TYPE
    or
    hitTestResult.getType() == 插画.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)
    then
    picUrl = hitTestResult.getExtra()
    project = {"保存图片","设为壁纸"}
    actionListener =
    {
      onClick=function(dialog,which)
        if(which== 0)
          then
          保存图片("插画")--函数在后面，这里是为了方便
        end
        if(which== 1) then
          setWallpaper(""..picUrl.."","插画-"..math.random(1,999999999999)..".png")
        end
      end
    }
    AlertDialog.Builder(this)
    .setItems(project,actionListener)
    .show();
  end
end

插画.setWebViewClient{
  onPageStarted=function(view,url,favicon)
    控件可见(subtitle)
  end,
  onPageFinished=function(view,url)
    控件隐藏(subtitle)
  end}

--隐藏导航栏
activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE)

--保存图片函数
function 保存图片(sort)
  判定=Uri.parse(picUrl:sub(1,16));
  if 判定 == "https://img.dpic"then
    if sdk <= 28 == false
      then
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url1=Uri.parse(picUrl:sub(1,53));
      url=url1.."?p=0"
      request=DownloadManager.Request(url);
      request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
      request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian",""..sort.."-"..math.random(1,999999999999)..".png");
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
      downloadManager.enqueue(request);
      SnakeBar("开始保存图片至此设备")
     else
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url1=Uri.parse(picUrl:sub(1,53));
      url=url1.."?p=0"
      request=DownloadManager.Request(url);
      request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
      request.setDestinationInExternalPublicDir("Pictures/Tujian",""..sort.."-"..math.random(1,999999999999)..".png");
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
      downloadManager.enqueue(request);
      SnakeBar("开始保存图片至此设备")
    end
   else
    if sdk <= 28 == false
      then
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url=Uri.parse(picUrl);   
      request=DownloadManager.Request(url);
      request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
      request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian",""..sort.."-"..math.random(1,999999999999)..".png");
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
      downloadManager.enqueue(request);
      SnakeBar("开始保存图片至此设备")
     else
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url=Uri.parse(picUrl);
      request=DownloadManager.Request(url);
      request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
      request.setDestinationInExternalPublicDir("Pictures/Tujian",""..sort.."-"..math.random(1,999999999999)..".png");
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
      downloadManager.enqueue(request);
      SnakeBar("开始保存图片至此设备")
    end
  end
end

--设置壁纸函数
function setWallpaper(url,title) --直接传入下载链接和标题就行
  require "import"
  import "com.androlua.Http"
  import "com.androlua.Ticker"
  import "android.widget.LinearLayout"
  import "java.net.URL"
  import "android.content.Intent"
  import "android.os.Environment"
  import "android.net.Uri"
  import "android.widget.TextView"
  import "android.app.WallpaperManager"
  import "android.app.*"
  import "java.io.*"
  dialog6= ProgressDialog(this)
  dialog6.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
  --设置进度条的形式为水平进度条
  dialog6.setTitle("设置壁纸")
  dialog6.setCancelable(false)--设置是否可以通过点击Back键取消
  dialog6.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
  filePath="/sdcard/Android/data/ml.cerasus.pics/cache/"..title..""
  path=filePath
  function down(url,path)
    tt=Ticker()
    tt.Period=10
    tt.start()
    Http.download(url,path,nil,UA,function(code,content)
      if code==200 then
        import "java.io.*" --先导入io包
        file,err=io.open(path)
        --SnakeBar(content,file,err)
        if err==nil then
          tt.stop()
          --判断系统，需要导包 import"ml.cerasus.RomUtil"
          --EMUI
          if RomUtil.isHuaweiRom() then
            componentName = ComponentName("com.android.gallery3d","com.android.gallery3d.app.Wallpaper");
            intent = Intent(Intent.ACTION_VIEW);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setDataAndType(Uri.fromFile(File(path)), "image/*");
            intent.putExtra("mimeType", "image/*");
            intent.setComponent(componentName);
            activity.startActivity(intent);
            dialog6.hide()
            dialog6.dismiss()
           elseif RomUtil.isMiuiRom() then
            --MIUI
            componentName = ComponentName("com.android.thememanager", "com.android.thememanager.activity.WallpaperDetailActivity");
            intent = Intent("miui.intent.action.START_WALLPAPER_DETAIL");
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setDataAndType(Uri.fromFile(File(path)),"image/*");
            intent.putExtra("mimeType","image/*");
            intent.setComponent(componentName);
            activity.startActivity(intent); intent = Intent(Intent.ACTION_ATTACH_DATA);
            dialog6.hide()
            dialog6.dismiss()
           else
            --其他
            local intent = Intent(Intent.ACTION_ATTACH_DATA);
            intent.setDataAndType(Uri.fromFile(File(path)),'image/*');
            activity.startActivity(intent);
            dialog6.hide()
            dialog6.dismiss()
          end
        end
      end
    end)
    function tt.onTick()
      f=io.open(path,"r")
      if f~=nil then
        len=f:read("a")
        s=#len/lens
        dialog6.setProgress(s*100)
      end
    end
  end
  function download(url,path)
    dialog6.show()
    import "java.net.URL"
    realUrl = URL(url)
    -- 打开和URL之间的连接
    con = realUrl.openConnection();
    -- 设置通用的请求属性
    con.setRequestProperty("accept", "*/*");
    con.setRequestProperty("connection", "Keep-Alive");
    con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    lens=con.getContentLength()
    down(url,path)
  end
  download(url,filePath)
end

--针对（可能）锤子水波纹问题
if sdk < 28 then
  activity.setTheme(android.R.style.Theme_Material_Light)
end
--控件点击波纹函数
function ControlsRipple(id,Color)
  import 'android.graphics.drawable.*'
  import "aS，ndroid.content.res.ColorStateList"
  local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  ripple=typedArray.getResourceId(0,0)
  Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{Color}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{Color})))
end

--Snakebar函数，具体代码请见根目录Snakebar.lua
function SnakeBar(fill)
  SnackerBar.build()
  :msg(fill)
  :actionText("")
  :action(function() end)
  :show()
end
