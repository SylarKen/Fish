<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网络配置</title>
<jsp:include page="/common.jsp"></jsp:include>
</head>
<body>
<style >
#sensorNet_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#sensorNet_search_form .conditionSpan input,select {
	width:100px;
}
</style>
	<div class="easyui-layout" style="width:98%;height:100%;" data-options="fit:true">
		<div region="west" split="true" title="采集器列表" style="width:25%;">
			<div class="conditionSpan" style="padding-top: 1%;padding-bottom: 0.9%;height:3%;width: 100%"">
						<!-- <a class="easyui-linkbutton" onclick="parameter_setting()"  style="height:100%;margin-left: 1%">采集器通用参数设置</a> -->
						<div class="easyui-panel">
							<a href="#" class="easyui-menubutton" data-options="menu:'#mm2'">采集器通用参数设置</a>
						</div>
						<div id="mm2" style="width:100px;">
							<div onclick="showHeartBeatDailog()" data-options="iconCls:'icon-award_star_bronze_1'">心跳包周期</div>
						</div>		
			</div>
			<div style="height:96%;width: 100%">
				<table id="sensorNet_left_category_tree" ></table>
			</div>
		</div>
	<div region="center"  >
			<div class="easyui-layout" data-options="border:false,fit:true">		
				<div data-options="region:'north',border:false" style="height:7%;">
					<form id="sensorNet_search_form" style="margin:1% 5px;">					
					<input id="sensorNet_deptCode" type="hidden" name="deptCode" />
					<input id="sensorNet_grade" type="hidden" name="grade" />
					<div >
					<span class="conditionSpan">
						<span >传感器ID：</span>
						<input class="easyui-textbox" name="deviceIdOxygen" />
					</span>
					<span class="conditionSpan">
						<a class="easyui-linkbutton" onclick="sensorID_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
					</span>
				</div>	
					</form>
				</div>
				<div data-options="region:'center',border:false" style="width:100%;">
					<div id = "tabsCenter" class="easyui-tabs" style="width:100%;height:100%" >
							<div  title="配置溶氧度传感器" style="padding:1px;width: 99%;height:96.2%">
							    <div id="sensorNet_right_list"></div>
							</div>
							<!-- <div title="配置PH传感器" style="padding:1px;width: 99%;height:96.2%">
							</div> -->
				   </div>			
				</div>
			</div>
		</div>
	</div>

