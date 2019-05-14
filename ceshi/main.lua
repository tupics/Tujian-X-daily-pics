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
import "ceshi.mluafloatingbutton"--此悬浮按钮最好一个页面只放一个(打脸滑稽
import "com.github.ksoichiro.android.observablescrollview.*"--导入ObservableScrollView，容易监听滑动
import "muk"--导入中文函数
import "android.graphics.Paint"
import "android.graphics.*"
import "android.graphics.drawable.*"
import "android.graphics.Color"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.Animation"
import "android.view.animation.AlphaAnimation"
import "android.widget.RatingBar"
import "android.widget.NumberPicker"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.AnimationSet"

隐藏标题栏()

语言=Locale.getDefault().getLanguage()

ThemeColor,TextColor=...--接收主页传来的主题配色

--设置颜色变量便于调用
primaryc="#ff000000"
write="#ffffffff"
viewshaderc="#3f000000"
textc="#212121"
b="#ff000000"
w="#ffffffff"
--[[
--状态栏沉浸，Android SDK>19时生效
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
]]

--完全沉浸，SDK>21
if ThemeColor == "FF000000" or ThemeColor == "ff000000" then--防止全白
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(转0x("#FF757575"));
  ThemeColor="#FF757575"
 else
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(转0x(ThemeColor));
end

状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)

