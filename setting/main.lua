require"import"
import "cjson"
import "module"
import "android.os.*"
import "android.app.*"
import "android.view.*"
import "android.widget.*"
import "android.graphics.*"
import "android.content.Context"
import "android.graphics.drawable.*"
import "muk"
import "android.graphics.drawable.*"
import "Createlite@Tujian@SnakerBar"
import "android.content.pm.ActivityInfo"

隐藏标题栏()

activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)--禁止横屏


--导入布局&设置标题
--import "layout"
activity.title="设置"
local main = {
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  orientation="vertical";
  {
    ListView,
    id="listView",
    DividerHeight=0;
    layout_width="fill",
    layout_height="fill",
  }
}

switchtheme("自动",main)

--返回按钮
activity.ActionBar.setDisplayHomeAsUpEnabled(true)
onOptionsItemSelected=function()
  activity.finish()
end


if this.getSharedData("自动更新") == nil then
  this.setSharedData("自动更新","false")
end
if this.getSharedData("一言一句") == nil then
  this.setSharedData("一言一句","false")
end


data = {}
import "setting.setting"
adp=LuaMultiAdapter(this,data,setting)
adp.add{__type=1,title="主题"}
adp.add{__type=2,subtitle="主题配色",message="设置软件的主题陪色"}
adp.add{__type=2,subtitle="界面风格",message="设置软件的界面风格"}
adp.add{__type=1,title="应用"}
adp.add{__type=2,subtitle="分享软件",message="将软件分享给好友"}
adp.add{__type=4,subtitle="自动更新",message="软件启动时检测新版",status={Checked=Boolean.valueOf(this.getSharedData("自动更新"))}}
adp.add{__type=1,title="其他"}
adp.add{__type=5,subtitle="一言一句",status={Checked=Boolean.valueOf(this.getSharedData("一言一句"))}}
adp.add{__type=3,subtitle="关于软件"}
listView.setAdapter(adp)


--列表点击事件
listView.setOnItemClickListener(AdapterView.OnItemClickListener{

  onItemClick=function(id,v,zero,one)

    if v.Tag.status ~= nil then
      if v.Tag.status.Checked then
        this.setSharedData(v.Tag.subtitle.Text,"false")
        data[one].status["Checked"]=false
       else
        this.setSharedData(v.Tag.subtitle.Text,"true")
        data[one].status["Checked"]=true
      end

      Toast(v.Tag.subtitle.Text)
      Toast(v.Tag.status.Checked)--带开关列表项事件

     else

      Toast(v.Tag.subtitle.Text)--其他列表点击事件

    end

    adp.notifyDataSetChanged()--更新列表
  end})