<script>
var products_url;
var flag_Tree;
$(function(){
	//遍历左边的树--养殖点
	$('#sensorNet_left_category_tree').treegrid({
	    url: '<%=basePath%>sensorNet/query',
	    idField: 'code',
	    treeField: 'name',
	    fit: true,
	    fitColumns: true,
	    singleSelect: true,
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'code',
	    columns:[[
			{title:'编码', field:'code', width:100},
			{title:'名称', field:'name', width:180},
			{title:'层级', field:'grade', hidden:true},
			{title:'状态', field:'is_online',formatter: function(value, row) {
				if (value == 1) return '<span style=color:green;>在线</span>';
				if (value == 0) return '<span style=color:red;>离线</span>';
			}, width:40},
			{
				title: '是否可用',
				field: 'delete_flag',
				width: 150,
				formatter: function(value, row) {
					if (value == 0) return '可用';
					if (value == 1) return '<span style=color:red;>不可用</span>';
				}, hidden:true
			}
	    ]],
		onSelect : function(node) {	
			$("#sensorNet_deptCode").val(node.code);
			$("#sensorNet_grade").val(node.grade);
			sensorID_search();
		},
		onLoadSuccess : function(row, data) {
			//console.log(data)
			if (data && data.rows && data.rows.length > 0) {
				var firstCode = data.rows[0].code;
				$('#sensorNet_left_category_tree').treegrid("select", firstCode) ;
			}
		}  
    });
	
	 flag_Tree=setInterval(function (){	
		var node = $('#sensorNet_left_category_tree').treegrid("getSelected");
		$('#sensorNet_left_category_tree').treegrid({
		    url: '<%=basePath%>sensorNet/query',
		    idField: 'code',
		    treeField: 'name',
		    fit: true,
		    fitColumns: true,
		    singleSelect: true,
			pagination: true,
			pageSize: 20, // 每一页多少条数据
			pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
			sortName: 'code',
		    columns:[[
				{title:'编码', field:'code', width:100},
				{title:'名称', field:'name', width:180},
				{title:'层级', field:'grade', hidden:true},
				{title:'状态', field:'is_online',formatter: function(value, row) {
					if (value == 1) return '<span style=color:green;>在线</span>';
					if (value == 0) return '<span style=color:red;>离线</span>';
				}, width:40},
				{
					title: '是否可用',
					field: 'delete_flag',
					width: 150,
					formatter: function(value, row) {
						if (value == 0) return '可用';
						if (value == 1) return '<span style=color:red;>不可用</span>';
					}, hidden:true
				}
		    ]],
			onSelect : function(node) {	
				$("#sensorNet_deptCode").val(node.code);
				$("#sensorNet_grade").val(node.grade);
				sensorID_search();
			},
			onLoadSuccess : function(row, data) {
				//console.log(data)
				$('#sensorNet_left_category_tree').treegrid("select", node.code) ;
			}  
	    });
		//$('#sensorNet_left_category_tree').treegrid("select", node.code) ;
	}, 20000); 
	
	
	
	var treeSel;
	var treeCode;
	$('#sensorNet_right_list').datagrid({
		onBeforeLoad:function(){
			//只有在左侧有行被选中，才会加载数据
			treeSel = $('#sensorNet_left_category_tree').treegrid("getSelected");
			if(!treeSel){
				return false;
			}
		},
	    url: webContext + 'sensorNet/getSensors',
	    fit: true,
	    fitColumns: false,
	    nowrap: true,
	   // collapsible: true,
	    pagination: true,
	    autoRowHeight: false,
	    idField: 'deviceIdOxygen',
	    striped: true, //奇偶行是否区分
	    singleSelect: true,//单选模式
	    rownumbers: true,//行号
	    remoteSort: true,
	    sortName: 'deviceIdOxygen',
	    pageSize: 20, //每一页多少条数据
	    pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
	    //queryParams: { deptCode: treeCode}, //传递到后台的参数
	    columns: [[
            { field: 'ck', checkbox: true },
            { field: 'collectorId', title: '采集器ID ', hidden:true},
            { field: 'deviceIdOxygen', title: '传感器ID ', width: 160},
            { field: 'deviceIdOxygenName', title: '传感器名称', width: 160 },
            { field: 'deviceIdRelay', title: '继电器ID', width: 160 },
            { field: 'deviceIdRelayName', title: '继电器名称', width: 160 },
            { field: 'high_value', title: '溶氧度高阈值(mg/L)', width: 130 },
            { field: 'low_value', title: '溶氧度低阈值(mg/L)', width: 130 },
            { field: 'collect_cycle', title: '采集周期(S)', width: 130 },
            { field: 'insertTime', title: '创建时间', width: 180,formatter:function(value, row){return timeFormatter(value);} }
			
	    ]],
	    toolbar:[
	    {
	        url: "sensorNet/add",  
			text:'配置',
			iconCls:'icon-add',
			handler:function(){
				showSensorNetAddDailog();
	        }
		},{
			url: 'sensorNet/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRows = $('#sensorNet_right_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				if (selectedRows.length > 1) {
					$.messager.alert("温馨提示", "请选择一行！");
					return;
				}
				
			}
		},{
			url: "sensorNet/delete",
			text:'删除',
			iconCls:'icon-delete',
			handler:function(){
				var selectRows = $('#sensorNet_right_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				deleteDetailDailog(selectRows[0]);
		    }
		}]
	});
	
	actionButtonCtr('sensorNet_right_list');   
        
});


