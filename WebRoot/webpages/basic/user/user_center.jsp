<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>绩效考核系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="个人中心">
</head>
<body>
<div id="user_center_layout" class="easyui-layout" data-options="border:true" style="100%;height:100%;">   
	<div data-options="region:'north',border:false" style="margin:1px;height:40px;padding-left:5px;color:#666;background:#FFFDCD;">
		<img style="height:40px;padding-left:5px;float:left;" src="${basePath}image/man.png">
		<span style="float:left;display:block;height:40px;line-height:40px;font-weight:bold;">${user.realname}（${user.username}）</span>
	</div>
	<div data-options="region:'center'">
		<div id="user_center_tabs" class="easyui-tabs" style="width:100%;height:100%;">
			<div title="个人信息">
				<table class="info-table">
					<tr>
						<td class="label">登录账号：</td>
						<td class="info">${user.username}</td>
						<td class="label">姓名：</td>
						<td class="info">${user.realname}</td>
					</tr>
					<tr>
						<td class="label">手机：</td>
						<td class="info">${user.phone}</td>
						<td class="label">部门：</td>
						<td class="info">${user.deptName}</td>
					</tr>
				</table>
			</div>
			<div title="修改密码">
				<form id="editPwd_form" method="post" action='${basePath}system/editPwd_save'>
				<table style="width:740px;">
					<tr>
						<td class="bottomdashed" style="width:13%;text-align:right;line-height:35px;">原始密码：</td>
						<td class="bottomdashed" style="width:200px;">
							<input class="easyui-textbox" type="password" id='oldPwd' value=""  style='width:200px' data-options="required:true"></input>
						</td>
						<td class="bottomdashed"></td>
					</tr>
					<tr>
						<td class="bottomdashed" style="width:13%;text-align:right;line-height:35px;">新密码：</td>
						<td class="bottomdashed" style="width:200px;">
							<input class="easyui-textbox" type="password" name="key1" id='newPwd' value=""  style='width:200px' data-options="required:true"></input>
						</td>
						<td class="bottomdashed"></td>
					</tr>
					<tr>
						<td class="bottomdashed" style="width:13%;text-align:right;line-height:35px;">确认密码：</td>
						<td class="bottomdashed" style="width:200px;">
							<input class="easyui-textbox" type="password"  id='newPwdAgain' value=""   style='width:200px' data-options="required:true" validType="equalTo['#newPwd']" invalidMessage="两次输入密码不匹配"></input>
						</td>
						<td class="bottomdashed"></td>
					</tr>
					<tr>
						<td style="text-align:center;line-height:35px;" colspan="2">
							<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="editPwd_save()" style="padding: 0 15px;">保存</a>
						</td>
						<td></td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>
</div>
<style>
.info-table {
	border-collapse: collapse;
	width: 740px;
	margin: 0;
	padding: 0;
	border-widtd: 3px 1px 1px;
}
.info-table .label {
	width: 90px;
	height: 24px;
	padding: 0 5px;
	text-align:right;
	background: #f7f7f7;
	border-bottom: 1px solid #ccc;
	border-left: 1px solid #ccc;
	border-top: 1px solid #ccc;
}
.info-table .info {
	width: 'auto';
	height: 24px;
	padding: 0 0 0 3px;
	text-align:left;
	border: 1px solid #ccc;
}
.bottomdashed {
	border-bottom: 1px dashed #ccc;
}
</style>
<script type="text/javascript">
$(function() {
	
});
function editPwd_save() {
	var form = $("#editPwd_form");
	var action = form.attr("action");
	if (form.form("validate")) {
		$.get('${basePath}basic/isPwdRight', {oldPwd: $("#oldPwd").val()}, function(data) {
			if (data == '"error"') {
				$.messager.alert("温馨提示", "原始密码输入错误！");
				return false;
			} else {
				$.get(action, getFormJson("editPwd_form"),
				function(data) {
					if (data > 0) {
						$.messager.alert("温馨提示", "保存成功！");
						$('#editPwd').dialog('close');
						window.location.href = "${basePath}system/exit";
					} else $.messager.alert("温馨提示", "保存失败！");

				});
			}
		});
	}
}
</script>
</body>
</html>
