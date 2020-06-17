<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>开票员能够看到的首页！</title>

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
<!-- <div class="easyui-panel" data-options="width:'49%',height:'49%'"></div> -->
<div id="top" class="easyui-layout" style="width:100%;height:50%;">   
	<div data-options="region:'center',split:true" style="width:100%;">
		<div id="index_send_orders_info" style="padding:5px;">
			<span>共<span id="index_send_orders_list_count" style="padding:0 5px;color:blue;">25</span>发货单</span>
			<span style="float:right;"><a href="javascript:void(0);" onClick="moreSendOrders()">更多</a></span>
		</div>
		<div id="index_send_orders_list"></div>
	</div>
</div>  
<div id="down" class="easyui-layout" style="width:100%;height:50%;">   
	<div data-options="region:'center',split:true" style="width:50%;">
		<div id="index_chart" style="height:100%;"></div>
	</div>
</div>  
<script type="text/javascript">


$('#index_send_orders_list').datagrid({
	url: webContext + 'business/querySendOrders',
	fit: true,
	fitColumns: true,
	singleSelect: true,
	nowrap: true,
	collapsible: true,
	autoRowHeight: false,
	striped: true, //奇偶行是否区分
	rownumbers: true,//行号
	columns: [[
        { field: 'sendId', title: '发货单主键', width: 100,hidden:true},
        { field: 'code', title: '发货单号', width: 150},    
        //{ field: 'sendCode', title: '用友发货单号', width: 150}, 
        //{ field: 'sendTime', title: '发货单日期', width: 150,formatter:dateFormatter },  
        { field: 'customerName', title: '客户名称', width: 150},                                       
        { field: 'to_address', title: '送货地址', width: 200 }, 
        { field: 'busCode', title: '车牌号码', width: 100},  
        { field: 'busDriverName', title: '驾驶员', width: 100},  
        { field: 'busDriverCode', title: '驾驶员证件', width: 150,hidden:true},  
        { field: 'freight', title: '运费', width: 100,hidden:true},  
        { field: 'deptName', title: '所属部门', width: 100 },  
        //{ field: 'saleChannel', title: '业务类型编码', width: 100,hidden:true},
        { field: 'saleChannelName', title: '业务类型', width: 100},
        
        { field: 'sendTotalMoney', title: '订单金额', width: 100 ,hidden:true},  
        { field: 'saleUser_realname', title: '业务员', width: 100 },  
        { field: 'emergency_status', title: '紧急状态', width: 100 ,hidden:true,formatter:function(value,row){
        	if (value == 1) return '<span style=color:black; >一般</span>';
        	if (value == 2) return '<span style=color:green; >加急</span>';
        	if (value == 3) return '<span style=color:red; >特急</span>';
        } },  
       
        { field: 'needTime', title: '需求日期', width: 100,formatter:timeFormatter,hidden:true},  
    
        
        { field: 'status', title: '发货单状态', width: 100 ,formatter:function(value,row){
        	if (value == 0) return '<span style=color:black; >由订单生成</span>';
        	if (value == 1) return '<span style=color:black; >新增发货单生产</span>';
			if (value == 2) return '<span style=color:red; >已审核</span>'; 
			if (value == 3) return '<span style=color:green; >已发货</span>'; 
			if (value == 4) return '<span style=color:blue; >已反审</span>'; 
        }},
        //{ field: 'orderCode', title: '订单号', width: 100},
        //{ field: 'orderTime', title: '下单时间', width: 100 ,formatter:timeFormatter},
        { field: 'username', title: '内勤用户名', width: 100 }
	]],
	onLoadSuccess: function(data) {
		$('#index_send_orders_list_count').html(data.total);
	}
});


function moreSendOrders() {
	tabManager('main_center_tabs','发货单管理',webContext + 'business/sendOrder');
}

require.config({
    paths: {
        echarts: webContext + 'js/ECharts'
    }
});

//使用
require(
    [
        'echarts',
        'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
    ],
    function (ec) {
        // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('index_chart')); 
        
        var option = {
            tooltip: {
                show: true
            },
            legend: {
                data:['销量']
            },
            xAxis : [
                {
                    type : 'category',
                    data : ["一月","二月","三月","四月","五月","六月","七月","八月", "九月"]
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    "name":"销量",
                    "type":"bar",
                    "data":[5, 20, 40, 10, 10, 20, 15, 30, 40]
                }
            ]
        };

        // 为echarts对象加载数据 
        myChart.setOption(option); 
    }
);
</script>
</body>
</html>