--布局表
layout={
  --页面布局
  LinearLayout;
  layout_height="-1";
  layout_width="-1";
  id="_root";
  orientation="vertical";
  {
    RelativeLayout;--RelativeLayout中
    layout_height="-1";
    layout_width="-1";
    background=w;
    {
      LinearLayout;
      layout_height="-1";
      layout_width="-1";
      orientation="vertical";
      {
        ObservableScrollView;
        layout_width="-1";
        layout_height="-1";
        id="obs_1";
        overScrollMode=2;
        {
          LinearLayout;
          layout_height="-1";
          layout_width="-1";
          orientation="vertical";
          --paddingTop=dp2px(200)+状态栏高度;--抵消顶部遮盖部分高度
          {
            LinearLayout;
            layout_height="200dp";
            layout_width="-1";
            background=ThemeColor;
            {
              ImageView;
              layout_height="-1";
              layout_width="-1";
              src="ceshi/res/photo.png";
              scaleType="centerCrop";
              id="pho_top";
              ColorFilter=ThemeColor；
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv1_lay";
              {
                TextView;
                Text="概述";
                textColor=primaryc;
                textSize="16sp";
                id="概述"
              };
              {
                TextView;
                Text=[[
   「无人为孤岛，一图一世界」

    Tujian 是我在经历数次找壁纸无果后，与几个朋友共同完成的一款精选图片壁纸软件，每日两张，两个分类，两种风味。

    虽然每一天选出的图片至多只有三张，但是全部是投稿者/维护者们的精挑细选。

    虽然小众，希望大众。希望你能在享受图片的同时，将 Tujian 也推荐给你的好友，一千个人眼中一千个哈姆雷特，让图片更有内涵。

    本应用开发过程中，感谢 Tujian开发组 各位的支持！]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="概述内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv10_lay";
              {
                TextView;
                Text="版权声明";
                textColor=primaryc;
                textSize="16sp";
                id="版权"
              };
              {
                TextView;
                Text=[[
    Tujian 所选用的图片来自于 Unsplash、Pixiv、Cookapk 等社区、网站及论坛，且并非用于商业行为。

    若您认为我们侵犯了您的合法知识产权，请发送邮件至 Chimon@Chimon.me，我们会第一时间配合处理。]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="版权内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv11_lay";
              {
                TextView;
                Text="查看官网";
                textColor=primaryc;
                textSize="16sp";
                id="官网"
              };
              {
                TextView;
                Text=[[点按了解更多信息]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="官网内容";
              };
            };
          };

          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv3_lay";
              {
                TextView;
                Text="加入 QQ 群组";
                textColor=primaryc;
                textSize="16sp";
                id="QQ群"
              };
              {
                TextView;
                Text=[[点按以加入 QQ 群组]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="QQ群内容";
              };
            };
          };

          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv4_lay";
              {
                TextView;
                Text="Telegram 群组";
                textColor=primaryc;
                textSize="16sp";
                id="Tg群"
              };
              {
                TextView;
                Text=[[点按以加入 Telegram 群组]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="Tg群内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv5_lay";
              {
                TextView;
                Text="Telegram 推送服务";
                textColor=primaryc;
                textSize="16sp";
                id="推送"
              };
              {
                TextView;
                Text=[[点按以加入 Telegram 图片推送频道]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="推送内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv6_lay";
              {
                TextView;
                Text="Android 绿色应用公约";
                textColor=primaryc;
                textSize="16sp";
                id="绿色公约"
              };
              {
                TextView;
                Text=[[Tujian X 已经完全适配了「Android 绿色应用公约」并且通过审核
                
点按以了解更多信息]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="绿色公约内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv7_lay";
              {
                TextView;
                Text="Tujian 隐私政策";
                textColor=primaryc;
                textSize="16sp";
                id="隐私政策"
              };
              {
                TextView;
                Text=[[点按以查看 Tujian 隐私政策]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="隐私政策内容";
              };
            };
          };
          {--卡片
            CardView;
            background=write;
            layout_height="-2";
            layout_width="-1";
            onClick=function()end;
            layout_margin="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              orientation="vertical";
              padding="16dp";
              id="cv8_lay";
              {
                TextView;
                Text="Open Tujian-开源相关";
                textColor=primaryc;
                textSize="16sp";
                id="开源"
              };
              {
                TextView;
                Text=[[点按以查看 Tujian 开源项目列表]];
                textColor=textc;
                textSize="14sp";
                paddingTop="4dp";
                id="开源内容";
              };
            };
          };

        };
      };
    };

    {--顶栏布局（背景)
      LinearLayout;
      layout_height="-2";
      layout_width="-1";
      background=ThemeColor;
      elevation="4dp";
      orientation="vertical";
      id="_topbar";
      {--状态栏占位布局
        TextView;
        layout_height=状态栏高度;
        layout_width="-1";
      };
      {--标题栏布局（背景)
        LinearLayout;
        layout_height="56dp";
        layout_width="-1";
        id="_topbar_top";
        background=ThemeColor;
      };
    };
    {--顶栏布局（标题）
      LinearLayout;
      layout_height="200dp";
      layout_width="-1";
      elevation="4dp";
      orientation="vertical";
      --     background=ThemeColor;
      id="_topbar2";
      {--状态栏占位布局
        TextView;
        layout_height=状态栏高度;
        layout_width="-1";
      };

      {--标题栏布局
        LinearLayout;
        layout_height="-1";
        layout_width="-1";
        gravity="left|bottom";
        orientation="vertical";
        {
          LinearLayout;
          layout_height="-1";
          layout_width="-1";
          gravity="left|top";
          layout_weight="1";
          {
            ImageView;
            layout_width="56dp";
            layout_height="56dp";
            padding="16dp";
            ColorFilter=TextColor;
            src="ceshi/res/back";
            onClick=function()关闭页面()end;
            id="_back";
          };
        };
        {
          TextView;
          Text="关于";
          textColor=TextColor;
          textSize="20sp";
          paddingLeft="16dp";
          layout_height="56dp";
          id="_title";
          gravity="left|center";
          PivotX=0;
          PivotY="56dp";
          ScaleX=1.6;
          ScaleY=1.6;
        };
      };
    };
    {--顶栏布局（悬浮按钮）
      LinearLayout;
      layout_height="244dp";
      layout_width="-1";
      elevation="4dp";
      orientation="vertical";
      id="_topbar3";
      gravity="right|bottom";
      {
        MLuaFloatingButton--悬浮按钮(函数,打脸滑稽
        {
          size=0;
          layout_margin="16dp";
          background=b;
          elevation="4dp";
          elevationClick="10dp";
          id="_mfb";
          src="ceshi/res/open";
          iconColor=w;
          rippleColor="#3fffffff";
        };
        id="_mfb_w";
      };
    };
  };
};


设置视图(layout)
品牌=Build.BRAND
if 品牌 == "Smartisan" then
 else
  波纹({cv1_lay},"方黑")
  波纹({cv2_lay},"方白")
  波纹({cv3_lay},"方黑")
  波纹({cv4_lay},"方黑")
  波纹({cv5_lay},"方黑")
  波纹({cv6_lay},"方黑")
  波纹({cv7_lay},"方黑")
  波纹({cv8_lay},"方黑")
  波纹({cv10_lay},"方黑")
  波纹({cv11_lay},"方黑")
  波纹({_back},"圆白")
end
_topbar.alpha=0

_mfbb=true

obs_1.setScrollViewCallbacks(ObservableScrollViewCallbacks{
  --滚动时
  onScrollChanged=function(scrollY,firstScroll,dragging)
    obs1_lst_lst=obs1_lst
    obs1_lst=scrollY
    if obs1_lst_lst==nil then
      obs1_lst_lst=obs1_lst
    end
    apa=1-(obs1_lst/(dp2px(200-56)-状态栏高度))
    apb=1-(obs1_lst/dp2px(244-56-16-16))
    if apa<=0 then
      _topbar.alpha=1
     else
      _topbar.alpha=0
    end
    pho_top.alpha=apa
    if apa>=0 then
      _title.setY(apa*(dp2px(200-56)-状态栏高度))
      _title.setX((1-apa)*dp2px(56)+0.6*apa)
      _title.setScaleY(1+(0.6*apa))
      _title.setScaleX(1+(0.6*apa))
      --_title.setPivotX(0)
      --_title.setPivotY(_title.getHeight())
      _mfb_w.setY(apb*(dp2px(244-56-16-16)))
      if not mfbb then
        MFBshow(_mfb)
        mfbb=true
        mfblst=false
      end
     else
      _title.setY(0)
      _title.setX(dp2px(56))
      _title.setScaleY(1)
      _title.setScaleX(1)
      if mfbb and not mfblst then
        mfblst=false
        MFBhide(_mfb)
        mfbb=false
      end
      mfblst=true
    end
  end,

  --按下
  onDownMotionEvent=function()
  end,

  --拖拽结束或者取消时
  onUpOrCancelMotionEvent=function(scrollState)
    --[[if tostring(scrollState)=="UP" and obs1_lst<=dp2px(200) and obs1_lst>=5 then
      local scrollYu = ObjectAnimator.ofInt(obs_1, "scrollY", {obs_1.scrollY,dp2px(200-55)-状态栏高度})
      scrollYu.setDuration(512)
      scrollYu.setInterpolator(DecelerateInterpolator());
      scrollYu.start()
    end
    if tostring(scrollState)=="DOWN" and obs1_lst<=dp2px(200) and obs1_lst>=5 then
      local scrollYu = ObjectAnimator.ofInt(obs_1, "scrollY", {obs_1.scrollY,0})
      scrollYu.setDuration(512)
      scrollYu.setInterpolator(DecelerateInterpolator());
      scrollYu.start()
    end]]
  end
})

_mfb.onClick=function()
  url="https://tupics.github.io/"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

function 返回顶部()--平滑返回顶部
  local scrollYu = ObjectAnimator.ofInt(obs_1, "scrollY", {obs_1.scrollY,0})
  scrollYu.setDuration(512)
  scrollYu.setInterpolator(DecelerateInterpolator());
  scrollYu.start()
end

--[[


MLua模板 by MUK


]]
_title.getPaint().setFakeBoldText(true)
概述.getPaint().setFakeBoldText(true)
推送.getPaint().setFakeBoldText(true)
Tg群.getPaint().setFakeBoldText(true)
QQ群.getPaint().setFakeBoldText(true)
隐私政策.getPaint().setFakeBoldText(true)
绿色公约.getPaint().setFakeBoldText(true)
开源.getPaint().setFakeBoldText(true)
官网.getPaint().setFakeBoldText(true)
版权.getPaint().setFakeBoldText(true)


pho_top.setColorFilter(转0x(ThemeColor))

--[[
PS：Tujian 所选用的图片来自于 Unsplash、Pixiv、Cookapk 等社区、网站及论坛，且并非用于商业行为。
若您认为我们侵犯了您的合法知识产权，请发送邮件至 Chimon@Chimon.me，我们会第一时间配合处理。
]]


--[[
--退出动画开始
kbl=...--接受在杂烩设置的空变量
参数=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if 参数+2 > tonumber(os.time()) then
      activity.finish()
     else
      kbl1="空变量"
      activity.newActivity("zahui/main.lua",android.R.anim.fade_in,android.R.anim.fade_out,{kbl1})
      activity.finish()
      参数=tonumber(os.time())
    end
    return true
  end
end
--动画代码不稳定，未开放
]]


--语言设置开始
if
  语言=="zh"==false
  and
  语言=="zh_CN"==false
  and
  语言=="zh_HK"==false
  and
  语言=="zh_TW"==false
  then
  控件隐藏(cv10_lay)
  _title.Text="About"
  概述.Text="Main"
  推送.Text="Push"
  官网.Text="Official Website"
  Tg群.Text="Telegram Group"
  开源.Text="Open Source"
  QQ群.Text="QQ Group"
  绿色公约.Text="Green-Android Project"
  隐私政策.Text="Privacy"
  概述内容.Text=[[Tujian X is a Wallpapers Recommendation Application.

Our thoughts is “Nobody is an island，a picture contain one world”

I wrote it in my spare time with some other developers.We are all students from China.

Well, Enjoy the meaning of the pictures now!]]
  推送内容.Text="Picture push service in Telegram"
  Tg群内容.Text="Join our Telegram Group"
  QQ群内容.Text="Join our QQ Group"
  绿色公约内容.Text=[[Green-Android Project is held to make Android phones in China can have a longer using time and it is founded by oasisfeng,who is the developer of Greenify.

Now Tujian X has already supported the Project and pass the authentication.]]
  官网内容.Text="Click to learn more information"
  隐私政策内容.Text="Click to learn more information"
  开源内容.Text="Click to learn more about Open Tujian-Tujian Open source"
end

--点击事件开始
cv1_lay.onClick=function()
  if
    语言=="zh"or
    语言=="zh_CN"or
    语言=="zh_HK"or
    语言=="zh_TW"
    then
    print("无人为孤岛，一图一世界")
   else
    print("Nobody is an island,a picture contain one world.")
  end
end

cv3_lay.onClick=function()
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=472863370&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
  if
    语言=="zh"or
    语言=="zh_CN"or
    语言=="zh_HK"or
    语言=="zh_TW"
    then
    print("若加入失败，请检查是否安装了最新版本 QQ")
   else
    print("If failed, please install QQ")
  end
end
cv4_lay.onClick=function()
  url="https://t.me/RutuGroup"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end


cv5_lay.onClick=function()
  url="https://t.me/Tujiansays"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

cv6_lay.onClick=function()
  url="https://green-android.org/"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

cv7_lay.onClick=function()
  url="https://dpic.dev/licenses/privacy"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

cv8_lay.onClick=function()
  url="https://open.dpic.dev/"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

cv11_lay.onClick=function()
  url="https://tupics.github.io/"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
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