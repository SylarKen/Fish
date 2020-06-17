<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.getSession().setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'import.jsp' starting page</title>
    <jsp:include page="/common.jsp"></jsp:include>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <input type="file" id="import" name="file"/>
  </body>
  <script type="text/javascript">
    $(function() {
    	$("#import").uploadify({
			'buttonText' : '导入文件',
			'height': 30,
			'width': 150,
			'swf': '${basePath}js/uploadify/uploadify.swf',
			'uploader': '${basePath}menu/upload', //后台处理程序的相对路径
			'auto': true,
			'fileTypeDesc': 'JSON Files',
			'fileObjName': 'file',
			'fileTypeExts': '*.json;',
			'multi': false,//单个文件
			'onUploadSuccess' : function(file, data, response) {
				//每上传成功都会执行一遍
				var result = jQuery.parseJSON(data);
				if (result.status) {
					$.messager.alert("温馨提示", "导入成功！");
				} else {
					$.messager.alert("温馨提示", result.errorMsg);
				}
			}
		});
    });
  </script>
</html>
