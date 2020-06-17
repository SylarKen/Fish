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
		<div >
	    <form id="role_add_form" method="post" action='<%=basePath %>basic/role_add_save'>
	    	<table cellpadding="10">
	    		<tr>
	    			<td>角色名称:</td>
	    			<td><input class="easyui-textbox" type="text" name="roleName" style='width:150px' data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>角色关键字:</td>
	    			<td><input class="easyui-textbox" type="text" name="roleKey" style='width:150px' data-options="required:true"></input></td>
	    		</tr>
 
	    	</table>
	    </form>
	    </div>
	</div>
 
  </body>
</html>
