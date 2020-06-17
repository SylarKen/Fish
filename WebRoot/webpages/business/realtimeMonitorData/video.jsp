<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'video.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body, html,#video_monitorData_location{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  
  <style>
#video_monitorData {
	/* width: 400px;
	height:280px; */
	margin:10px;
	display:inline-block;
	position: relative;
}
</style>
     <div class="easyui-layout" style="width:100%;height:100%;" >
    <div region="west" split="true" title="池塘列表" style="width:15%;">
    	<div id="video_sensor_list"></div>
    </div>
    <div region="center" title="实时视频">
    <div id="video_panel" class="easyui-layout" style="width:100%;height:100%;" >
    <div  region="south" title="视频信息" style="height:100%;" collapsed="true">
    <div id="video_monitorData" style="width:98%;height:96%;">
					<div id="video_monitorData_device"></div>
				</div>
    </div>
    <div region="center" title="地理位置" style="height:45%;">
    <div id="video_monitorData_location"  style="width: 100%;height:100%;"></div>
    </div>
    </div>
</div>
    </div>
    <script type="text/javascript" src="<%=basePath%>js/videocfg/cyberplayer.js"></script>
    <script type="text/javascript">
    $(function() {
    	$('#video_sensor_list').tree({
    		url: '${basePath}realtimeMonitorData/pondTree',
    		onSelect:function(node){
    			if(node.id.length==7){
    				$.post('${basePath}' + 'realtimeMonitorData/queryLngLat',{pondId:node.id},function(r){
    					r = jQuery.parseJSON(r);
    					//百度地图API功能
    					var map = new BMap.Map("video_monitorData_location");    // 创建Map实例
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
    	    		var map = new BMap.Map("video_monitorData_location");    // 创建Map实例
    	    		for(var i=0;i<r.length;i++){
    	    			var point=new BMap.Point(r[i].lng, r[i].lat);
    	    			map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
    	    			//
    	    			var marker = new BMap.Marker(point);  // 创建标注
    	    			map.addOverlay(marker);              // 将标注添加到地图中
    	    			addClickHandler(marker);
    	    			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    	    			/* marker[i].addEventListener("click", function(){  
    	    			$("#video_panel").layout('expand','south');
    	    			load_monitorDataVideo(marker.point.lng,marker.point.lat);
						}); */
    	    		}
    	    		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    	    		//map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    	    		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    	    	});
    		}
    		});	
    	});
    
    function addClickHandler(marker){
		marker.addEventListener("click",function(e){
			//openInfo(content,e);
			$("#video_panel").layout('expand','south');
			load_monitorDataVideo(marker.point.lng,marker.point.lat);
			}
		);
	}
    
    function load_monitorDataVideo(lng,lat){
    	var player = cyberplayer("video_monitorData_device").setup({
    		flashplayer : "js/videocfg/cyberplayer.flash.swf",
    		stretching : "fill",
    		file : "rtmp://192.168.9.90:10035/live/stream_1" || "rtmp://121.40.50.44/live/stream_1",
    		image : "http://192.168.9.90:10080/snap/1/2016-12-08/20161208105432.jpg" || "/images/snap.png",
    		width : $("#video_monitorData").width(),
    		height : $("#video_monitorData").height(),
    		autostart : true,
    		repeat : !1,
    		volume : 100,
    		controls : !0,
    		controlbar : {
    			barLogo : !1
    		},
    		ak : "515d61b893134f40bd4297b75a03494b"
    	});	
    }
    </script>
  </body>
</html>
