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
import "com.michael.NoScrollListView"--导入可以嵌套在Scrollview里的列表
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
import "android.graphics.Matrix"
import "android.graphics.Bitmap"
import "android.renderscript.Allocation"
import "android.renderscript.Element"
import "android.renderscript.ScriptIntrinsicBlur"
import "android.renderscript.RenderScript"
import "muk"--配合 Mlua 使用（酷安搜索下载，否则本项目会报错）
import "android.graphics.Paint"
import "android.content.Context"
import "android.net.Uri"
import "android.content.*"
import "android.app.ProgressDialog"
import "android.widget.*"
import "android.support.v4.widget.*"
import "android.app.AlertDialog"
import "android.content.DialogInterface"
import "android.content.Intent"
import "android.content.pm.PackageManager"
import "android.content.Intent"
import "android.net.Uri"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "com.androlua.*"
import "android.graphics.*"
import "android.support.v4.app.*"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "com.androlua.LuaUtil"
import 'android.graphics.drawable.*'
import "Createlite@Tujian@SnakerBar"
import "android.content.pm.ActivityInfo"
import 'ml.cerasus.RomUtil.*'



隐藏标题栏()

sdk = tointeger(Build.VERSION.SDK)
if tointeger(sdk) <= 28
  then
  申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})
end

语言=Locale.getDefault().getLanguage()

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏

品牌=Build.BRAND

--[[
状态栏沉浸，Android SDK>19时生效
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
]]
os.execute("rm -r ".."/storage/emulated/0/Android/data/ml.cerasus.pics/cache")--清除缓存目录

--设置颜色变量便于调用
primaryc="#3F51B5"
write="#ffffffff"
viewshaderc="#3f000000"
textc="#212121"
w="#ffffffff"
b="#ff000000"
barcolor="#ffffffff"
t="#ff000000"
ThemeColor="#FFFFFFFF"
TextColor="#FF000000"

状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
屏幕高度=activity.getHeight()
--状态栏颜色(0x3f000000)
--状态栏沉浸，Android SDK>19时生效
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
--activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LOW_PROFILE)
--activity.getWindow().setStatusBarColor(Color.TRANSPARENT);
layout2={--侧滑根布局
  DrawerLayout;
  background=barcolor;
  id="_drawer";
  {--页面布局
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    id="_root";
    orientation="vertical";
    {
      RelativeLayout,
      layout_height="-1";
      layout_width="-1";
      {
        LinearLayout;
        layout_height="fill";
        layout_width="fill";
        orientation="vertical";
        {
          ImageView;
          layout_width="fill";
          layout_height="fill";
          scaleType="centerCrop";
          id="img";
          Enabled=false;
        };
        {
          ImageView;
          layout_width="fill";
          layout_height="fill";
          scaleType="centerCrop";
          id="必应";
          Enabled=false;
        };
        {
          ImageView;
          layout_width="fill";
          layout_height="fill";
          scaleType="centerCrop";
          id="模糊";
          Enabled=false;
        };
        {
          ImageView;
          layout_width="fill";
          layout_height="fill";
          scaleType="centerCrop";
          id="必应模糊";
          Enabled=false;
        };
        {
          LuaWebView;
          id="桌面";
          layout_width="fill";
          layout_height="fill";
        };
        {
          LuaWebView;
          id="杂烩归档";
          layout_width="fill";
          layout_height="fill";
        };
        {
          LuaWebView;
          id="插画归档";
          layout_width="fill";
          layout_height="fill";
        };
      };
      {
        LinearLayout,
        orientation="vertical",
        layout_width="fill",
        layout_height="fill",
        gravity="center",
        {
          ProgressBar;
          id="loading";
        };
      };
      {
        LinearLayout;
        layout_height="-2";
        layout_width="-1";
        orientation="vertical";
        {--状态栏占位布局
          TextView;
          layout_height=状态栏高度;
          layout_width="-1";
          background="#42000000";
          id="状态栏";
        };
        {--标题栏布局
          LinearLayout;
          layout_height="56dp";
          layout_width="-1";
          gravity="left|center";
          id="标题栏";
          BackgroundColor="#42000000";
          {
            LinearLayout;
            layout_width="56dp";
            layout_height="56dp";
            gravity="center";
            orientation="vertical";
            onClick=function()_drawer.openDrawer(Gravity.LEFT)end;
            id="_menu";
            {
              TextView;
              layout_width="18.8dp";
              layout_height="2.2dp";
              BackgroundColor=w;
              id="_menu_1";
            };
            {
              TextView;
              layout_width="18.8dp";
              layout_height="2.2dp";
              BackgroundColor=w;
              layout_marginTop="6";
              id="_menu_2";
            };
            {
              TextView;
              layout_width="18.8dp";
              layout_height="2.2dp";
              BackgroundColor=w;
              layout_marginTop="6";
              id="_menu_3";
            };
          };
          {
            RelativeLayout,
            layout_height="-2";
            layout_width="-1";
            {
              TextView;
              Text="杂烩";
              textColor=w;
              textSize="20sp";
              paddingLeft="16dp";
              id="_title";
            };
            {
              TextView;
              Text="加载中..";
              textColor=w;
              textSize="12sp";
              layout_below="_title",
              paddingLeft="16dp";
              id="subtitle";
            };
            {
              ImageView;
              layout_width="24dp";
              layout_height="24dp";
              layout_marginTop="10dp",
              layout_marginLeft="75%w",
              src="zahui/res/more";
              id="more";
              ColorFilter=w;
              Enabled=false;
            };
            {
              ImageView;
              layout_width="24dp";
              layout_height="24dp";
              layout_marginTop="2dp",
              layout_marginLeft="75%w",
              src="zahui/res/more";
              id="bing";
              ColorFilter=w;
            };
          };
        };
      };
    };
  };

  {--侧滑布局
    ScrollView;
    layout_width="68%w";
    layout_height="-1";
    layout_gravity="left";--*重要*设置父布局重心
    background=write;
    id="_drawer_root";
    onClick=function()end;
    {
      LinearLayout;
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      {
        LinearLayout;
        id="_drawer_header";
        layout_height="-2";
        layout_width="-1";
        orientation="vertical";
        {--状态栏占位布局
          TextView;
          layout_height=状态栏高度;
          layout_width="-1";
          background=ThemeColor;
          id="占位";
        };
        {
          LinearLayout;
          layout_height="-1";
          layout_width="-1";
          padding="16dp";
          orientation="vertical";
          {
            ImageView;
            layout_height="72dp";
            layout_width="72dp";
            src="zahui/res/icon";
          };
          {
            TextView;
            layout_height="-2";
            layout_width="-1";
            text="\nTujian";
            textColor=b;
            textSize="16sp";
            paddingTop="4dp";
            id="Tujian";
          };
          {
            TextView;
            layout_height="-2";
            layout_width="-1";
            text=[[无人为孤岛，一图一世界]];
            textColor=b;
            textSize="12sp";
            alpha="0.9";
            paddingTop="4dp";
            id="sologen";
          };
        };
      };
      {--无滚动列表
        NoScrollListView;
        id="drawer_lv";
        layout_height="-1";
        layout_width="-1";
        DividerHeight=0;
        layout_marginTop="8dp";
      };
    };
  };
};