//网络配置溶氧度传感器 is_online
var $dialog;
function showSensorNetAddDailog() {
		//只有在左侧有行被选中，才会加载数据
		var treeSel = $('#sensorNet_left_category_tree').treegrid("getSelected");
		if(!treeSel){
			$.messager.alert("温馨提示", "请先选择采集器！");
			return false;
		}else if(treeSel.grade!=3)  {
			$.messager.alert("温馨提示", "请选择采集器！");
			return false;
		}else if(treeSel.is_online==0)  {
			$.messager.alert("温馨提示", "采集器离线,此功能不能操作！");
			return false;
		}else{
			var name = treeSel.name;
			var code = treeSel.code;
	
			$dialog = $("<div id='dlg'></div>");
			$dialog.dialog({
		        href: webContext+'sensorNet/add?id='+code+'&name='+name,
		        title: '配置溶氧度传感器',
		        width: 550,
		        height:550,
		        closed: true,
		        cache: false,
		        modal: true,
		        buttons: [{
		            text: '确定',
		            iconCls:'icon-ok',
		            handler: function() {
		            	AddOxygen();		            
		            }
		        },{
		            text: '取消',
		            iconCls:'icon-cancel',
		            handler: function() {
		                $dialog.dialog('close');
		            }
		        }],
		        onClose: function() {
		        	sensorID_search();
		            $dialog.dialog('destroy');
		        }
		    });
		    $dialog.dialog('open');
			
		}
}

//心跳包周期设置
function showHeartBeatDailog() {
	//只有在左侧有行被选中，才会加载数据
	var treeSel = $('#sensorNet_left_category_tree').treegrid("getSelected");
	if(!treeSel){
		$.messager.alert("温馨提示", "请先选择采集器！");
		return false;
	}else if(treeSel.grade!=3)  {
		$.messager.alert("温馨提示", "请选择采集器！");
		return false;
	}else if(treeSel.is_online==0)  {
		$.messager.alert("温馨提示", "采集器离线,此功能不能操作！");
		return false;
	}else{
		var name = treeSel.name;
		var code = treeSel.code;

		$dialog = $("<div id='dlg'></div>");
		$dialog.dialog({
	        href: webContext+'sensorNet/heartBeat?id='+code+'&name='+name,
	        title: '配置心跳包采集周期',
	        width: 400,
	        height:400,
	        closed: true,
	        cache: false,
	        modal: true,
	        buttons: [{
	            text: '确定',
	            iconCls:'icon-ok',
	            handler: function() {
	            	HeartBeat();		            
	            }
	        },{
	            text: '取消',
	            iconCls:'icon-cancel',
	            handler: function() {
	                $dialog.dialog('close');
	            }
	        }],
	        onClose: function() {
	        	sensorID_search();
	            $dialog.dialog('destroy');
	        }
	    });
	    $dialog.dialog('open');
		
	}
}


//搜索
function sensorID_search(){
	$('#sensorNet_right_list').datagrid("load", getFormJson("sensorNet_search_form"));
}



