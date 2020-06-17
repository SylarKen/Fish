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
<form id="deviceType_add_form" method="post" action='${basePath}deviceType/deviceType_add'>
	<table style="padding:30 0 0 20;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">类型编号：</td>
			<td>
				<input id="deviceType_add_code" class="easyui-textbox" name="typeCode" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">类型名称：</td>
			<td>
				<input id="deviceType_add_name" class="easyui-textbox" name="typeName" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">编号前缀：</td>
			<td>
				<input id="deviceType_add_rule" class="easyui-textbox" name="rule" data-options="required:true" style="width:210px;">
			</td>
		</tr>
	</table>
</form>
</body>
</html>