设置视图(layout2)

--波纹({cv1_lay},"方黑")

--设置侧滑监听
_drawer.setDrawerListener(DrawerLayout.DrawerListener{
  onDrawerSlide=function(v,z)
    local k=_drawer.isDrawerOpen(3)
    if k==false then
      dz=z*180
     else
      dz=-z*180
    end
    --与标题栏图标联动
    _menu.Rotation=dz
    _menu_1.Rotation=z*45
    _menu_2.scaleX=1-z/3.8
    _menu_3.Rotation=-z*45
    _menu_1.scaleX=1-z/2.4
    _menu_1.setTranslationY(z*3.2)
    _menu_1.setTranslationX(z*8.)
    _menu_3.scaleX=1-z/2.4
    _menu_3.setTranslationY(-z*3.2)
    _menu_3.setTranslationX(z*8)
  end})

静态渐变(0xffffffff,0xffffffff,_drawer_header,"横")

--侧滑列表项目
drawer_item={
  {--侧滑标题 (type1)
    LinearLayout;
    Focusable=true;
    layout_width="fill";
    layout_height="wrap";
    {
      TextView;
      id="title";
      textSize="14dp";
      textColor=primaryc;
      layout_marginTop="8dp";
      layout_marginLeft="16dp";
    };
  };

  {--侧滑项目 (type2)
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    gravity="center|left";
    {
      ImageView;
      id="iv";
      ColorFilter=textc;
      layout_marginLeft="16dp";
    };
    {
      TextView;
      id="tv";
      layout_marginLeft="16dp";
      textSize="14dp";
      textColor=textc;
    };
  };

  {--侧滑项目_选中项 (type3)
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    gravity="center|left";
    background="#21000000";
    {
      ImageView;
      id="iv";
      ColorFilter=primaryc;
      layout_marginLeft="16dp";
    };
    {
      TextView;
      id="tv";
      layout_marginLeft="16dp";
      textSize="14dp";
      textColor=primaryc;
    };
  };

};

--列表适配器
adp=LuaMultiAdapter(activity,drawer_item)
adp.add{__type=3,iv={src="zahui/res/zahui.png"},tv="杂烩"}
adp.add{__type=2,iv={src="zahui/res/archive.png"},tv="归档"}
adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
adp.add{__type=1,title="更多"}
adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
--adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
drawer_lv.setAdapter(adp)

