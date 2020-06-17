<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	Map<Object,Object> user = (Map<Object,Object>)session.getAttribute("user");	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'status.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body, html,#status_monitorData_location{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="<%= basePath %>css/font-awesome-4.7.0/css/font-awesome.min.css">
  </head>
  
  <body>
    <div class="easyui-layout" style="width:100%;height:100%;" >
    <div region="west" split="true" title="传感器列表" style="width:15%;">
    	<div id="status_sensor_list"></div>
    </div>
    <div region="center" title="设备状态">
    <!-- <div style="width:100%;height:7%;">
    <form id="status_monitorData_search_form" style="margin:5px 5px;">
			<table id="flow_search" style="word-break: keep-all;font-size:14px">
				<tr>
					<td >采集器：</td>
					<td >
					<input type="text" id="status_monitorData_collector" >
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>传感器：</td>
					<td>
					<input type="text" id="status_monitorData_device" name="device">
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a href="#" class="easyui-linkbutton"
						iconcls="icon-search"
						onclick="load_monitorDataStatus('#status_monitorData_device')">查询</a></td>
				</tr>
			</table>
		</form>
		</div> -->
    <div id="device_panel" class="easyui-layout" style="width:100%;height:100%;" >
    <div  region="south" title="设备状态" style="height:30%;" collapsed="true">
    <div id="status_monitorData_device_list" style="width: 98%;height:98%;"></div>
    </div>
    <div region="center" title="地理位置" style="height:70%;">
    <div id="status_monitorData_location"  style="width: 100%;height:100%;"></div>
    </div>
    </div>
</div>
    </div>
    <script>
    $(function() {
    	$('#status_sensor_list').tree({
    		url: '${basePath}realtimeMonitorData/pondTree',
    		onSelect:function(node){
    			if(node.id.length==7){
    				$.post('${basePath}' + 'realtimeMonitorData/queryLngLat',{pondId:node.id},function(r){
    					r = jQuery.parseJSON(r);
    					//百度地图API功能
    					var map = new BMap.Map("status_monitorData_location");    // 创建Map实例
    					var point=new BMap.Point(r[0].lng, r[0].lat);
    					map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
    					var marker = new BMap.Marker(point);  // 创建标注
    					map.addOverlay(marker);              // 将标注添加到地图中
    					marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    					addClickHandler(marker);
    					map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    					//map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    					map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    			});
    			}
    		},
    		onLoadSuccess:function(node,data){
    			$.post('${basePath}' + 'realtimeMonitorData/queryLngLatByUsername',{userName:'${user.username}'},function(r){
    	    		r = jQuery.parseJSON(r);
    	    		//百度地图API功能
    	    		var map = new BMap.Map("status_monitorData_location");    // 创建Map实例
    	    		for(var i=0;i<r.length;i++){
    	    			var point=new BMap.Point(r[i].lng, r[i].lat);
    	    			map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
    	    			//
    	    			var marker = new BMap.Marker(point);  // 创建标注
    	    			map.addOverlay(marker);              // 将标注添加到地图中
    	    			addClickHandler(marker);
    	    			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    	    			/* marker[i].addEventListener("click", function(){  
    	    			$("#device_panel").layout('expand','south');
    	    			load_monitorDataStatus(marker.point.lng,marker.point.lat);
						}); */
    	    		}
    	    		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    	    		//map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    	    		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    	    	});
    		}
    		});	
    }
    );
    
    function addClickHandler(marker){
		marker.addEventListener("click",function(e){
			//openInfo(content,e);
			$("#device_panel").layout('expand','south');
			load_monitorDataStatus(marker.point.lng,marker.point.lat);
			}
		);
	}
    
    function load_monitorDataStatus(lng,lat){
    	//var deviceCode=$(id).combobox('getValue');
    	var height=$('#status_monitorData_device_list').height();
    	$('#status_monitorData_device_list').datagrid(
    			{
    			url : '${basePath}'+ 'realtimeMonitorData/queryDeviceByLntLat',
    			queryParams:{lng:lng,lat:lat},
    			fitColumns:true,
    			fit:true,
    			height:height,
    			border:false,
    			nowrap : true,
    			idField : 'id',
    			striped : true, // 奇偶行是否区分
    			singleSelect : true,// 单选模式
    			rownumbers : true,// 行号
    			sortName: 'year,month,verify_time',
    			pagination : true,
    			pageSize : 10, // 每一页多少条数据
    			pageList : [10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
    			pagePosition : 'bottom',
    			
    			columns : [ [
    					{field : 'deviceId',title : '设备ID',width : 80},
    					{field : 'deviceName',title : '传感器名称',width : 120},
    					{field : 'pondName',title : '池塘名称',width : 80},
    					{field : 'creator',title : '使用者',width : 80,hidden:true},
    					{field : 'status',title : '状态',width : 120,formatter : function(value, row,index) {
						return 	index1_getStatusText1(value);
							}
    					},
    					{field : 'delete_flag',title : '操作',width :80,formatter : function(value, row,index) {
    						return 	index1_getSwitchBtn1(row.status,row.deviceId)+'<span style="display:none">'+row.deviceId+'</span>';
						}
    					}
    					] ]
    			});	
    }
    
    //设备状态转文本
	function index1_getStatusText1(status){
		var text = "未知";
		switch(status){
			case 0 : text = "<font color=green>开启</font>";break;
			case 1 : text = "<font color=red>关闭</font>";break;
		}
		return text;
	}
    
    //根据状态获得控制按钮
	function index1_getSwitchBtn1(status,deviceId){
		var text = '<td class="swicthBtn" onclick="index1_swicth(this,1)"><i style="color:red;" class=" fa fa-arrow-circle-down">关闭</i></td>';
		//debugger;
		switch(status){
			case 0 : text = '<a onclick="index1_swicth1(this,1)"><i style="color:red;"   class=" fa fa-arrow-circle-down">关闭</i></a>';break;
			case 1 : text = '<a onclick="index1_swicth1(this,0)"><i style="color:green;" class=" fa fa-arrow-circle-up">开启</i></a>';break;
		}
		return text;
	}
    
	//改变设备状态
	function index1_swicth1(dom, statusTo){
		var cursor = $(dom).css("cursor");
		if(cursor == "not-allowed"){
			return;
		}
		$(dom).css("cursor", "not-allowed");
		//var deviceId = $(dom).parent().attr("deviceId");
		var f=$(dom).parent().text();
		//var d=f.substr(0, 2);
		var deviceId=f.replace(f.substr(0, 2),'');
		//deviceId=f.replace('下线','');
		if(!deviceId){
			$.messager.alert("温馨提示", "设备编号为空！");
			$(dom).css("cursor", "pointer");
			return;
		}
		$.ajax({
			url: CTRL_SERVER_ADDRESS + "/SWITCH_STATUS",
			type:'get',
			async: true, 
			dataType:'jsonp',
			data: { deviceId : deviceId, statusTo : statusTo }, //传参
			jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
			jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
			timeout: CTROL_DEVICE_INTERVAL,
			success:function(data){
				$(dom).css("cursor", "pointer");
				if(data.ok){
					$.messager.alert("温馨提示", "操作成功！");
					//index1_queryDevice();
					$('#status_monitorData_device_list').datagrid('load');
				}else{
					$.messager.alert("温馨提示", "操作失败！"+ data.errorMsg);
					console.log(data.errorMsg);
				}
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
