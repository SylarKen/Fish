<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TCP测试</title>
<jsp:include page="/common.jsp"></jsp:include>
</head>
<body>

  

<h2>TCP测试</h2>
<h3>1.设置心跳包周期</h3>
采集器---ID:<input  id="deviceId1" class="easyui-textbox" name="deviceId" style="width:280px;" value="F7000001"></input><br><br>
心跳周期  (S):<input  id="heartCycle" class="easyui-textbox" name="heartCycle" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="HeartBeat()">设置心跳包周期</a>

<h3>2.添加溶氧度传感器(传感器modbus地址    高阈值   低阈值   采集周期   继电器地址)</h3>
采集器---ID:<input  id="deviceId3" class="easyui-textbox" name="deviceId" style="width:280px;" value="F7000001"></input><br><br>
传感器---ID:<input  id="sensor" class="easyui-textbox" name="sensor" style="width:280px;"></input><br><br>
高阈值(mg/L):<input  id="max" class="easyui-textbox" name="max" style="width:280px;"></input><br><br>
低阈值(mg/L):<input  id="min" class="easyui-textbox" name="min" style="width:280px;"></input><br><br>
采集周期  (S):<input  id="query" class="easyui-textbox" name="query" style="width:280px;"></input><br><br>
继电器地址:<input  id="relay" class="easyui-textbox" name="relay" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="AddOxygen()">设置增氧机阈值</a>

<h3>3.删除溶氧度传感器(传感器modbus地址)</h3>
采集器---ID:<input  id="deviceId4" class="easyui-textbox" name="deviceId4" style="width:280px;" value="F7000001"></input><br><br>
传感器---ID:<input  id="sensor1" class="easyui-textbox" name="sensor1" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="DeleteOxygen()">删除溶氧度传感器</a>

<h3>4.读取溶氧度传感器(传感器modbus地址)状态</h3>
采集器---ID:<input  id="deviceId5" class="easyui-textbox" name="deviceId5" style="width:280px;" value="F7000001"></input><br><br>
传感器---ID:<input  id="sensor2" class="easyui-textbox" name="sensor2" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="ReadOxygen()">读取溶氧度传感器</a>

<h3>5.读取增氧机的状态</h3>
采集器----ID:<input  id="deviceId6" class="easyui-textbox" name="deviceId6" style="width:280px;" value="F7000001"></input><br><br>
对应溶氧量传感器ID:<input  id="sensor3" class="easyui-textbox" name="sensor3" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="ReadOxygenAdd()">读取增氧机的状态</a>

<h3>6.读取投饵机状态</h3>
采集器----ID:<input  id="deviceId7" class="easyui-textbox" name="deviceId7" style="width:280px;" value="F7000001"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="ReadFeeder()">读取投饵机的状态</a>
<input id="device_add_typeCode" class="easyui-textbox"  name="typeCode" >
<h3>7.除污功能</h3>
采集器----ID:<input  id="deviceId8" class="easyui-textbox" name="deviceId8" style="width:280px;" value="F7000001"></input><br><br>
除污周期:<input  id="scrubbingCycle" class="easyui-textbox" name="scrubbingCycle" style="width:280px;" ></input><br><br>
除污时间:<input  id="scrubbingTime" class="easyui-textbox" name="scrubbingTime" style="width:280px;"></input><br><br>
<a href="#" class="easyui-linkbutton c1" style="width:120px"  onclick="Scrubbing()">除污设置</a>


<script type="text/javascript">
$(function (){
	$('#device_add_typeCode').textbox({  
		validType:"number" ,
		events:{
			blur: function(){
			    var typeCode =  $('#device_add_typeCode').val();
			    if(!((200<=typeCode) && (typeCode<=300))){
			    	alert("123");
			    }
			    
			 }} 
			
	});
});



function HeartBeat(){
	var deviceId = $("#deviceId1").val()+"000B";//000B:心跳包的项目类型
	var heartCycle = $("#heartCycle").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_HEARTBEAT",//设置心跳包的时间
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, heartCycle : heartCycle }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 5000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}




function AddOxygen(){
	var deviceId = $("#deviceId3").val()+"0151";//0151:添加溶氧传感器的项目类型
	var sensor = $("#sensor").val();//   
	var max = $("#max").val();
	var min = $("#min").val();
	var query = $("#query").val();
	var relay = $("#relay").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_ADDOXYGEN",//添加溶氧度传感器
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, sensor:sensor, max : max, min : min ,query:query ,relay:relay }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 10000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}

function DeleteOxygen(){
	var deviceId = $("#deviceId4").val()+"0151";//0155数据采集周期项目类型  84 删除成功后
	var sensor1 = $("#sensor1").val();

	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_DeleteOxygen",//设置采集周期
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, sensor : sensor1 }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 10000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}
//ReadOxygen
function ReadOxygen(){
	var deviceId = $("#deviceId5").val()+"0151";//0151数据采集周期项目类型  82 删除成功后
	var sensor2 = $("#sensor2").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_ReadOxygen",//设置采集周期
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, sensor : sensor2 }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 10000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}


function OxygenState(){
  	var deviceId = $("#deviceId6").val()+"0156";//41读取  0156增氧机的项目类型 
  	var sensor3 = $("#sensor3").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/READ_OxygenState",//
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId ,sensor:sensor3}, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 5000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}


function FeederState(){
  	var deviceId = $("#deviceId4").val()+"020141";//41读取  0201投饵机的项目类型 
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/READ_FEEDER",//
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 5000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}



function Scrubbing(){
	var deviceId = $("#deviceId8").val()+"0211";//除污 
	var scrubbingCycle = $("#scrubbingCycle").val();//  
	var scrubbingTime = $("#scrubbingTime").val();
	
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_SCRUBBING",//
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId ,scrubbingCycle:scrubbingCycle,scrubbingTime:scrubbingTime}, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 5000,
		success:function(data){
			if(data.ok){
				$.messager.alert("温馨提示", "操作成功！");
				index1_queryDevice();
			}else{
				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
			}
			$(dom).css("cursor", "pointer");
		},
		error:function(data){
			$.messager.alert("温馨提示", "网络访问出错！");
			$(dom).css("cursor", "pointer");
		}
	});
}
</script>
</body>
</html>