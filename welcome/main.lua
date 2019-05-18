require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import 'android.support.*'
import "com.androlua.LuaAdapter"
import "org.w3c.dom.Text"
import "android.view.WindowManager"
import "android.widget.TextView"
import "com.androlua.LuaAdapter"
import "android.widget.ImageView"
import "android.widget.ListView"
import "android.support.v7.widget.*"
import "android.widget.GridLayout"
import "android.support.v4.app.*"
import "com.tencent.smtt.sdk.*"
import "android.widget.PopupMenu"
import "android.graphics.*"


fltBtncolor='#607D8B'--悬浮窗颜色
fltBtncolor2='#efefef'--悬浮窗图标颜色

color1='#FFFFFFFF'--页面一背景颜色
image1='zahui/res/icon'--页面一图片路径
title1='Hola!'--页面一标题文字
text1="\n\n欢迎使用 Tujian X-精选壁纸推荐\n\n无人为孤岛，一图一世界"--页面一说明文字
textcolor1='#FF000000'--页面一文字颜色
--下面的同上
color2='#FFFFFFFF'--页面一背景颜色
image2='res/hei'--页面一图片路径
title2=[[


Tujian]]
sologen="无人为孤岛，一图一世界"
text2=[[

Tujian 是我在经历数次找壁纸无果后，与几个朋友共同完成的一款精选图片壁纸软件，每日两张，两个分类，两种风味。

虽然每一天选出的图片至多只有三张，但是全部是投稿者/维护者们的精挑细选。

虽然小众，希望大众。希望你能在享受图片的同时，将 Tujian 也推荐给你的好友，一千个人眼中一千个哈姆雷特，让图片更有内涵。

本应用中的图片均来自于 Unsplash、Pixiv、Coolapk 等网站，社区及论坛且未用于商业行为。若您认为 Tujian 中的图片侵犯了您的合法知识产权，请联系我们。我们将第一时间处理。
]]
textcolor2='#FF000000'


local viewlayout={
  RelativeLayout,
  layout_height="match_parent",
  layout_width="match_parent",
  {
    LinearLayout,
    id='back',
    orientation="vertical",
    layout_width="match_parent",
    layout_height="match_parent",
    {
      PageView,
      layout_width="match_parent",
      id="hd",
      layout_height="match_parent",
      pages={
        {
          RelativeLayout,
          background=color1,
          layout_width="match_parent",
          layout_height="match_parent",
          {
            ImageView,
            id='image1',
            elevation='0dp',
            layout_centerInParent="true",
            background='#FFFFFFFF',
            src=image1,
            layout_width="100dp",
            layout_height="100dp",
          },
          {
            TextView,
            layout_above="image1",
            textSize='70sp',
            textColor=textcolor1,
            text=title1,
            gravity='center',
            layout_width='match_parent',
            layout_height="wrap_content",
            padding='10sp',
            id="Hola";
          },
          {
            TextView,
            layout_below="image1",
            --textSize='30sp',
            textColor=textcolor1,
            Alpha='0.87',
            text=text1,
            gravity='center',
            layout_width='match_parent',
            layout_height="wrap_content",
            padding='5sp',
          },
        },
        {
          ScrollView,
          layout_width="match_parent",
          layout_height="match_parent",
          {
            RelativeLayout,
            background=color2,
            layout_width="match_parent",
            layout_height="match_parent",
            {
              LinearLayout,
              orientation="vertical",
              layout_width="match_parent",
              layout_height="match_parent",
              {
                ImageView,
                id='image2',
                elevation='0dp',
                background='#FFFFFFFF',
                src="res/hei.png",
                layout_marginTop="50dp";
                layout_height="100dp";
                layout_width="100dp";
                layout_gravity="center";
              },
            },
            {
              TextView,
              textSize='60sp',
              layout_below="image2",
              textColor=textcolor2,
              text=title2,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="30dp",
              layout_height="wrap_content",
              layout_marginRight="20dp",
              padding='10sp',
              id="Tujian",
            },
            {
              TextView,
              textSize='20sp',
              layout_below="Tujian",
              textColor=textcolor2,
              text=sologen,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="35dp",
              layout_height="wrap_content",
              layout_marginRight="20dp",
              padding='10sp',
              id="sologen",
            };
            {
              TextView,
              layout_below="sologen",
              textSize='18sp',
              textColor=textcolor2,
              Alpha='0.87',
              text=text2,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="35dp",
              layout_marginRight="35dp",
              layout_height="wrap_content",
              padding='5sp',
            },
          };
        },
      },
    },
  },
  {
    LinearLayout,
    id='tt',
    layout_height="56dp",
    background="#00000000",
    layout_centerHorizontal="true",
    layout_alignBottom="back",
    layout_width="match_parent",
    layout_height="70dp",
    gravity='center',
  },
  {
    CardView,
    id='button',
    layout_column='1',
    layout_width='60dp',
    CardElevation="3dp",
    CardBackgroundColor="#FF000000",
    layout_height='60dp',
    Radius='30dp',
    layout_alignRight="tt",
    layout_alignTop="tt",
    layout_marginRight="20dp",
    layout_marginTop="-20dp",
    {
      ImageView,
      id='imageview',
      src='res/right.png',
      ColorFilter=fltBtncolor2,
      layout_width="wrap_content",
      layout_height="wrap_content",
      layout_gravity="center",
      adjustViewBounds='true',
      maxWidth='30dp',
      maxHeight='30dp',
    },
  };
}


activity.requestWindowFeature(Window.FEATURE_NO_TITLE)
--activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN)
activity.setContentView(loadlayout(viewlayout))


local pag=0
local ppg=0
hd.addOnPageChangeListener{
  onPageScrolled=function(p,pO,pp)
    pag=p
    ppg=pO
    if (pag==0 and tonumber(pO)>=0.1 or pag==1)then
      imageview.setImageBitmap(loadbitmap('res/true.png'))
     else
      imageview.setImageBitmap(loadbitmap('res/right.png'))
    end
  end,
}
button.onClick=function()
  if (pag==0 and tonumber(ppg)>=0.1 or pag==1)then--0和1为页面数，可修改
    activity.finish()
    activity.newActivity("zahui/main.lua")
  end
  hd.showPage(pag+1)
  pag=pag+1
end

--两次退出
参数=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if 参数+2 > tonumber(os.time()) then
      activity.finish()
     else
      参数=tonumber(os.time())
    end
    return true
  end
end

Hola.getPaint().setFakeBoldText(true)
sologen.getPaint().setFakeBoldText(true)
Tujian.getPaint().setFakeBoldText(true)
Tujian.getPaint().setTextSkewX(-0.2)