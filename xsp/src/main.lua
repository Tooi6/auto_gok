--分辨率位1280*720
init("0", 1); --以当前应用 Home 键在右边初始化
local bb = require("badboy")

bb.loadutilslib()
width,height = getScreenSize()
a=height/1280;
b=width/720;
sysLog(a)
sysLog(b)


--刷冒险
function Start_mx()
	--参数设置
	local n=0        --计算局数
	ret,result=showUI("mx_conf.json")
	Num=tonumber(result["Num"])   --得到局数
	if Num==nil then
		Num=999;
	end
	--获得参数
	local F_Mode=false
	local Ed_exit=false
	if result["F_Mode"]=="0" then
		F_Mode=true
		sysLog(tostring(F_Mode))
	end
	if result["Ed_exit"]=="0" then
		Ed_exit=true
		sysLog(tostring(Ed_exit))
	end
	dialog("如果没有点击自动，请自己点一次。")
	
	--判断选好英雄“闯关”界面
	x, y = findColor({937*a, 588*b, 1021*a, 628*b},
		"0|0|0xffffff,10|1|0xf1d19c,15|2|0xfaf1e1,28|1|0xe7a025",
		80, 0, 0, 0)
	if x > -1 then
		while 1 do
			math.randomseed(tostring(os.time()):reverse():sub(1, 7)) --设置时间种子
			sp=math.random(1000,3000);
			keepScreen(true)
			--点击闯关
			x, y = findColor({937*a, 588*b, 1021*a, 628*b},
				"0|0|0xffffff,10|1|0xf1d19c,15|2|0xfaf1e1,28|1|0xe7a025",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--点击自动
			x, y = findColor({1769*a, 24*b, 1820*a, 40*b},
				"0|0|0x235663,0|-7|0x124a5f",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--点击蓝色跳过
			x, y = findColor({1125*a, 60*b, 1144*a, 68*b},
				"0|0|0x2eb0dd,3|-1|0x1b57b0,4|2|0x35bbe2",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--点击黄色跳过
			point = findColors({1170*a, 40*b, 1223*a, 60*b},
				"0|0|0xe6961b,12|11|0xe69a1e,18|10|0xe6981d,30|2|0xffffff",
				80, 0, 0, 0)
			if #point ~= 0 then
				tap(point[1].x,point[1].y)
			end
			--点击任意
			x, y = findColor({565*a, 666*b, 665*a, 687*b},
				"0|0|0xffffff,10|1|0xffffff,19|6|0x233c58,19|-1|0x547999",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--点击再次挑战
			x, y = findColor({1004*a, 644*b, 1122*a, 666*b},
				"0|0|0xf5f4f3,12|1|0xe6a027,22|0|0xb47e1f,23|8|0xe69e24",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				mSleep(3000)
				n=n+1
				sysLog(n)
				--判断局数是否到达
				if n==Num then
					if Ed_exit then
						appid = frontAppName()
						init(appid,0)
						closeApp(appid)
						dialog("已经刷了"..Num.."局")
						lua_exit()
					end
					dialog("已经刷了"..Num.."局")
					lua_exit()
				end
			end
			--点击疲劳
			x, y = findColor({852*a, 483*b, 949*a, 517*b},
				"0|0|0xa61e40,4|-7|0xfae8f0,12|-2|0xbb6d7f",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--上限退出
			--[[x, y = findColor({1197, 401, 1224, 410},
			"0|0|0xd4e4eb,2|0|0xc5d4db",
			95, 0, 0, 0)
		if x > -1 then
			appid = frontAppName()
			init(appid,0)
			closeApp(appid)
			dialog("金币达到上限！")
			lua_exit()
			end]]
			--封号退出
			x, y = findColor({619*a, 478*b, 657*a, 495*b},
				"0|0|0xffffff,4|0|0xffffff,8|0|0xce9223,12|0|0xe3a227",
				98, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			
			if F_Mode then
				mSleep(sp)
			end
			keepScreen(false)
		end
	else
		showUI("error.json");
	end
	
	
end

--送金币
function Send_Gold()
	while 1 do
		--进入好友列表
		x, y = findColor({47*a, 547*b, 79*a, 587*b},
			"0|0|0x003d4e,5|1|0x55d7e8,6|2|0x0f4d5e,11|4|0x34c7d2",
			80, 0, 0, 0)
		if x > -1 then
			tap(x,y)
		end
		
		keepScreen(true)
		--找iphone图标，找到往下滑，没找到送金币
		x, y = findImageInRegionFuzzy("iPhone .png", 60,294*a,71*b,723*a,177*b,0);
		if x ~= -1 and y ~= -1 then        --如果在指定区域找到某图片符合条件
			swip(723*a,177*b,294*a,71*b)
			--sysLog(1)
		else
			x, y = findImageInRegionFuzzy("Gold.png", 60, 294*a,71*b,723*a,177*b, 0);
			if x ~= -1 and y ~= -1 then        --如果在指定区域找到某图片符合条件
				tap(x,y)
			else                               --如果找不到符合条件的图片
				swip(723*a,177*b,294*a,71*b)
				--sysLog(2)
			end
		end
		--送完金币后点击提示框
		x, y = findColor({474*a, 468*b, 560*a, 501*b},
			"0|0|0x349fd8,2|0|0x349fd7,6|-1|0xffffff,16|3|0x2b85b6",
			80, 0, 0, 0)
		if x > -1 then
			tap(x,y)
		end
		x, y = findColor({692*a, 350*b, 755*a, 374*b},
			"0|0|0xcecfe1,5|5|0xcdcee0,15|5|0xcecfe1,19|5|0x131b2b",
			80, 0, 0, 0)
		if x > -1 then
			dialog("今日送金币达到上限")
			lua_exit()
		end
		keepScreen(false)
	end
end

--5v5人机
function Man_machine()
	function PUT_AD()
		--生成随机代码
		math.randomseed(tostring(os.time()):reverse():sub(1, 7)) --设置时间种子
		sp=math.random(41,176)
		sp=string.format("%c",sp)
		ad="免费脚"..sp.."本群:777526018"
		tap(445*a,682*b)
		mSleep(1000)
		tap(392*a,685*b)
		mSleep(500)
		inputText("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）
		inputText(ad);
		mSleep(1000)
		tap(1217*a,668*b)
		mSleep(1000)
		tap(572*a,682*b)
		
	end
	--进入人机
	function into_Game()
		while 1 do
			keepScreen(true)
			--点击对战模式
			x, y = findColor({324*a, 509*b, 390*a, 534*b},
				"0|0|0xded1f0,2|-3|0xe3d8f0",
				95, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("对战")
				mSleep(1000)
			end
			--点击人机练习
			x, y = findColor({1057*a, 210*b, 1096*a, 238*b},
				"0|0|0xdeab78,5|-1|0xc48552,7|-3|0xddb076",
				85, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("人机")
				mSleep(1000)
			end
			--点击5v5
			x, y = findColor({353*a, 484*b, 382*a, 555*b},
				"0|0|0x48161f,0|4|0x4a1821",
				95, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("5v5")
				mSleep(1000)
			end
			--点击入门
			x, y = findColor({253*a, 245*b, 303*a, 260*b},
				"0|0|0xe6a227,-2|7|0xfefefe",
				95, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("入门")
				mSleep(1000)
			end
			--点击开始匹配
			x, y = findColor({648*a, 584*b, 718*a, 607*b},
				"0|0|0xeec06d,0|0|0xeec06d,10|2|0xe7a22b",
				95, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("开始匹配")
				mSleep(1000)
			end
			--点击疲劳
			x, y = findColor({852*a, 483*b, 949*a, 517*b},
				"0|0|0xa61e40,4|-7|0xfae8f0,12|-2|0xbb6d7f",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--点击进入游戏
			x, y = findColor({572*a, 549*b, 673*a, 567*b},
				"0|0|0xf0ca86,1|-1|0xffffff,14|0|0xe4a027",
				95, 0, 0, 0)
			if x > -1 then
				tap(x,y)
				sysLog("进入游戏")
				mSleep(1000)
			end
			x, y = findColor({1133*a, 654*b, 1209*a, 697*b},
				"0|0|0x6d6659,6|2|0x9a9999",
				95, 0, 0, 0)
			if x > -1 then
				sysLog("开始")
				return
			end
			keepScreen(false)
		end
	end
	
	--选英雄模块。
	function Selet_hero(hero_loc_1,hero_loc_2,hero_loc_3)
		--点》
		x, y = findColorInRegionFuzzy(0x187db6, 85, 298*a, 348*b, 309*a, 375*b, 0, 0)
		if x > -1 then
			tap(x,y)
		end
		mSleep(2000)
		--转换hero_loc_1-3为数字
		hero_loc_1=tonumber(hero_loc_1)
		hero_loc_2=tonumber(hero_loc_2)
		hero_loc_3=tonumber(hero_loc_3)
		tap(((hero_loc_1*152)+100)*a,44*b)  --计算，点击英雄类型
		mSleep(1000)
		tap(((hero_loc_3*130)-50)*b,(hero_loc_2*141)*a)  --点击英雄位置
		mSleep(3000)
		--打广告
		PUT_AD()
		mSleep(1000)
		--点击确定
		tap(1173*a,673*b)
		mSleep(500)
		tap(1173*a,673*b)
		sysLog("选完英雄")
	end
	
	--获取血量函数
	function Get_blood()   --x: 585-707    585,215,707,217
		keepScreen(true)
		--获取血量y坐标
		x, y = findColorInRegionFuzzy(0x53d01a, 95, 548*a, 183*b, 716*a, 335*b, 0, 0)
		if x > -1 then
			blood_Y=y
		end
		--计算血量
		if blood_Y~=nil then
			x, y = findColorInRegionFuzzy(0x4c5964, 95, 585*a, blood_Y, 707*a, blood_Y+2, 0, 0)
			if x > -1 then
				return (x-585*a)/(707*a-585*a)
			else
				return 1
			end
		else
			return 2
		end
		
		keepScreen(false)
	end
	
	--向前走sec秒。
	function Go_Ahead(sec,dis)  --167,570,206,457
		touchDown(1, 167*a,570*b)
		mSleep(250)
		touchMove(1, (255+dis)*a,421*b)
		mSleep(sec)
		touchUp(1, (255+dis)*a,421*b)
	end
	
	--向后走sec秒。
	function Go_Back(sec,dis)  --107,567,168,689
		touchDown(1, 161*a,570*b)
		mSleep(250)
		touchMove(1, (119+dis)*a,674*b)
		mSleep(sec)
		touchUp(1, (119+dis)*a,674*b)
	end
	
	--升级技能，买装备
	function up_buy(skill_n)
		if skill_n=="0" then
			--三个技能
			tap(885*a,559*b)
			tap(964*a,429*b)
			tap(1096*a,349*b)
			tap(137*a,294*b)
			sysLog("buy")
		else
			--四个技能
			tap(1135*a,358*b)
			tap(1018*a,379*b)
			tap(923*a,460*b)
			tap(900*a,571*b)
			tap(137*a,286*b)
			sysLog("buy")
		end
	end
	
	--判断是否攻击
	function if_Attack(skill_n)
		--获取自己坐标，判断身边是否有敌人
		x, y = findColorInRegionFuzzy(0x6dd566, 95, 2*a, 5*b, 224*a, 223*b, 0, 0)
		if x > -1 then
			--获取身边敌人
			x, y = findColorInRegionFuzzy(0xd8231c, 95, x-11, y-1, x+20, y+30, 0, 0)
			if x > -1 then
				if skill_n=="0" then
					--三技能
					tap(956*a,633*b)
					tap(1038*a,486*b)
					tap(1156*a,415*b)
				else
					--四技能
					tap(1191*a,421*b)
					tap(1076*a,422*b)
					tap(982*a,523*b)
					tap(957*a,627*b)
					tap(842*a,647*b)
					tap(740*a,644*b)
				end
				--平a
				for i=0,6,1 do
					tap(1172*a,623*b)
				end
			end
		end
		
	end
	
	
	--进入战斗模块
	function start_fight(skill_n)
		tm=0;
		while 1 do
			Blood=1;
			Blood=Get_blood();
			--计时器，升级技能，买装备 模块
			tm=tm+1;
			sysLog(tm)
			if tm>10 then
				up_buy(skill_n)
				tm=0;
			end
			
			math.randomseed(tostring(os.time()):reverse():sub(1, 7)) --设置时间种子
			sp=math.random(-30,30);
			--走路，攻击模块
			if_Attack(skill_n)
			if Blood>0.7 then
				Go_Ahead(200,sp)
			end
			if Blood<0.7 then
				tap(745*a,643*b)
				tap(843*a,644*b)
				Go_Back(5000,sp)
			end
			if_Attack(skill_n)
			--判断死亡 720p
			x, y = findColor({580*a, 5*b, 685*a, 18*b},
				"0|0|0xdecccc,6|1|0x702322,18|-1|0xd7bbba",
				85, 0, 0, 0)
			if x > -1 then
				sysLog("死亡")
				mSleep(20000)
				Go_Ahead(20000,0)
			end
			--点击疲劳
			x, y = findColor({852*a, 483*b, 949*a, 517*b},
				"0|0|0xa61e40,4|-7|0xfae8f0,12|-2|0xbb6d7f",
				80, 0, 0, 0)
			if x > -1 then
				tap(x,y)
			end
			--判断游戏结束
			x, y = findColor({18*a, 22*b, 48*a, 55*b},
				"0|0|0xd9b66b,3|-5|0xf2eaa0",
				95, 0, 0, 0)
			if x > -1 then
				sysLog("游戏结束！")
				mSleep(5000)
				--点击继续
				tap(640*a,666*b)
				mSleep(3000)
				--点击继续2
				tap(640*a,666*b)
				mSleep(3000)
				--点击再来一局
				tap(714*a,680*b)
				return
			end
			
		end
	end
	
	--显示ui，设置局数，英雄。
	ret,result=showUI("Robot.json")
	hero_loc=result["hero_loc"]
	skill_n=result["skill_n"]
	hero_loc_1=hero_loc.sub(hero_loc,1,1)
	hero_loc_2=hero_loc.sub(hero_loc,3,3)
	hero_loc_3=hero_loc.sub(hero_loc,5,5)
	while 1 do
		if hero_loc_1~=nil and hero_loc_2~=nil and hero_loc_3~=nil and skill_n~=nil  then
			--进入人机
			sysLog("into_Game")
			into_Game()
			--选英雄
			sysLog("Selet_hero")
			Selet_hero(hero_loc_1,hero_loc_2,hero_loc_3)
			mSleep(100000)
			sysLog("开始战斗")
			--开始战斗
			up_buy(skill_n)
			Go_Ahead(17000,0)
			start_fight(skill_n)
		else
			dialog("请输入数据",10)
			lua_restart();
		end
		
	end
	
	
end

--判断是否加群
function Check_QQ(QQ_key)
	init("0", 1); --以当前应用 Home 键在右边初始化
	local bb = require("badboy")
	bb.loadluasocket()
	--输入key
	
	--连接服务器发送get请求
	url='http://47.106.136.135:8080/QQ_Group_Service/Search/'..QQ_key
	
	
	local http = bb.http
	local ltn12 = bb.ltn12
	res, code = http.request(url)
	-- 等价于
	-- local response_body = {}
	-- res, code = http.request({
	--    url = 'http://www.baidu.com',
	--    sink = ltn12.sink.table(response_body)
	--  })
	
	if code == 200 then
		
		if res==""  then  --验证成功
			return true;
		else
			--没有加群，显示群号，退出程序
			dialog("请先加群：777526018。\n刚加群的请等一分钟后验证")
			lua_exit()
		end
	end
	
	
end

-------------主程序开始-------------
--判断QQ号是否加群
ret,result=showUI("Check.json")
QQ_key=result["QQ_key"]
Check_QQ(QQ_key)


--通过验证，进入模式选择
ret,result=showUI("Mode.json")
mode=result["mode"]
mode=tonumber(mode)
key=result["key"]
key=tonumber(key)

local switch={
	[0]=function ()
		--mode=0开始冒险
		Start_mx();
	end,
	[1]=function ()
		Send_Gold()
	end,
	[2]=function ()
		Man_machine()
	end,
	
}
f=switch[mode]
--获得模式，判断用户选择的模式
if 1==ret then
	--判断模式
	if (f) then
		f()
	end
else
	dialog("脚本退出！")
end