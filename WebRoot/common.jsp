<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@page import="com.domor.util.Constant" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<title></title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="Mosaddek" name="author" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/my.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui-1.4.2/themes/cupertino/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui-1.4.2/themes/icon.css">

<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/echarts.js"></script>

<script type="text/javascript" src="<%=basePath %>js/js_utils.js"></script>

<script type="text/javascript" src="<%=basePath %>js/jquery.easyui.validate.extends.js"></script>

<script type="text/javascript" src="<%=basePath %>js/dialogs.js"></script>

<link rel="stylesheet" type="text/css" href="<%=basePath %>js/uploadify/uploadify.css">
<script type="text/javascript" src="<%=basePath %>js/uploadify/jquery.uploadify.min.js"></script>

<script type="text/javascript" src="<%=basePath %>js/jquery-barcode.js"></script>
<script>
//全局变量
var webContext = "<%= basePath %>";
var LXBH_CGQ_RYWD = "<%= Constant.LXBH_CGQ_RYWD %>";//类型编号：溶氧温度传感器
var LXBH_CGQ_PH = "<%= Constant.LXBH_CGQ_PH %>";//类型编号：PH传感器
var LXBH_KZQ_ZY = "<%= Constant.LXBH_KZQ_ZY %>";//类型编号：增氧机
var LXBH_KZQ_TE = "<%= Constant.LXBH_KZQ_TE %>";//类型编号：投饵机
var QUERY_DEVICE_INTERVAL = "<%= Constant.QUERY_DEVICE_INTERVAL %>";//查询设备数据间隔时间
var CTROL_DEVICE_INTERVAL = 20000;//控制设备AJAX的间隔时间
var CTRL_SERVER_ADDRESS = "<%= Constant.CTRL_SERVER_ADDRESS %>";//硬件服务器地址
var CTRL_COLLECTOR_ADDRESS = "<%= Constant.CTRL_COLLECTOR_ADDRESS %>";//硬件服务器地址
</script>
<style>
	.dialog_form{margin:0;padding:10px 30px;}
	.ftitle{font-size:14px;font-weight:bold;color:#666;padding:5px 0;margin-bottom:10px;border-bottom:1px solid #ccc;}
	.fitem{margin-bottom:5px;}
	.fitem label{display:inline-block;width:80px;}
	*{
		font-family:"Microsoft YaHei","黑体","宋体","Arial",sans-serif;
	}
</style>
