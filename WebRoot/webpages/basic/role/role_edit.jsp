<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>德州恒丰纺织后台管理系统</title>
    <jsp:include page="/common.jsp"></jsp:include>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body>
    <div class="easyui-panel" style="width:100%;height:100%">
		<div style="padding:5px 60px 0px 60px">
	    <form id="role_edit_form" method="post" action='<%=basePath %>basic/role_edit_save'>
	    	<input type="hidden" name="roleId" value="${role.roleId}"/>
	    	<table cellpadding="10">
	    		<tr>
	    			<td>角色名称:</td>
	    			<td><input class="easyui-textbox" type="text" name="roleName" value='${role.roleName }'  style='width:150px' data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>角色关键字:</td>
	    			<td><input class="easyui-textbox" type="text" name="roleKey" value='${role.roleKey }'  style='width:150px' data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
					<td>是否可用:</td>
					<td >
					<input id="role_edit_delete_flag_update" type="hidden" name="delete_flag" value="${role.delete_flag}">
					<input id="role_edit_delete_flag" style='width:150px' value="${role.delete_flag}">
					</td>
			    </tr>
	    	</table>
	    </form>
	    </div>
	</div>
	 <script type="text/javascript">
	 $("#role_edit_delete_flag").combobox({
		editable: false,
		data: [
			{
				label: '可用',
				value: 0
			},
			{
				label: '不可用',
				value: 1
			}
		],
		panelHeight: 'auto',
		textField: 'label',
		valueField: 'value',
		onSelect:function(record){
			$("#role_edit_delete_flag_update").val(record.value);
		}
	});
	$(function() {
		$("#role_edit_type").children("option[value='"+$('#role_edit_type').attr("select_value")+"']").eq(0).attr('selected','selected');
	});
  	</script>
  </body>
</html>
