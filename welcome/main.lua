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
import "muk"
import "android.graphics.*"
import "android.content.pm.ActivityInfo"
import "Createlite@Tujian@SnakerBar"

隐藏标题栏()

sdk = tointeger(Build.VERSION.SDK)

if tointeger(sdk) <= 28
  then
  申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})
end

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏

activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)

--[[
代码大约50%原创，其中很大一部分是在 @MUK 的思路下完成的
源代码是 @Luxts 的欢迎页，这里被我做了不少改动...
]]

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

color3='#FFFFFFFF'
image3='res/hei'--页面一图片路径
title3=[[



隐私政策]]
sologen3="请您仔细阅读并同意"
text3=[[

图鉴（以下统称“本应用”）尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。但本应用将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于本应用服务使用协议不可分割的一部分。

1.适用范围

  (a) 在您注册本应用帐号时，您根据本应用要求提供的个人注册信息；

  (b) 在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；

  (c) 本应用通过合法途径从商业伙伴处取得的用户个人数据。

您了解并同意，以下信息不适用本隐私权政策：

  (a) 您在使用本应用平台提供的搜索服务时输入的关键字信息；

  (b) 本应用收集到的您在本应用发布的有关信息数据，包括但不限于参与活动、成交信息及评价详情；

  (c) 违反法律规定或违反本应用规则行为及本应用已对您采取的措施。

2.信息使用

  (a)本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和本应用（含本应用关联公司）单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。

  (b) 本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。

  (c) 为服务用户的目的，本应用可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与本应用合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。

3.信息披露

在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：

  (a) 经您事先同意，向第三方披露；

  (b)为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；

  (c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；

  (d) 如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；

  (e) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；

  (f) 在本应用平台上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，本应用有权决定向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决；

  (g) 其它本应用根据法律、法规或者网站政策认为合适的披露。

4.信息存储和交换

本应用收集的有关您的信息和资料将保存在本应用及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本应用收集信息和资料所在地的境外并在境外被访问、存储和展示。

5.Cookie的使用

  (a) 在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。

  (b) 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。

  (c) 通过本应用所设cookies所取得的有关信息，将适用本政策。

6.信息安全

  (a) 本应用帐号均有安全保护功能，请妥善保管您的用户名及密码信息。本应用将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。

  (b) 在使用本应用网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请妥善保护自己的个人信息，仅在必要在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是用户名及密码发生泄露，请您立即联络我们（Chimon@Chimon.me），以便我们采取相应措施。

7.本隐私政策的更改

  (a) 如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。

  (b) 本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。

  图鉴事务所 2019/03/20

]]
textcolor3='#FF000000'

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
        {
          ScrollView,
          layout_width="match_parent",
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
                id='image3',
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
              textSize='45sp',
              layout_below="image3",
              textColor=textcolor3,
              text=title3,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="30dp",
              layout_height="wrap_content",
              layout_marginRight="20dp",
              padding='10sp',
              id="Tujian3",
            },
            {
              TextView,
              textSize='20sp',
              layout_below="Tujian3",
              textColor=textcolor3,
              text=sologen3,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="32dp",
              layout_height="wrap_content",
              layout_marginRight="20dp",
              padding='10sp',
              id="sologen3",
            };
            {
              TextView,
              layout_below="sologen3",
              textSize='18sp',
              textColor=textcolor3,
              Alpha='0.87',
              text=text3,
              gravity='left',
              layout_width='match_parent',
              layout_marginLeft="35dp",
              layout_marginRight="35dp",
              layout_height="wrap_content",
              padding='5sp',
            },
          },
        };
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
    if (pag==1 and tonumber(pO)>=0.1 or pag==2)then
      imageview.setImageBitmap(loadbitmap('res/true.png'))
     else
      imageview.setImageBitmap(loadbitmap('res/right.png'))
    end
  end,
}
button.onClick=function()
  if (pag==1 and tonumber(ppg)>=0.1 or pag==2)then--1和2为页面数，可修改
    activity.finish()
    activity.newActivity("zahui/main.lua",{"nil"})
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
sologen3.getPaint().setFakeBoldText(true)
Tujian.getPaint().setFakeBoldText(true)
Tujian.getPaint().setTextSkewX(-0.2)
Tujian3.getPaint().setFakeBoldText(true)
Tujian3.getPaint().setTextSkewX(-0.2)

--针对（可能）锤子水波纹问题
sdk = tointeger(Build.VERSION.SDK)
if sdk < 28 then
  activity.setTheme(android.R.style.Theme_Material_Light)
end

--Snakebar函数，具体代码请见根目录Snakebar.lua
function SnakeBar(fill)
  SnackerBar.build()
  :msg(fill)
  :actionText("")
  :action(function() end)
  :show()
end