--列表点击事件
drawer_lv.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(id,v,zero,one)
    local s=v.Tag.tv.Text
    --这个暂时的s变量就是点击项中TextView的文本，用于识别
    if s=="杂烩" then
      adp.clear()
      adp.add{__type=3,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=2,iv={src="zahui/res/archive.png"},tv="归档"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --    adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      local pxinxi = "https://dp.chimon.me/api/today.php?sort=杂烩"
      Http.get(pxinxi,nil,"UTF-8",UA,function(http_code,content)
        p_link = string.gsub(string.match(content,'"p_link":"(.-)"'),'\\/',"/")
        biaoti = string.gsub(string.match(content,'"p_title":"(.-)"'),'',"")
        xinxi1 = string.gsub(string.match(content,'"p_content":"(.-)"'),'\\r\\n',"\n")
        xinxi = string.gsub(xinxi1,[[\/\/]],'//')
        ThemeColor = string.gsub(string.match(content,'"ThemeColor":"(.-)"'),'',"")
        TextColor = string.gsub(string.match(content,'"TextColor":"(.-)"'),'',"")

        加载菜单()
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
        import "java.io.File"--导入File类
        if File("sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg").exists() == false then
          Http.download(""..p_link.."?q=70",("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"),nil,UA,function(code,content)
            if code==200 then
              import "java.io.*" --先导入io包
              file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              if err==nil then
                归档引导()
                自适应()
                task(500,function()
                  if
                    _title.Text == "杂烩"
                    or
                    _title.Text == "插画"
                    then
                    控件可见(img)

                    alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
                    alpha2.setDuration(256)--设置动画时间
                    alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
                    alpha2.start()
                    控件可见(subtitle)
                    控件隐藏(loading)
                    控件可见(more)
                    控件隐藏(必应)
                    控件隐藏(桌面)
                    控件隐藏(杂烩归档)
                    控件隐藏(插画归档)
                    控件隐藏(bing)
                  end
                end)
                subtitle.Text = biaoti
                img.Enabled=true
                模糊.Enabled=true
                img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
                more.Enabled=true
                if
                  _title.Text == "杂烩"
                  or
                  _title.Text == "插画"
                  then

                  task(500,function()
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

                    bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                    --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                    --imageView.setImageBitmap(Gaussian)


                    --高斯模糊加深
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


                    加深后的图片=blurAndZoom(activity,bitmap,25,4)
                    模糊.setImageBitmap(加深后的图片)
                  end)

                 else
                  SnackerBar.build()
                  :msg("网络不畅，正在尝试重连...")
                  :actionText("")
                  :action(function() end)
                  :show()
                end
               else
                SnackerBar.build()
                :msg("网络不畅，正在尝试重连...")
                :actionText("")
                :action(function() end)
                :show()
              end
            end
          end)
         else
          自适应()
          task(500,function()
            if
              _title.Text == "杂烩"
              or
              _title.Text == "插画"
              then
              控件可见(img)
              alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
              alpha2.setDuration(256)--设置动画时间
              alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
              alpha2.start()
              控件可见(subtitle)
              控件隐藏(loading)
              控件可见(more)
              控件隐藏(桌面)
              控件隐藏(杂烩归档)
              控件隐藏(插画归档)
              控件隐藏(必应)
              控件隐藏(bing)
            end
          end)
          subtitle.Text = biaoti
          img.Enabled=true
          模糊.Enabled=true
          img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
          more.Enabled=true
          if
            _title.Text == "杂烩"
            or
            _title.Text == "插画"
            then
            task(500,function()
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

              bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
              --imageView.setImageBitmap(Gaussian)


              --高斯模糊加深
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


              加深后的图片=blurAndZoom(activity,bitmap,25,4)
              模糊.setImageBitmap(加深后的图片)
            end)
          end
        end
      end)
      subtitle.Text = "加载中.."
      _title.Text = "杂烩"
      _drawer.closeDrawer(3)
      控件隐藏(img)
      控件隐藏(more)
      控件隐藏(bing)
      控件隐藏(必应)
      控件隐藏(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(桌面)
      控件可见(loading)
      控件可见(subtitle)

     elseif s=="插画" then
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=3,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=2,iv={src="zahui/res/archive.png"},tv="归档 "}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --      adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      local pxinxi = "https://dp.chimon.me/api/today.php?sort=插画"
      Http.get(pxinxi,nil,"UTF-8",UA,function(http_code,content)
        p_link = string.gsub(string.match(content,'"p_link":"(.-)"'),'\\/',"/")
        biaoti = string.gsub(string.match(content,'"p_title":"(.-)"'),'',"")
        xinxi1 = string.gsub(string.match(content,'"p_content":"(.-)"'),'\\r\\n',"\n")
        xinxi = string.gsub(xinxi1,[[\/\/]],'//')
        ThemeColor = string.gsub(string.match(content,'"ThemeColor":"(.-)"'),'',"")
        TextColor = string.gsub(string.match(content,'"TextColor":"(.-)"'),'',"")

        加载菜单()
        import "java.io.File"--导入File类
        if File("sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg").exists() == false then
          Http.download(""..p_link.."?q=70",("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"),nil,UA,function(code,content)
            if code==200 then
              import "java.io.*" --先导入io包
              file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              if err==nil then
                归档引导()
                自适应()
                task(500,function()
                  if
                    _title.Text == "杂烩"
                    or
                    _title.Text == "插画"
                    then
                    控件可见(subtitle)
                    控件隐藏(loading)
                    控件可见(more)
                    控件可见(img)
                    alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
                    alpha2.setDuration(256)--设置动画时间
                    alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
                    alpha2.start()
                    控件隐藏(杂烩归档)
                    控件隐藏(插画归档)
                    控件隐藏(桌面)
                    控件隐藏(bing)
                  end
                end)
                subtitle.Text = biaoti
                img.Enabled=true
                模糊.Enabled=true
                activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
                img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
                more.Enabled=true
                if
                  _title.Text == "杂烩"
                  or
                  _title.Text == "插画"
                  then

                  task(500,function()
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

                    bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                    --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                    --imageView.setImageBitmap(Gaussian)


                    --高斯模糊加深
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


                    加深后的图片=blurAndZoom(activity,bitmap,25,4)
                    模糊.setImageBitmap(加深后的图片)
                  end)
                 else
                  SnackerBar.build()
                  :msg("网络不畅，正在尝试重连...")
                  :actionText("")
                  :action(function() end)
                  :show()
                end
               else
                SnackerBar.build()
                :msg("网络不畅，正在尝试重连...")
                :actionText("")
                :action(function() end)
                :show()
              end
            end
          end)
         else
          自适应()
          if
            _title.Text == "杂烩"
            or
            _title.Text == "插画"
            then
            控件可见(subtitle)
            控件隐藏(loading)
            控件可见(img)
            alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
            alpha2.setDuration(256)--设置动画时间
            alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
            alpha2.start()
            控件隐藏(必应)
            控件可见(more)
            控件隐藏(杂烩归档)
            控件隐藏(插画归档)
            控件隐藏(桌面)
            控件隐藏(bing)
          end
          subtitle.Text = biaoti
          img.Enabled=true
          模糊.Enabled=true
          img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
          more.Enabled=true
          if
            _title.Text == "杂烩"
            or
            _title.Text == "插画"
            then

            task(500,function()
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

              bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
              --imageView.setImageBitmap(Gaussian)


              --高斯模糊加深
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


              加深后的图片=blurAndZoom(activity,bitmap,25,4)
              模糊.setImageBitmap(加深后的图片)
            end)
          end
        end
      end)
      控件隐藏(img)
      控件隐藏(more)
      控件隐藏(bing)
      控件隐藏(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(桌面)
      控件可见(loading)
      控件隐藏(必应)
      控件可见(subtitle)
      subtitle.Text = "加载中.."
      _title.Text = "插画"
      _drawer.closeDrawer(3)

     elseif s=="桌面" then
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=3,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --      adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      _drawer.closeDrawer(3)
      _title.Text = "桌面"
      控件隐藏(subtitle)
      控件隐藏(more)
      控件隐藏(loading)
      控件隐藏(img)
      控件隐藏(必应)
      控件隐藏(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(bing)
      控件可见(桌面)
      task(500,function()
        if
          _title.Text == "桌面"
          then
          控件隐藏(subtitle)
          控件隐藏(more)
          控件隐藏(loading)
          控件隐藏(必应)
          控件隐藏(img)
          控件隐藏(杂烩归档)
          控件隐藏(插画归档)
          控件隐藏(bing)
          控件可见(桌面)
        end
      end)

     elseif s=="随机" then
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=3,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --      adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      local pxinxi = "https://api.dpic.dev/random?op=mobile"
      Http.get(pxinxi,nil,"UTF-8",UA,function(http_code,content)
        p_link = string.gsub(string.match(content,'"local_url":"(.-)"'),'\\/',"/")
        biaoti = string.gsub(string.match(content,'"p_title":"(.-)"'),'',"")
        xinxi1 = string.gsub(string.match(content,'"p_content":"(.-)"'),'\\r\\n',"\n")
        xinxi = string.gsub(xinxi1,[[\/\/]],'//')
        加载菜单()
        import "java.io.File"--导入File类
        if File("sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg").exists() == false then
          Http.download(""..p_link.."?q=70",("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"),nil,UA,function(code,content)
            if code==200 then
              import "java.io.*" --先导入io包
              file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              if err==nil then
                归档引导()
                自适应()
                task(500,function()
                  if
                    _title.Text == "杂烩"
                    or
                    _title.Text == "随机"
                    then
                    控件可见(subtitle)
                    控件隐藏(loading)
                    控件可见(more)
                    控件可见(img)
                    alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
                    alpha2.setDuration(256)--设置动画时间
                    alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
                    alpha2.start()
                    控件隐藏(桌面)
                    控件隐藏(bing)
                    控件隐藏(杂烩归档)
                    控件隐藏(插画归档)
                  end
                end)
                subtitle.Text = biaoti
                img.Enabled=true
                模糊.Enabled=true
                activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
                img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
                more.Enabled=true
                if
                  _title.Text == "杂烩"
                  or
                  _title.Text == "随机"
                  then

                  task(500,function()
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

                    bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                    --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                    --imageView.setImageBitmap(Gaussian)


                    --高斯模糊加深
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


                    加深后的图片=blurAndZoom(activity,bitmap,25,4)
                    模糊.setImageBitmap(加深后的图片)
                  end)
                 else
                  SnackerBar.build()
                  :msg("网络不畅，正在尝试重连...")
                  :actionText("")
                  :action(function() end)
                  :show()
                end
               else
                SnackerBar.build()
                :msg("网络不畅，正在尝试重连...")
                :actionText("")
                :action(function() end)
                :show()
              end
            end
          end)
         else
          自适应()
          if
            _title.Text == "杂烩"
            or
            _title.Text == "随机"
            then
            控件可见(subtitle)
            控件隐藏(loading)
            控件可见(img)
            alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
            alpha2.setDuration(256)--设置动画时间
            alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
            alpha2.start()
            控件隐藏(必应)
            控件可见(more)
            控件隐藏(桌面)
            控件隐藏(bing)
            控件隐藏(杂烩归档)
            控件隐藏(插画归档)
          end
          subtitle.Text = biaoti
          img.Enabled=true
          模糊.Enabled=true
          img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
          more.Enabled=true
          if
            _title.Text == "杂烩"
            or
            _title.Text == "随机"
            then

            task(500,function()
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

              bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
              --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
              --imageView.setImageBitmap(Gaussian)


              --高斯模糊加深
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


              加深后的图片=blurAndZoom(activity,bitmap,25,4)
              模糊.setImageBitmap(加深后的图片)
            end)
          end
        end
      end)
      控件隐藏(img)
      控件隐藏(more)
      控件隐藏(bing)
      控件隐藏(桌面)
      控件可见(loading)
      控件隐藏(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(必应)
      控件可见(subtitle)
      subtitle.Text = "加载中.."
      _title.Text = "随机"
      _drawer.closeDrawer(3)


     elseif s=="必应" then
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=3,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --          adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      _drawer.closeDrawer(3)
      控件隐藏(subtitle)
      控件隐藏(img)
      控件隐藏(more)
      控件隐藏(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(桌面)
      控件隐藏(模糊)
      控件可见(loading)
      _title.Text = "必应"
      task(500,function()
        task(500,function()
          if
            _title.Text == "必应"
            then
            控件隐藏(subtitle)
            控件隐藏(more)
            控件隐藏(img)
            控件可见(bing)
            控件隐藏(subtitle)
            控件隐藏(杂烩归档)
            控件隐藏(插画归档)
            控件隐藏(桌面)
            控件隐藏(模糊)
            控件隐藏(more)
            控件可见(必应)
          end
        end)
        local pxinxi = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"
        Http.get(pxinxi,nil,"UTF-8",nil,function(http_code,content)
          link = string.gsub(string.match(content,'"url":"(.-)"'),'1920x1080',"1080x1920")
          xinxi = string.gsub(string.match(content,'"copyright":"(.-)"'),'\\r\\n',"\n")
          biaoti = "必应-"..os.date("%Y-%m-%d")..""
          linka = "https://s.cn.bing.net"..link..""
          p_link = string.gsub(linka,"&rf=LaDigue_1080x1920.jpg&pid=hp","",替换)
          if
            File("sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg").exists() == false
            then
            Http.download(""..p_link.."",("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"),nil,UA,function(code,content)
              if code==200 then
                import "java.io.*" --先导入io包
                file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                if err==nil then
                  必应.Enabled=true
                  模糊.Enabled=true
                  more.Enabled=true
                  控件可见(必应)
                  控件可见(bing)
                  控件隐藏(loading)
                  alpha2 = ObjectAnimator.ofFloat(必应, "alpha", {0, 1})
                  alpha2.setDuration(256)--设置动画时间
                  alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
                  alpha2.start()
                  控件隐藏(subtitle)
                  控件隐藏(img)
                  控件隐藏(杂烩归档)
                  控件隐藏(插画归档)
                  控件隐藏(模糊)
                  控件隐藏(桌面)
                  控件隐藏(more)
                  img.Enabled=false
                  模糊.Enabled=true
                  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
                  必应模糊.Enabled=true
                  必应.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
                  bing.Enabled=true
                  if
                    _title.Text == "必应"
                    then
                    if
                      _title.Text == "必应"
                      then

                      task(500,function()
                        控件隐藏(loading)
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

                        bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                        --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                        --imageView.setImageBitmap(Gaussian)


                        --高斯模糊加深
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


                        加深后的图片必应=blurAndZoom(activity,bitmap,25,4)
                        必应模糊.setImageBitmap(加深后的图片必应)
                      end)
                    end
                    task(500,function()
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

                      bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                      --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                      --imageView.setImageBitmap(Gaussian)


                      --高斯模糊加深
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


                      加深后的图片必应=blurAndZoom(activity,bitmap,25,4)
                      必应模糊.setImageBitmap(加深后的图片必应)
                    end)


                   else
                    SnackerBar.build()
                    :msg("网络不畅，正在尝试重连...")
                    :actionText("")
                    :action(function() end)
                    :show()
                  end
                 else
                  SnackerBar.build()
                  :msg("网络不畅，正在尝试重连...")
                  :actionText("")
                  :action(function() end)
                  :show()
                end
              end
            end)
           else
            控件隐藏(img)
            控件可见(bing)
            控件隐藏(loading)
            控件隐藏(杂烩归档)
            控件隐藏(插画归档)
            控件隐藏(subtitle)
            控件隐藏(桌面)
            控件可见(必应)
            alpha2 = ObjectAnimator.ofFloat(必应, "alpha", {0, 1})
            alpha2.setDuration(256)--设置动画时间
            alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
            alpha2.start()
            控件隐藏(more)
            必应.Enabled=true
            模糊.Enabled=true
            必应.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
            bing.Enabled=true
            if
              _title.Text == "必应"
              then
              task(500,function()
                控件隐藏(loading)
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

                bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
                --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
                --imageView.setImageBitmap(Gaussian)


                --高斯模糊加深
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


                加深后的图片必应=blurAndZoom(activity,bitmap,25,4)
                必应模糊.setImageBitmap(加深后的图片必应)
              end)
            end
          end
        end)
      end)
      控件隐藏(more)
      控件隐藏(img)
      控件隐藏(必应)
      控件可见(loading)
     elseif s=="归档" then
      --杂烩归档设置开始
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=3,iv={src="zahui/res/archive.png"},tv="归档"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --      adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      _drawer.closeDrawer(3)
      _title.Text = "归档"
      控件隐藏(subtitle)
      控件隐藏(more)
      控件隐藏(loading)
      控件隐藏(img)
      控件隐藏(必应)
      控件可见(杂烩归档)
      控件隐藏(插画归档)
      控件隐藏(bing)
      控件隐藏(桌面)
      task(500,function()
        if
          _title.Text == "归档"
          then
          控件隐藏(more)
          控件隐藏(loading)
          控件隐藏(img)
          控件隐藏(subtitle)
          控件隐藏(必应)
          控件可见(杂烩归档)
          控件隐藏(插画归档)
          控件隐藏(bing)
          控件隐藏(桌面)
        end
      end)
     elseif s=="归档 " then
      --插画归档设置开始
      adp.clear()
      adp.add{__type=2,iv={src="zahui/res/zahui.png"},tv="杂烩"}
      adp.add{__type=2,iv={src="zahui/res/chahua.png"},tv="插画"}
      adp.add{__type=3,iv={src="zahui/res/archive.png"},tv="归档 "}
      adp.add{__type=2,iv={src="zahui/res/desktop.png"},tv="桌面"}
      adp.add{__type=2,iv={src="zahui/res/compass.png"},tv="随机"}
      adp.add{__type=2,iv={src="zahui/res/bing.png"},tv="必应"}
      adp.add{__type=1,title="更多"}
      adp.add{__type=2,iv={src="zahui/res/text.png"},tv="句子"}
      adp.add{__type=2,iv={src="zahui/res/upload.png"},tv="投稿"}
      --      adp.add{__type=2,iv={src="zahui/res/setting.png"},tv="设置"}
      adp.add{__type=2,iv={src="zahui/res/info.png"},tv="关于"}
      _drawer.closeDrawer(3)
      _title.Text = "归档"
      控件隐藏(subtitle)
      控件隐藏(more)
      控件隐藏(loading)
      控件隐藏(img)
      控件隐藏(必应)
      控件隐藏(杂烩归档)
      控件可见(插画归档)
      控件隐藏(bing)
      控件隐藏(桌面)
      task(500,function()
        if
          _title.Text == "归档"
          then
          控件隐藏(more)
          控件隐藏(subtitle)
          控件隐藏(loading)
          控件隐藏(img)
          控件隐藏(必应)
          控件隐藏(杂烩归档)
          控件可见(插画归档)
          控件隐藏(bing)
          控件隐藏(桌面)
        end
      end)
     elseif s=="关于" then
      --[[
      kbl="空变量"--设置这个是为了进入退出动画
      activity.newActivity("guanyu/main.lua",android.R.anim.fade_in,android.R.anim.fade_out,{kbl})
      activity.finish()      
      ]]
      --代码不稳定，未开放，可以自己了解
      activity.newActivity("guanyu/main.lua",{ThemeColor,TextColor})
     elseif s=="句子" then
      句子()
     elseif s=="投稿" then
      url="https://dpic.dev/tg"
      viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
      activity.startActivity(viewIntent)
     elseif s=="设置" then
      SnakeBar("敬请期待..")
     else
      SnakeBar("功能暂不可用")
    end
  end})

--[[


MLua模板 by MUK



]]


--[[
动画代码不稳定，未开放
--接受关于/归档传来的空变量
kbl1=...
kbk2=...
if
  kbl1=="空变量"
  or
  kbl2=="空变量"
  then
  --打开侧栏
  _drawer.openDrawer(3)
end
]]


UA=HashMap{}
iPhoneUA=[[Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7]]
UA.put("User-Agent:",iPhoneUA)

_title.getPaint().setFakeBoldText(true)
Tujian.getPaint().setFakeBoldText(true)
local pxinxi = "https://dp.chimon.me/api/today.php?sort=杂烩"
Http.get(pxinxi,nil,"UTF-8",UA,function(http_code,content)
  --SnakeBar(content)
  p_link = string.gsub(string.match(content,'"p_link":"(.-)"'),'\\/',"/")
  biaoti = string.gsub(string.match(content,'"p_title":"(.-)"'),'',"")
  xinxi1 = string.gsub(string.match(content,'"p_content":"(.-)"'),'\\r\\n',"\n")
  xinxi = string.gsub(xinxi1,[[\/\/]],'//')
  ThemeColor = string.gsub(string.match(content,'"ThemeColor":"(.-)"'),'',"")
  TextColor = string.gsub(string.match(content,'"TextColor":"(.-)"'),'',"")
  加载菜单()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
  import "java.io.File"--导入File类
  if File("sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg").exists() == false then
    --SnakeBar(""..p_link.."?q=70")
    Http.download(""..p_link.."?q=70",("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"),nil,UA,function(code,content)
      --SnakeBar(code)
      if code==200 then
        import "java.io.*" --先导入io包
        file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
        --SnakeBar(content,file,err)
        if err==nil then
          自适应()
          归档引导()
          task(500,function()
            if
              _title.Text == "杂烩"
              then
              控件可见(img)
              控件可见(subtitle)
              控件隐藏(loading)
              alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
              alpha2.setDuration(256)--设置动画时间
              alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
              alpha2.start()
              控件可见(more)
              控件隐藏(杂烩归档)
              控件隐藏(插画归档)
              控件隐藏(必应)
              控件隐藏(桌面)
              控件隐藏(bing)
            end
          end)
          subtitle.Text = biaoti
          img.Enabled=true
          模糊.Enabled=true
          img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
          more.Enabled=true
          file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj")
          if err==nil==false
            then
            pop.show()
            f=File(tostring(File(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj")).getParentFile())).mkdirs()
            io.open(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj"),"w"):write(tostring("Welcome to use Tujian X")):close()
            --  os.execute('mkdir'.."/storage/emulated/0/Android/data/ml.cerasus.pics/cachemain/a.tj")
          end
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

          bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
          --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
          --imageView.setImageBitmap(Gaussian)


          --高斯模糊加深
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


          加深后的图片=blurAndZoom(activity,bitmap,25,4)
          模糊.setImageBitmap(加深后的图片)

         else
          SnakeBar"网络不畅"
        end
       else
        SnakeBar"无法连接到 Tujian 服务器，请检查网络设置"
      end
    end)
   else
    控件可见(img)
    控件可见(more)
    控件隐藏(loading)
    alpha2 = ObjectAnimator.ofFloat(img, "alpha", {0, 1})
    alpha2.setDuration(256)--设置动画时间
    alpha2.setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
    alpha2.start()
    控件隐藏(必应)
    控件可见(subtitle)
    subtitle.Text = biaoti
    img.Enabled=true
    模糊.Enabled=true
    img.setImageDrawable(BitmapDrawable(loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")))
    more.Enabled=true
    task(500,function()
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

      bitmap=loadbitmap("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg")
      --Gaussian = blur(activity,bitmap,25) --模糊度 0 ~ 25
      --imageView.setImageBitmap(Gaussian)


      --高斯模糊加深
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


      加深后的图片=blurAndZoom(activity,bitmap,25,4)
      模糊.setImageBitmap(加深后的图片)
    end)

  end
end)

--菜单
function 加载菜单()
  more.onClick=function()
    pop=PopupMenu(activity,more)
    menu=pop.Menu
    menu.add("查看归档").onMenuItemClick=function(a)
      --[[
      activity.newActivity("guidang/main.lua",{ThemeColor,TextColor,kbl3})     
    kbl3="空变量"
      activity.newActivity("guidang/main.lua",android.R.anim.fade_in,android.R.anim.fade_out,{ThemeColor,TextColor,kbl3})
      activity.close()
      ]]
      --代码不稳定，暂时未发布，开发者可以自己了解
      --  activity.newActivity("guidang/main.lua")
      activity.newActivity("guidang/main.lua",{ThemeColor,TextColor})
    end
    menu.add("设为壁纸").onMenuItemClick=function(a)
      setWallpaper(biaoti)
    end
    pop.show()
  end
end

--必应菜单
bing.onClick=function()
  pop1=PopupMenu(activity,bing)
  menu=pop1.Menu
  menu.add("设为壁纸").onMenuItemClick=function(a)
    setWallpaper("必应-"..math.random(1,999999999999)..".png")
  end
  pop1.show()
end


--黑色模式测试
function 黑色模式()
  activity.setTheme(android.R.style.Theme_DeviceDefault_NoActionBar)
  ThemeColor="#FF000000"
  TextColor="#FFFFFFFF"
end

--查看图片信息img
img.onClick=function()
  控件可见(模糊)
  控件隐藏(img)
  控件隐藏(必应)
  --延迟之后执行的事件
  dialog=AlertDialog.Builder(this)
  .setTitle(biaoti)
  .setMessage(xinxi)
  .setPositiveButton("保存",{onClick=function(v)
      控件可见(img)
      控件隐藏(模糊)
      控件隐藏(必应)
      if tointeger(sdk) <= 28
        then
        if
          File("/sdcard/Pictures/Tujian/"..biaoti..".jpg").exists() == true
          and
          import "java.io.*" --先导入io包
          file,err=io.open("/sdcard/Pictures/Tujian/"..biaoti..".jpg")
          if err==nil
            then
            SnakeBar("图片已存在")
          end
         else
          emm = string.sub(p_link,1,16)
          if emm == "https://img.dpic"then
            SnakeBar("开始保存图片至此设备")
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(p_link);
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Pictures/Tujian",""..biaoti..".jpg");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            import "java.io.*" --先导入io包
            file,err=io.open("/sdcard/Pictures/Tujian/"..biaoti..".jpg")
            if err==nil then
              SnakeBar("图片已保存至此设备")
            end
           else
            LuaUtil.copyDir("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg","/sdcard/Pictures/Tujian/"..biaoti..".jpg")
            SnakeBar("图片已保存至此设备")
          end
        end
       else
        if
          File("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg").exists() == true
          and
          import "java.io.*" --先导入io包
          file,err=io.open("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
          if err==nil
            then
            SnakeBar("图片已存在")
          end
          emm = string.sub(p_link,1,16)
          if emm == "https://img.dpic"then
            SnakeBar("开始保存图片至此设备")
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(p_link);
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian",""..biaoti..".jpg");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            import "java.io.*" --先导入io包
            file,err=io.open("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
            if err==nil then
              SnakeBar("图片已保存至此设备")
            end
          end
         else
          LuaUtil.copyDir("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg","/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
          SnakeBar("图片已保存至此设备")
        end
      end
    end})
  .setNeutralButton("分享",{onClick=function(v)
      控件可见(img)
      控件隐藏(模糊)
      控件隐藏(必应)
      text="推荐一张图片：\n「"..biaoti.."」 \n\n图片信息：\n"..xinxi.."\n查看链接：\n"..p_link.."\n\n来自：Tujian X"
      intent=Intent(Intent.ACTION_SEND);
      intent.setType("text/plain");
      intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
      intent.putExtra(Intent.EXTRA_TEXT, text);
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      activity.startActivity(Intent.createChooser(intent,"分享到:"));
    end})
  .show()
  dialog.setOnCancelListener{
    onCancel=function(l)
      控件可见(img)
      控件隐藏(模糊)
      控件隐藏(必应)
    end}
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff000000)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff000000)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff000000)
  dialog.create()
end



控件隐藏(必应)
控件隐藏(模糊)
控件隐藏(桌面)
控件隐藏(必应模糊)
控件隐藏(more)
控件隐藏(bing)
控件隐藏(img)
控件隐藏(杂烩归档)
控件隐藏(插画归档)
控件可见(subtitle)

模糊.onClick=function()
  if _title.Text == "杂烩" then
    控件可见(img)
  end
  if _title.Text == "插画" then
    控件可见(img)
  end
  if _title.Text == "必应" then
    控件可见(必应)
  end
  控件隐藏(模糊)
end

必应模糊.onClick=function()
  if _title.Text == "杂烩" then
    控件可见(img)
  end
  if _title.Text == "插画" then
    控件可见(img)
  end
  if _title.Text == "必应" then
    控件可见(必应)
  end
  控件隐藏(必应模糊)
end



--查看图片信息必应
必应.onClick=function()
  控件可见(必应模糊)
  控件隐藏(必应)
  控件隐藏(img)
  控件隐藏(模糊)
  task(200,function()
    控件隐藏(模糊)
    task(200,function()
      控件隐藏(模糊)
    end)
  end)
  --延迟之后执行的事件
  dialog8=AlertDialog.Builder(this)
  .setTitle(biaoti)
  .setMessage(xinxi)
  .setPositiveButton("保存",{onClick=function(v)
      控件可见(必应)
      控件隐藏(必应模糊)
      控件隐藏(模糊)
      控件隐藏(img)
      if tointeger(sdk) <= 28
        then
        if
          File("/sdcard/Pictures/Tujian/"..biaoti..".jpg").exists() == true
          and
          import "java.io.*" --先导入io包
          file,err=io.open("/sdcard/Pictures/Tujian/"..biaoti..".jpg")
          if err==nil
            then
            SnakeBar("图片已存在")
          end
         else
          emm = string.sub(p_link,1,16)
          if emm == "https://img.dpic"then
            SnakeBar("开始保存图片至此设备")
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(p_link);
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Pictures/Tujian",""..biaoti..".jpg");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            import "java.io.*" --先导入io包
            file,err=io.open("/sdcard/Pictures/Tujian/"..biaoti..".jpg")
            if err==nil then
              SnakeBar("图片已保存至此设备")
            end
           else
            LuaUtil.copyDir("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg","/sdcard/Pictures/Tujian/"..biaoti..".jpg")
            SnakeBar("图片已保存至此设备")
          end
        end
       else
        if
          File("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg").exists() == true
          and
          import "java.io.*" --先导入io包
          file,err=io.open("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
          if err==nil
            then
            SnakeBar("图片已存在")
          end
          emm = string.sub(p_link,1,16)
          if emm == "https://img.dpic"then
            SnakeBar("开始保存图片至此设备")
            downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            url=Uri.parse(p_link);
            request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian",""..biaoti..".jpg");
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
            import "java.io.*" --先导入io包
            file,err=io.open("/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
            if err==nil then
              SnakeBar("图片已保存至此设备")
            end
          end
         else
          LuaUtil.copyDir("/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg","/sdcard/Android/media/ml.cerasus.pics/Tujian/"..biaoti..".jpg")
          SnakeBar("图片已保存至此设备")
        end
      end
    end})
  .setNeutralButton("分享",{onClick=function(v)
      控件可见(必应)
      控件隐藏(必应模糊)
      控件隐藏(模糊)
      控件隐藏(img)
      text="推荐一张图片：\n「"..biaoti.."」 \n\n图片信息：\n"..xinxi.."\n查看链接：\n"..p_link.."\n\n来自：Tujian X"
      intent=Intent(Intent.ACTION_SEND);
      intent.setType("text/plain");
      intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
      intent.putExtra(Intent.EXTRA_TEXT, text);
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      activity.startActivity(Intent.createChooser(intent,"分享到:"));
    end})
  .show()
  dialog8.setOnCancelListener{
    onCancel=function(l)
      控件可见(必应)
      控件隐藏(必应模糊)
      控件隐藏(模糊)
      控件隐藏(img)
    end}
  dialog8.getButton(dialog8.BUTTON_POSITIVE).setTextColor(0xff000000)
  dialog8.getButton(dialog8.BUTTON_NEGATIVE).setTextColor(0xff000000)
  dialog8.getButton(dialog8.BUTTON_NEUTRAL).setTextColor(0xff000000)
  dialog8.create()
end

--修改ProgressBar颜色
loading.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))

--隐藏导航栏
activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE)

--杂烩归档设置
杂烩归档.loadUrl("https://dp.chimon.me/fapp/old.php?sort=杂烩")--加载网页
杂烩归档.getSettings().setSupportZoom(false)--不支持缩放
杂烩归档.getSettings().setJavaScriptEnabled(true)--设置支持JS，备用
杂烩归档.getSettings().setUserAgentString("Tujian @Createlite");--辨识UA
杂烩归档.removeView(杂烩归档.getChildAt(0))--隐藏进度显示

杂烩归档.onLongClick=function()
  hitTestResult = 杂烩归档.getHitTestResult()
  if
    (hitTestResult.getType() == 杂烩归档.HitTestResult.IMAGE_TYPE
    or
    hitTestResult.getType() == 杂烩归档.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)
    then
    picUrl = hitTestResult.getExtra()
    project = {"保存图片","设为壁纸"}
    actionListener =
    {
      onClick=function(dialog,which)
        if(which== 0) then
          归档保存图片("杂烩")--函数在后面，这里是为了方便
        end
        if(which== 1) then
          setWallpaper1(""..picUrl.."","杂烩-"..math.random(1,999999999999)..".png")
        end
      end
    }
    AlertDialog.Builder(this)
    .setItems(project,actionListener)
    .show();
  end
end

--插画归档设置
插画归档.loadUrl("https://dp.chimon.me/fapp/old.php?sort=插画")--加载网页
插画归档.getSettings().setSupportZoom(false)--不支持缩放
插画归档.getSettings().setJavaScriptEnabled(true)--设置支持JS，备用
插画归档.getSettings().setUserAgentString("Tujian @Createlite");--辨识UA
插画归档.removeView(插画归档.getChildAt(0))--隐藏进度显示

插画归档.onLongClick=function()
  hitTestResult = 插画归档.getHitTestResult()
  if
    (hitTestResult.getType() == 插画归档.HitTestResult.IMAGE_TYPE
    or
    hitTestResult.getType() == 插画归档.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)
    then
    picUrl = hitTestResult.getExtra()
    project = {"保存图片","设为壁纸"}
    actionListener =
    {
      onClick=function(dialog,which)
        if(which== 0)
          then
          归档保存图片("插画")--函数在后面，这里是为了方便
        end
        if(which== 1) then
          setWallpaper1(""..picUrl.."","插画-"..math.random(1,999999999999)..".png")
        end
      end
    }
    AlertDialog.Builder(this)
    .setItems(project,actionListener)
    .show();
  end
end

--Webview版本桌面壁纸
桌面.loadUrl("https://dp.chimon.me/fapp/old.php?sort=电脑壁纸")--加载网页
桌面.getSettings().setSupportZoom(false)--不支持缩放
桌面.getSettings().setJavaScriptEnabled(true)--设置支持JS，备用
桌面.getSettings().setUserAgentString("Tujian @Createlite");--辨识UA
桌面.removeView(桌面.getChildAt(0))--隐藏进度显示
桌面.onLongClick=function()
  hitTestResult = 桌面.getHitTestResult()
  if
    (hitTestResult.getType() == 桌面.HitTestResult.IMAGE_TYPE
    or
    hitTestResult.getType() == 桌面.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)
    then
    picUrl = hitTestResult.getExtra()
    project = {"保存图片","设为壁纸"}
    actionListener =
    {
      onClick=function(dialog,which)
        if(which== 0) then
          归档保存图片("桌面")
        end
        if(which== 1) then
          setWallpaper1(tostring(picUrl),"桌面-"..math.random(1,999999999999)..".png")
        end
      end
    }
    AlertDialog.Builder(this)
    .setItems(project,actionListener)
    .show();
  end
end



--检测更新
local packinfo = this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
local appinfo = this.getPackageManager().getApplicationInfo(this.getPackageName(),0)
local versionName = tostring(packinfo.versionName)
local versionCode = tonumber(packinfo.versionCode)
local check_update_url = "https://aus.nowtime.cc/api/query/update?appid=10135"
Http.get(check_update_url,nil,"UTF-8",UA,function(http_code,content)
  code = tonumber(string.match(content,'"code":(.-),'))-- 状态码
  msg = string.match(content,'"msg":"(.-)"')-- 消息

  if(code == 200) then
    new_versionCode = tonumber(string.match(content,'"version_code":(.-),'))--版本号
    new_versionName = string.match(content,'"version_name":"(.-)"')--版本名
    apk_url = string.gsub(string.match(content,'"apk_url":"(.-)"'),'\\','')--下载地址
    update_log1 = string.gsub(string.match(content,'"update_log":"(.-)"'),'\\n',"\n")--更新日志
    update_log = string.gsub(update_log1,[[\/]],'/')

    if (new_versionCode > versionCode) then
      dialog=AlertDialog.Builder(this)
      .setTitle("发现可用更新-"..new_versionName.."")
      .setMessage(update_log)
      .setPositiveButton("去往酷安",{onClick=function()
          import "android.content.Intent"
          import "android.net.Uri"
          url="https://www.coolapk.com/apk/ml.cerasus.pics"
          viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
          activity.startActivity(viewIntent) end})
      .setNeutralButton("了解",{onClick=function()
        end})
      .show()
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff000000)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff000000)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff000000)
      dialog.create()
    end
  end
end)

--归档引导函数
function 归档引导()
  file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj")
  if err==nil==false
    then
    _drawer.openDrawer(3)
    dialog10=AlertDialog.Builder(this)
    .setTitle("操作说明")
    .setMessage[[现在你已经成功的加载了 Tujian 中的第一张图片，下面是常见问题：

• 为什么只有一个图？在哪里查看归档？

点击侧栏中的“归档”可以查看本分类的归档图片。首页图片为今日本分类图片。

• 能快捷设置壁纸吗？

图片加载完毕后，首页会出现右上角的菜单栏。点按即可设为壁纸。

• 什么时候支持每日自动设置壁纸？Tile、Shortcut 或小部件会有吗？

这些功能正在测试中，后续会添加。]]
    .setPositiveButton("了解",{onClick=function()
        _drawer.openDrawer(3)
      end})
    .setCancelable(false)
    .show()
    dialog10.getButton(dialog10.BUTTON_POSITIVE).setTextColor(0xff000000)
    dialog10.getButton(dialog10.BUTTON_NEGATIVE).setTextColor(0xff000000)
    dialog10.getButton(dialog10.BUTTON_NEUTRAL).setTextColor(0xff000000)
    dialog10.create()
    f=File(tostring(File(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj")).getParentFile())).mkdirs()
    io.open(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/a.tj"),"w"):write(tostring("Welcome to use Tujian X")):close()
    --  os.execute('mkdir'.."/storage/emulated/0/Android/data/ml.cerasus.pics/cachemain/a.tj")
  end
end

--创建目录
f=File(tostring(File(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/b.tj")).getParentFile())).mkdirs()
io.open(tostring("/sdcard/Android/data/ml.cerasus.pics/cachemain/b.tj"),"w"):write(tostring("Welcome to use Tujian X")):close()

--两次返回退出
参数=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if 参数+2 > tonumber(os.time()) then
      activity.finish()
     else
      SnackerBar.build()
      :msg("再按一次返回键退出")
      :actionText("")
      :action(function() end)
      :show()
      _drawer.closeDrawer(3)
      参数=tonumber(os.time())
    end
    return true
  end
end


--Snakebar函数，具体代码请见根目录Snakebar.lua
function SnakeBar(fill)
  SnackerBar.build()
  :msg(fill)
  :actionText("")
  :action(function() end)
  :show()
end

--几个变色
function 自适应()
  Tujian.textColor=(转0x(TextColor))
  sologen.textColor=(转0x(TextColor))
  占位.BackgroundColor=(转0x("#42000000"))
  静态渐变((转0x(ThemeColor)),(转0x(ThemeColor)),_drawer_header,"横")
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setNavigationBarColor(转0x(ThemeColor));
end
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setNavigationBarColor(转0x(ThemeColor));

--统计代码
import "java.io.*"
import "java.io.File"
file,err=io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/add.tj")
if err==nil then
 else
  io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/add.tj", "w")end
dq=io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/add.tj"):read("*a")
if dq==os.date("%Y%m%d") then
 else
  Http.get("http://wz4.in/0tx4",nil,nil,nil,function(code,content,cookie,header)end)
  io.open("/sdcard/Android/data/ml.cerasus.pics/cachemain/add.tj","w+"):write("20190511"):close()
end

--保存图片函数
function 归档保存图片(sort)
  判定=Uri.parse(picUrl:sub(1,16));
  if 判定 == "https://img.dpic"then
    if sdk <= 28 == false
      then
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url=Uri.parse(picUrl:sub(1,53));
      request=DownloadManager.Request(url);
      request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
      request.setDestinationInExternalPublicDir("Android/media/ml.cerasus.pics/Tujian",""..sort.."-"..math.random(1,999999999999)..".png");
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
      downloadManager.enqueue(request);
      SnakeBar("开始保存图片至此设备")
     else
      downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
      url=Uri.parse(picUrl:sub(1,53));
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

--句子函数
function 句子()
  local url="https://api.lwl12.com/hitokoto/v1?encode=text&charset=utf-8"
  Http.get(url,cookie,"UTF-8",function(code,body,cookie,header)
    if code==200 then
      dialog=AlertDialog.Builder(this)
      .setTitle("句子")
      .setMessage(body)
      .setPositiveButton("下一句",{onClick=function(v)
          句子()
        end})
      .setNegativeButton("阅毕",nil)
      .setNeutralButton("复制",{onClick=function(v)
          import "android.content.*"
          activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(body)
          SnakeBar("已复制到剪贴板")
        end})
      .show()
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff000000)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff000000)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff000000)
      dialog.create()
    end
  end)
end

--设置壁纸函数
function setWallpaper(biaoti)
  path="/sdcard/Android/data/ml.cerasus.pics/cache/"..biaoti..".jpg"
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
   elseif RomUtil.isMiuiRom() then
    --MIUI
    componentName = ComponentName("com.android.thememanager", "com.android.thememanager.activity.WallpaperDetailActivity");
    intent = Intent("miui.intent.action.START_WALLPAPER_DETAIL");
    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    intent.setDataAndType(Uri.fromFile(File(path)),"image/*");
    intent.putExtra("mimeType","image/*");
    intent.setComponent(componentName);
    activity.startActivity(intent); intent = Intent(Intent.ACTION_ATTACH_DATA)
   else
    --其他
    local intent = Intent(Intent.ACTION_ATTACH_DATA);
    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    intent.setDataAndType(Uri.fromFile(File(path)),'image/*');
    intent.putExtra("mimeType", "image/*");
    activity.startActivity(intent);
  end
end
function setWallpaper1(url,title) --直接传入下载链接和标题就行
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

--颜色转换
function 转0x(颜色)
  if #颜色==7 then
    ab=颜色:match("#(.+)")
    abc=tonumber("0xff"..ab)
   else
    ab=颜色:match("#(.+)")
    abc=tonumber("0x"..ab)
  end
  return abc
end