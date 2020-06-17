<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>渔业局管理系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
</head>
<body>
<form id="form" method="post" >
	<table style="padding-left:80px;padding-right:30px;padding-top: 20px;padding-bottom: 80px;">
	   <tr style="height:40px;">
	   	<td style="width:400px;text-align:left;">采集器名称:<input disabled id="collectorIdName" class="easyui-textbox" name="collectorIdName" 
					data-options="required:true" style="width:35%;"
					 value="<%=request.getParameter("name") %>" ></input>
		</td>
	   </tr>
		<tr style="height:40px;">
			<td style="width:400px;text-align:left;">采集器编码:
				<input disabled  id="collectorId" class="easyui-textbox" name="collectorId" 
					data-options="required:true" style="width:35%;"
					 value="<%=request.getParameter("id") %>" ></input>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:400px;text-align:left;">心跳包周期:
				<input disabled  id="heartbeat_cycle" class="easyui-textbox" name="heartbeat_cycle" 
					data-options="required:true" style="width:35%;"
					 ></input>秒	
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:400px;text-align:left;">更改心跳包:
				<input  id="heartbeat_cycle1" class="easyui-textbox" name="heartbeat_cycle1" 
					data-options="required:true" style="width:35%;"
					 ></input>秒	
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript">
$(function(){
	reloadHeartBeat();
});

function reloadHeartBeat(){
	var collectorId = $('#collectorId').val();
	$.post(webContext+'sensorNet/readHeartBeatCycle', 
			{ collectorId:collectorId},
			   function(data){
		    	  data = eval( "(" + data + ")" );
		    	  $('#heartbeat_cycle').textbox('setText',data.heartbeat_cycle.toString());
	});
}









</script>



</body>
</html>