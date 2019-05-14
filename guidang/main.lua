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

ThemeColor,TextColor=...--载入参数
sdk = tointeger(Build.VERSION.SDK)

隐藏标题栏()

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
if ThemeColor == "FF000000" then--防止全白
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
    --print(scrollY)
  end,

  --按下
  onDownMotionEvent=function()
    --print("按下")
  end,

  --拖拽结束或者取消时
  onUpOrCancelMotionEvent=function(scrollState)
    if(scrollState==ScrollState.DOWN) then
      --print("向下滚动");
      translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(), 0})
      translationUp.setInterpolator(DecelerateInterpolator())
      translationUp.setDuration(256)
      translationUp.start()
      alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 1})
      alpha.setDuration(256)--设置动画时间
      alpha.setInterpolator(DecelerateInterpolator())
      alpha.start()
     elseif(scrollState==ScrollState.UP) then
      --print("向上滚动");
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
        --print("向下滚动");
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
      --print("停止滚动");
    end

  end
})

obs_2.setScrollViewCallbacks(ObservableScrollViewCallbacks{
  --滚动时
  onScrollChanged=function(scrollY,firstScroll,dragging)
    obs2_lst=scrollY
    --print(scrollY,firstScroll,dragging)

    -- param scrollY 在Y轴滚动位置。
    -- firstScroll 是否是第一次（刚开始）滑动
    -- dragging 当前视图是否是因为拖拽而产生滑动
  end,

  --按下
  onDownMotionEvent=function()
    --print("按下")
  end,

  --拖拽结束或者取消时
  onUpOrCancelMotionEvent=function(scrollState)
    if(scrollState==ScrollState.DOWN) then
      --print("向下滚动");
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
        --print("向上滚动");
        translationUp = ObjectAnimator.ofFloat(_topbar, "Y",{_topbar.getY(),-dp2px(56)})
        translationUp.setInterpolator(DecelerateInterpolator())
        translationUp.setDuration(256)
        translationUp.start()
        alpha = ObjectAnimator.ofFloat(_topbar_top, "alpha", {_topbar_top.getAlpha(), 0})
        alpha.setDuration(256)--设置动画时间
        alpha.setInterpolator(DecelerateInterpolator())
        alpha.start()
       else
        --print("向下滚动");
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
      --print("停止滚动");
    end

  end
})

--[[


MLua模板 by MUK


]]

控件隐藏(subtitle)
_title.getPaint().setFakeBoldText(true)
ThemeColor,TextColor=...--载入参数
--print(ThemeColor,TextColor)--测试

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

--杂烩设置
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
          if sdk<=28==false then
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(picUrl:sub(1,53));
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian","杂烩-"..math.random(1,999999999999)..".png");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            print("开始保存图片至此设备")
           else
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(picUrl:sub(1,53));
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Pictures/Tujian","杂烩-"..math.random(1,999999999999)..".png");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            print("开始保存图片至此设备")
          end
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

--插画设置
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
          if sdk<=28==false then
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(picUrl:sub(1,53));
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian","插画-"..math.random(1,999999999999)..".png");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            print("开始保存图片至此设备")
           else
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(picUrl:sub(1,53));
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Pictures/Tujian","插画-"..math.random(1,999999999999)..".png");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            print("开始保存图片至此设备")
          end
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
  local dialog6= ProgressDialog(this)
  dialog6.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
  --设置进度条的形式为水平进度条
  dialog6.setTitle("设置壁纸")
  dialog6.setCancelable(true)--设置是否可以通过点击Back键取消
  dialog6.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
  local filePath=tostring(activity.getFilesDir()).."/imagecache/"..title..".jpg"
  local function down(url,path)
    local tt=Ticker()
    tt.Period=10
    tt.start()
    Http.download(url,path,function(code,data,cookie,header)
      if endd then
        return
      end
      tt.stop()
      import "android.graphics.BitmapFactory"
      import "android.app.WallpaperManager"
      bitmap = BitmapFactory.decodeFile(path)
      manager = WallpaperManager.getInstance(activity.getApplicationContext())
      manager.setBitmap(bitmap)
      print("壁纸已设置")
      dialog6.hide()
    end)
    function tt.onTick()
      local f=io.open(path,"r")
      if f~=nil then
        local len=f:read("a")
        local s=#len/lens
        dialog6.setProgress(s*100)
      end
    end
  end
  local function download(url,path)
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

