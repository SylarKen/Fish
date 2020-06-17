<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
	<form id="fond_edit_form" method="post" action='${basePath}pond/editSave' >
		<input type="hidden" name="code" value="${ bean.code }"/>
		<table id="fond_detail_table"  style="padding-left:90px;padding-right:80px;padding-top: 40px;padding-bottom: 40px;">
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">池塘编码：
				<input disabled  id="code" class="easyui-textbox" name="code"  value='${ bean.code }' 
					data-options="required:true" style="width:280px;"></input>
					 <input  id="deptCode"  hidden="true" name="deptCode" 
					 value='${ bean.deptCode }'  ></input>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">池塘名称：
				<input id="name" class="easyui-textbox" name="name" value='${ bean.name }' 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">池塘面积：
				<input id="area" class="easyui-textbox" name="area" value='${ bean.area }' 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		
		</tr>
		
		<tr style="height:80px;">
			<td style="width:360px;text-align:left;">主要养殖品种：</br>
				<textarea id = "fishinfo" name="fishinfo" rows="3" style="width:360px;line-height:25px;"  validType="validator">${ bean.fishinfo }</textarea>
			</td>
		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">位置：</br>
				<textarea id = "location"  name="location" rows="3" style="width:360px;line-height:25px;"  validType="validator">${ bean.location }</textarea>
			</td>
		</tr>
		
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">联系人员：
				<input id="linkman" class="easyui-textbox" name="linkman" value='${ bean.linkman }' 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		
		</tr>
		<tr style="height:40px;">
			<td style="width:360px;text-align:left;">联系电话：
				<input id="contactway" class="easyui-textbox" name="contactway" value='${ bean.contactway }' 
					data-options="required:true" style="width:280px;" validType="validator">
			</td>
		</tr>
		
		<tr>
			<td>是否可用：
			<input id="user_edit_delete_flag" name="delete_flag" value="${bean.delete_flag}" style="width:280px;">
    			<%--  <select  class="easyui-combobox" style="width:280px;" name="delete_flag"  value='${ bean.delete_flag }'  
    			     data-options="panelHeight:'auto'">
	    		   <option value="0">可用</option>
	    		   <option value="1">不可用</option>
    			</select> --%>
    		</td>
			</tr>
	</table>
	</form>
<script type="text/javascript">
$(function() {
	$('#user_edit_delete_flag').combobox({
		data: [{value: 0,text: '可用'	}, {value: 1,text: '不可用'}],
		valueField: 'value',
		textField: 'text', 
		editable: false,
		panelHeight: 'auto'
	});
});

</script>
</body>
</html>
