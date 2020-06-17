<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>德州恒丰纺织后台管理系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="添加用户">
</head>
<body>
<form id="warn_add_form" method="post" action='${basePath}warn/insert'>
	<table style="padding:40px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">通知方式：</td>
			<td>
			 	<select class="easyui-combobox" style="width: 200px;" id="warn_add_noticeMethod" name="noticeMethod"  data-options="panelHeight:'auto'">
       				<option value="1">短信</option>
					<option value="2">邮件</option>
	  			</select>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">通知时间：</td>
			<td>
			 	 <input id="warn_add_noticeTime" class="easyui-textbox" name="noticeTime" style="width:200px;" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">是否开启：</td>
			<td>
			 	<select class="easyui-combobox" style="width: 200px;" id="warn_add_isOpen" name="isOpen"  data-options="panelHeight:'auto'">
       				<option value="0">开启</option>
					<option value="1">关闭</option>
	  			</select>
			</td>
		</tr>
		<!-- <tr style="height:40px;">
			<td style="width:120px;text-align:right;">手&nbsp;&nbsp;机：</td>
			<td>
				<input id="warn_add_phone" class="easyui-textbox" name="phone" 
					data-options="" style="width:210px;" validType="mobile">
			</td>
		</tr> -->
	</table>
</form>
<script type="text/javascript">
$(function() {
 
	
 
});
</script>
</body>
</html>
