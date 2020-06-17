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
	<table style="padding-left:90px;padding-right:80px;padding-top: 40px;padding-bottom: 40px;">
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">养殖地点：
				<input  id="deptname" class="easyui-textbox" name="deptname" 
					data-options="required:true" style="width:280px;"
					 value="<%=request.getParameter("name") %>" ></input>
					 <input  id="deptCode"  hidden="true" name="deptCode" 
					 value="<%=request.getParameter("id") %>" ></input>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">池塘名称：
				<input id="name" class="easyui-textbox" name="name" 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">池塘面积：
				<input id="area" class="easyui-textbox" name="area" 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		
		</tr>
		
		<tr style="height:80px;">
			<td style="width:360px;text-align:left;">主要养殖品种：</br>
				<textarea id = "fishinfo" name="fishinfo" rows="3" style="width:360px;line-height:25px;"  validType="validator"></textarea>
			</td>
		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">位置：</br>
				<textarea id = "location"  name="location" rows="3" style="width:360px;line-height:25px;"  validType="validator"></textarea>
			</td>
		</tr>
		
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">联系人员：
				<input id="linkman" class="easyui-textbox" name="linkman" 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">联系电话：
				<input id="contactway" class="easyui-textbox" name="contactway" 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		</tr>
	</table>
</form>
</body>
</html>