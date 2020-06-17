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
<form id="add_form" method="post" action='pond/add_save'>
	<table style="padding-left:80px;padding-right:30px;padding-top: 20px;padding-bottom: 80px;">
	   <tr>
	   	<td style="width:360px;text-align:left;">采集器：
			</td>
	   </tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">编码:
				<input  id="collectorId" class="easyui-textbox" name="collectorId" 
					data-options="required:true" style="width:30%;"
					 value="<%=request.getParameter("id") %>" ></input>
					 名称:<input  id="collectorIdName" class="easyui-textbox" name="collectorIdName" 
					data-options="required:true" style="width:30%;"
					 value="<%=request.getParameter("name") %>" ></input>	
			</td>
		</tr>
		<tr>
	   	<td style="width:360px;text-align:left;">溶氧度传感器:
		   	<span class="conditionSpan">
					<a class="easyui-linkbutton" onclick="Open_Oxygensensor_info()" data-options="iconCls:'icon-search'" style="height:22px;">查询溶氧度传感器</a>
			</span>	
	   </td>
	   </tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">编码:
				<input  id="deviceIdOxygen" class="easyui-textbox" name="deviceIdOxygen" 
					data-options="required:true" style="width:30%;"
					 ></input>
					 名称:<input  id="deviceIdOxygenName" class="easyui-textbox" name="deviceIdOxygenName" 
					data-options="required:true" style="width:30%;"
					 ></input>	
			</td>
		</tr>
		<tr>
	   	<td style="width:360px;text-align:left;">增氧机:
	   		<span class="conditionSpan">
					<a class="easyui-linkbutton" onclick="Open_Aerator_info()" data-options="iconCls:'icon-search'" style="height:22px;">查询增氧机</a>
			</span>	
		</td>
	   </tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">编码:
				<input  id="deviceIdRelay" class="easyui-textbox" name="deviceIdRelay" 
					data-options="required:true" style="width:30%;"
					 ></input>
					 名称:<input  id="deviceIdRelayName" class="easyui-textbox" name="deviceIdRelayName" 
					data-options="required:true" style="width:30%;"
					 ></input>	
			</td>
		</tr>
		<tr>
		<td style="width:360px;text-align:left;">溶氧度阈值:
			</td>
	   </tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">上限:
				<input  id="high_value" class="easyui-textbox" name="high_value" 
					data-options="required:true" style="width:30%;"
					></input>mg/L
			</td>
			
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">下限:
				<input  id="low_value" class="easyui-textbox" name="low_value" 
					data-options="required:true" style="width:30%;"
					></input>mg/L	
			</td>
			
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">数据采集周期:
				<input  id="collect_cycle" class="easyui-textbox" name="deptname" 
					data-options="required:true" style="width:30%;"
					 ></input>秒	
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript">
function Open_Oxygensensor_info() {
	var collectorId = $('#collectorId').val();
	var $dialog = $("<div></div>");
	$dialog.dialog({
        href: '<%=basePath%>sensorNet/selectOxygen',
        method: 'post',
        queryParams: {
        	data: collectorId
        },
        title: '选择溶氧温度传感器',
        width: 600,
        height: 450,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	var rows = $('#deviceOxygen_list').datagrid("getSelected");
            	var deviceId = rows.deviceId.toString();
            	var deviceName = rows.deviceName.toString();
            	$('#deviceIdOxygen').textbox('setValue',deviceId);
            	$('#deviceIdOxygenName').textbox('setValue',deviceName);
            	$dialog.dialog('close');
            }
        },{
            text: '取消',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}

function Open_Aerator_info() {
	var collectorId = $('#collectorId').val();
	var $dialog = $("<div></div>");
	$dialog.dialog({
        href: '<%=basePath%>sensorNet/selectAerator',
        method: 'post',
        queryParams: {
        	data: collectorId
        },
        title: '选择溶氧温度传感器',
        width: 600,
        height: 450,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	var rows = $('#deviceOxygen_list').datagrid("getSelected");
            	var deviceId = rows.deviceId.toString();
            	var deviceName = rows.deviceName.toString();
            	$('#deviceIdRelay').textbox('setValue',deviceId);
            	$('#deviceIdRelayName').textbox('setValue',deviceName);
            	$dialog.dialog('close');
            }
        },{
            text: '取消',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}










</script>



</body>
</html>