//删除
function deleteDetailDailog(queryParams){
	
	var treeSel = $('#sensorNet_left_category_tree').treegrid("getSelected");
	if(!treeSel){
		$.messager.alert("温馨提示", "请先选择采集器！");
		return false;
	}else if(treeSel.grade!=3)  {
		$.messager.alert("温馨提示", "请选择采集器！");
		return false;
	}else if(treeSel.is_online==0)  {
		$.messager.alert("温馨提示", "采集器离线,此功能不能操作！");
		return false;
	}else{
		var deviceId = queryParams.collectorId+"0151";//0155数据采集周期项目类型  84 删除成功后
		var sensor1 = queryParams.deviceIdOxygen;
		var sensor = sensor1.substring(8);//要后三位数字
		$.ajax({
			url: CTRL_SERVER_ADDRESS + "/SET_DeleteOxygen",//设置采集周期
			type:'get',
			async: true, 
			dataType:'jsonp',
			data: { deviceId : deviceId, sensor : sensor }, //传参
			jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
			jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
			timeout: 20000,
			success:function(data){
				if(data.ok){
					//$.messager.alert("温馨提示", "操作成功！");
					$.post(webContext+'sensorNet/deleteCollectorDevice', 
							{ collectorId:queryParams.collectorId, deviceIdOxygen: queryParams.deviceIdOxygen, 
						      deviceIdRelay:queryParams.deviceIdRelay},
							   function(data){
						    	  data = eval( "(" + data + ")" );
						    	  if(data.errorMsg.toString() == '2'){
						            	$.messager.alert("温馨提示", "删除成功");
						          }else if(data.errorMsg.toString() == '1' || data.errorMsg.toString() == '0'){
						            	$.messager.alert("温馨提示", "删除失败");
						          }else {
						        	  $.messager.alert("温馨提示", "删除失败！" + data.errorMsg);
						          }  
					});
				}else{
					$.messager.alert("温馨提示", "删除失败！" + data.errorMsg);
				}
				sensorID_search();
				$(dom).css("cursor", "pointer");
			},
			error:function(data){
				$.messager.alert("温馨提示", "网络访问出错！");
				$(dom).css("cursor", "pointer");
			}
		});
		
	}
}
	
function AddOxygen(){
	var deviceId1 = $("#collectorId").val();//
	var deviceId = $("#collectorId").val()+"0151";//0151:添加溶氧传感器的项目类型
	var sensorOxygen = $("#deviceIdOxygen").val();// 
	var sensor = sensorOxygen.substring(8);//要后三位数字
	var addRelay = $("#deviceIdRelay").val();
	var relay1 = addRelay.substring(8);//要后三位数字
	var relay = parseInt(relay1, 10);
	var max = $("#high_value").val();
	var min = $("#low_value").val();
	var query = $("#collect_cycle").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_ADDOXYGEN",//添加溶氧度传感器
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, sensor:sensor, max : max, min : min ,query:query ,relay:relay }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 20000,
		success:function(data){
			if(data.ok){	
				$.post(webContext+'sensorNet/addCollectorDevice', 
						{ collectorId:deviceId1, deviceIdOxygen: sensorOxygen, 
					      deviceIdRelay:addRelay, high_value: max,
					      low_value:min, collect_cycle: query},
						   function(data){
					    	  data = eval( "(" + data + ")" );
					    	  if(data.errorMsg.toString() == '2'){
					            	$.messager.alert("温馨提示", "操作成功");
					            	$dialog.dialog('close');
					          }else if(data.errorMsg.toString() == '1' || data.errorMsg.toString() == '0'){
					            	$.messager.alert("温馨提示", "操作失败");
					          }else {
					        	  $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
					          }  
				});
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

//配置心跳包周期
function HeartBeat(){
	var deviceId = $("#collectorId").val()+"000B";//000B:心跳包的项目类型
	var deviceId1 = $("#collectorId").val();
	var heartCycle = $("#heartbeat_cycle1").val();
	$.ajax({
		url: CTRL_SERVER_ADDRESS + "/SET_HEARTBEAT",//设置心跳包的时间
		type:'get',
		async: true, 
		dataType:'jsonp',
		data: { deviceId : deviceId, heartCycle : heartCycle }, //传参
		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
		timeout: 20000,
		success:function(data){
			if(data.ok){
				updateHeartBeat(deviceId1,heartCycle);
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


function updateHeartBeat(deviceId1,heartCycle){
	$.post(webContext+'sensorNet/updateHeartBeatCycle', 
			{ collectorId:deviceId1,heartbeat_cycle:heartCycle},
			   function(data){
				reloadHeartBeat();
	});
}
</script>


</body>
</html>