--控件点击波纹函数
function ControlsRipple(id,Color)
  import 'android.graphics.drawable.*'
  import "android.content.res.ColorStateList"
  local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  ripple=typedArray.getResourceId(0,0)
  Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{Color}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{Color})))
end

--[[效果不行，已删除
--print函数（原作者 @yuxuan 仅修改为函数调用）
function snakebar(neirong)
  --pop窗口布局
  yuxuan={
    LinearLayout,
    orientation="vertical",
    layout_width="fill",
    layout_height="fill",
    background="#000000",
    id="yuxuanpop",
    {
      TextView,
      text=neirong,
      textColor="#ffffff",
      textSize="15sp",
      layout_gravity="left",
      layout_marginTop="13dp",
      layout_marginLeft="25dp",
      id="text";
    }
  }
  --定义一个弹窗为PopupWindow类型的弹窗
  pop=PopupWindow(activity)
  --给弹窗一个自定义布局
  pop.setContentView(loadlayout(yuxuan))
  --修复bug,千万不能删除
  pop.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)
  --设置显示宽度
  pop.setWidth(activity.width)
  --设置显示高度
  pop.setHeight(130)
  --点击PopupWindow外面区域  true为消失
  pop.setOutsideTouchable(false)
  --修复bug,千万不能删
  pop.setBackgroundDrawable(BitmapDrawable(loadbitmap("9.jpg")))
  --设置pop可获得焦点
  pop.setFocusable(false)
  --设置pop可触摸
  pop.setTouchable(true)
  --设置弹窗显示位置
  pop.showAtLocation(view,Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL,0,0)


  --下面这个动画可要可不要，我使用是为了增加微交互，更爽
  --这个是弹窗里面的控件动画
  --定义动画变量,使用AnimationSet类，使该动画可加载多种动画
  animationSet = AnimationSet(true)
  --设置布局动画，布局动画的意思是布局里面的控件执行动画，而非单个控件动画，参数:动画名，延迟
  layoutAnimationController=LayoutAnimationController(animationSet,0.2);
  --设置动画类型，顺序   反序   随机
  layoutAnimationController.setOrder(LayoutAnimationController.ORDER_NORMAL); --   ORDER_     NORMAL     REVERSE     RANDOM
  --id控件加载动画
  yuxuanpop.setLayoutAnimation(layoutAnimationController);

  --渐变动画
  yuxuan_dh1= AlphaAnimation(0,1);
  --渐变动画时长
  yuxuan_dh1.setDuration(00);
  --添加动画
  animationSet.addAnimation(yuxuan_dh1);

  --平移动画
  yuxuan_dh2=TranslateAnimation(Animation.RELATIVE_TO_PARENT, 1, Animation.RELATIVE_TO_SELF, 0, Animation.RELATIVE_TO_SELF, 0, Animation.RELATIVE_TO_SELF, 0);
  --动画时长
  yuxuan_dh2.setDuration(00);
  --添加动画
  animationSet.addAnimation(yuxuan_dh2);




  --上升动画
  --相关参数，请自行手册查询
  --定义动画,500为上升高度
  yuxuandh3=TranslateAnimation(0, 0,130, 0)
  --动画时间，也就是上升动画的快慢
  yuxuandh3.setDuration(200)
  --动画开始执行
  yuxuanpop.startAnimation(yuxuandh3);
  --动画结束回调
  import "android.view.animation.Animation$AnimationListener"
  yuxuandh3.setAnimationListener(AnimationListener{
    onAnimationEnd=function()

      --3000是动画间隔时间
      task(800,function()
        --同yuxuandh3
        yuxuandh4=TranslateAnimation(0, 0,0,130)
        yuxuandh4.setDuration(200)
        yuxuanpop.startAnimation(yuxuandh4);
        import "android.view.animation.Animation$AnimationListener"
        yuxuandh4.setAnimationListener(AnimationListener{
          onAnimationEnd=function()

            pop.dismiss()
          end})
      end)
    end})

  function 渐变(left_jb,right_jb,id)
    drawable = GradientDrawable(GradientDrawable.Orientation.TR_BL,{
      right_jb,--右色
      left_jb,--左色
    });
    id.setBackgroundDrawable(drawable)
  end
  --调用渐变函数
  渐变(0xFF323232,0xFF323232,yuxuanpop)
  参数=tonumber(os.time())
end
]]