<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>绩效考核系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="编辑用户">
</head>
<body>
<form id="warn_edit_form" method="post" action='${basePath}warn/update'>
	<table style="padding:40px;">
			<tr style="height:40px;">
			<td style="width:120px;text-align:right;">通知方式：</td>
			<td>
			    <input name="id" value='${warn.id}'  type="hidden"/>
			 	<select class="easyui-combobox" style="width: 200px;" id="warn_edit_noticeMethod" name="noticeMethod" select_value='${warn.noticeMethod}' data-options="panelHeight:'auto'">
       				<option value="1">短信</option>
					<option value="2">邮件</option>
	  			</select>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">通知时间：</td>
			<td>
			 	 <input id="warn_edit_noticeTime" class="easyui-textbox" name="noticeTime" value='${warn.noticeTime}' style="width:200px;" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">是否开启：</td>
			<td>
			 	<select class="easyui-combobox" style="width: 200px;" id="warn_edit_isOpen" name="isOpen" select_value='${warn.isOpen}'  data-options="panelHeight:'auto'">
       				<option value="0">开启</option>
					<option value="1">关闭</option>
	  			</select>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">是否可用：</td>
			<td>
			 	<select class="easyui-combobox" style="width: 200px;" id="warn_edit_delete_flag" name="delete_flag" select_value='${warn.delete_flag}' data-options="panelHeight:'auto'">
       				<option value="0">可用</option>
					<option value="1">不可用</option>
	  			</select>
			</td>
		</tr>
		<!-- <tr style="height:40px;">
			<td style="width:120px;text-align:right;">手&nbsp;&nbsp;机：</td>
			<td>
				<input id="warn_edit_phone" class="easyui-textbox" name="phone" 
					data-options="" style="width:210px;" validType="mobile">
			</td>
		</tr> -->
	</table>
</form>
<script type="text/javascript">
$(function() {
	$("#warn_edit_noticeMethod").children("option[value='"+$('#warn_edit_noticeMethod').attr("select_value")+"']").eq(0).attr('selected','selected');
	$("#warn_edit_isOpen").children("option[value='"+$('#dept_edit_delete_flag').attr("warn_edit_isOpen")+"']").eq(0).attr('selected','selected');
	$("#warn_edit_delete_flag").children("option[value='"+$('#warn_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');

});

</script>
</body>
</html>
