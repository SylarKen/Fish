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
<form id="deviceType_edit_form" method="post" action='${basePath}deviceType/deviceType_edit'>
	<table style="padding:30 0 0 20;">
		<input type="hidden" name="id" value="${deviceType.id }" />
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">类型编号：</td>
			<td>
				<input id="deviceType_edit_code" class="easyui-textbox" name="typeCode" value="${deviceType.typeCode }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">类型名称：</td>
			<td>
				<input id="deviceType_edit_name" class="easyui-textbox" name="typeName" value="${deviceType.typeName }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">编号前缀：</td>
			<td>
				<input id="deviceType_edit_rule" class="easyui-textbox" name="rule" value="${deviceType.rule }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
   			<td style="width:120px;text-align:right;">是否可用：</td>
   			<td>
   			    <select class="easyui-combobox" id="deviceType_edit_delete_flag" select_value="${deviceType.delete_flag }" name="delete_flag"  data-options="panelHeight:'auto',width:'210px'">
    				<option value="0">可用</option>
    				<option value="1">不可用</option>
   				</select>
   			</td>
   		</tr>
	</table>
</form>
<script type="text/javascript">
$(function() {
	$("#deviceType_edit_delete_flag").children("option[value='"+$('#deviceType_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');
});
</script>
</body>
</html>
