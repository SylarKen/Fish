<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>渔业综合服务平台</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
</head>
<body>
<form id="device_edit_form" method="post" action='${basePath}device/device_edit'>
	<table style="padding:20 0 0 30;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">编&nbsp;&nbsp;号：</td>
			<td>
				<input id="device_edit_code" class="easyui-textbox" name="deviceCode" value="${device.deviceCode }" readonly="readonly" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">序 列 号：</td>
			<td>
				<input id="device_edit_id" class="easyui-textbox" name="deviceId" value="${device.deviceId }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">名&nbsp;&nbsp;称：</td>
			<td>
				<input id="device_edit_name" class="easyui-textbox" name="deviceName" value="${device.deviceName }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">设备类型：</td>
			<td>
				<input id="device_edit_typeName" class="easyui-textbox" name="typeName" value="${device.typeName }" data-options="required:true" style="width:210px;" readonly="readonly">
				<input id="device_edit_typeCode" name="typeCode" value="${device.typeCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;display: none;" id="device_edit_tr_valarea">
			<td style="width:120px;text-align:right;">阈值范围：</td>
			<td>
				<input id="device_edit_minval" name="minval" class="easyui-numberbox" data-options="prompt:'最小值'" style="width:100px;" value="${device.min_value }"  readonly="readonly">-
			    <input id="device_edit_maxval" name="maxval" class="easyui-numberbox" data-options="prompt:'最大值'" style="width:100px;" value="${device.max_value }"  readonly="readonly">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">地&nbsp;&nbsp;区：</td>
			<td>
				<input id="device_edit_areaName" name="areaName" value="${device.areaName }" class="easyui-textbox" style="width:210px;" data-options="required:true" readonly="readonly">
			    <input id="device_edit_areaCode" name="areaCode" value="${device.areaCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">池&nbsp;&nbsp;塘：</td>
			<td>
				<input id="device_edit_pondName" name="pondName" value="${device.pondName }" class="easyui-textbox" style="width:210px;" readonly="readonly">
			    <input id="device_edit_pondCode" name="pondCode" value="${device.pondCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">采 集 器：</td>
			<td>
				<input id="device_edit_collectorName" name="collectorName" value="${device.collectorName }" class="easyui-textbox" style="width:210px;" readonly="readonly">
			    <input id="device_edit_collectorCode" name="collectorCode" value="${device.collectorCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">购买时间：</td>
			<td>
				<input id="device_edit_buyDate" class="easyui-datebox" name="buyDate" value="${device.buyDate }" style="width:210px;" data-options="required:true" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">生效时间：</td>
			<td>
				<input id="device_edit_effectiveDate" class="easyui-datebox" name="effectiveDate" value="${device.effectiveDate }"  style="width:210px;"  data-options="required:true" /> 
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">到期时间：</td>
			<td>
				<input id="device_edit_expiringDate" class="easyui-datebox" name="expiringDate" value="${device.expiringDate }"  style="width:210px;" data-options="required:true" /> 
			</td>
		</tr>	
		<tr style="height:40px;">
   			<td style="width:120px;text-align:right;">是否可用：</td>
   			<td>
   			    <select class="easyui-combobox" id="device_edit_delete_flag" select_value="${device.delete_flag }" name="delete_flag"  data-options="panelHeight:'auto',width:'210px'">
    				<option value="0">可用</option>
    				<option value="1">不可用</option>
   				</select>
   			</td>
   		</tr>
	</table>
</form>
<script type="text/javascript">
$(function() {
	$("#device_edit_delete_flag").children("option[value='"+$('#device_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');
	if("${device.typeCode }"=="0156"){
		$("#device_edit_tr_valarea").show();
		$("#device_edit_minval").numberbox({"required":true});
		$("#device_edit_maxval").numberbox({"required":true});
	}
});
</script>
</body>
</html>
