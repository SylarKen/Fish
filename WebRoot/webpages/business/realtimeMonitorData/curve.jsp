<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'curve.jsp' starting page</title>
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
  <div class="easyui-layout" style="width:100%;height:100%;" >
    <div region="west" split="true" title="传感器列表" style="width:15%;">
    	<div id="curve_sensor_list" ></div>
    </div>
    <div region="center" title="监控数据曲线">
    <div style="width:100%;height:7%;">
    <form id="curve_monitorData_search_form" style="margin:5px 5px;">
			<table id="flow_search" style="word-break: keep-all;font-size:14px">
				<tr>
					<td style="display:none">池塘：</td>
					<td style="display:none">
					<input type="text" id="curve_monitorData_pond" >
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>传感器：</td>
					<td>
					<input type="text" id="curve_monitorData_device" name="collector">
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a href="#" class="easyui-linkbutton"
						iconcls="icon-search"
						onclick="load_monitorDataCurveB('#curve_monitorData_device')">查询</a></td>
				</tr>
			</table>
		</form>
		</div>
    <div id="curve_panel" class="easyui-layout" style="width:100%;height:90%;" >
    <div region="center" title="传感器实时曲线" style="height:55%;" >
    <div id="curve_monitorData_TO" style="width: 98%;height:85%;"></div>
    </div>
    </div>
</div>
</div>
<script type="text/javascript">
var flag_PH,flag_TO;
var isOk = true;
$(function() {
	$('#curve_monitorData_device').combobox({
		valueField: 'deviceCode',
		textField: 'deviceName',
		panelHeight:'auto'
	});
	
	$('#curve_sensor_list').tree({
		url: '${basePath}realtimeMonitorData/pondTree',
		onSelect:function(node){
			if(node.id.length==7){
			$.post('${basePath}' + 'realtimeMonitorData/queryDeviceByPond',{pondCode:node.id},function(r){
				r = eval("("+ r+ ")");
				//debugger;
				//r = jQuery.parseJSON(r);
				$("#curve_monitorData_device").combobox('clear');
				$("#curve_monitorData_device").combobox('loadData',r);
			});
			}
			},
			onLoadSuccess:function(node,data){
				var roots=$('#curve_sensor_list').tree('getRoots');
				for(var i=0;i<roots.length;i++){
					  children=$('#curve_sensor_list').tree('getChildren',roots[i].target);
					  for(var j=0;j<children.length;j++){
						  if(children[j].id.length==7){
							  $('#curve_sensor_list').tree("select",children[j].target); 
							 	break;
						  }
					  }
					  var defaultId=$('#curve_sensor_list').tree("getSelected").id; 
					  $("#curve_monitorData_device").combobox({
						  url:'${basePath}realtimeMonitorData/queryDeviceByPond',
						  queryParams:{"pondCode":defaultId},
						  onLoadSuccess:function(){
							  var data = $(this).combobox('getData');
							  console.log('=============== data: ' + JSON.stringify(data));
							  var code=null;
							  if(data.length>0){
							  code=data[0].deviceCode;
							  }
							  $(this).combobox('select', code);
							 // $("#curve_panel").layout('collapse','south');
							  if(isOk==true){
								  load_monitorDataCurve('#curve_monitorData_device');
								  isOk = false;
							  }
							  
						  }
					  });
					 }
			}
	});
});
	function load_monitorDataCurveB(id){
		//$("#curve_panel").layout('collapse','south');
		load_monitorDataCurve(id);
	}
	function load_monitorDataCurve(id){
		//$("#curve_panel").layout('collapse','south');
		clearInterval(flag_TO);
		//var deviceCode=$(id).combobox('getValue');
		$.post('${basePath}' + 'historyData/querySensorID',{sensorID:$(id).combobox('getValue')},function(r){
				r = eval("("+ r+ ")");
				var dataKind = r.dataKind;
				
				//溶氧度传感器
				if(dataKind == LXBH_CGQ_RYWD){
					var monitorData_TO_curve = echarts.init(document.getElementById('curve_monitorData_TO'));	
					var dd = new Date(); 
					dd.setDate(dd.getDate()+1); 
					var dateEnd = dd.getFullYear()+"-"+(dd.getMonth()+1)+"-"+dd.getDate();	
					var dd2 = new Date(); 
					dd2.setDate(dd2.getDate()); 
					var dateStart = dd2.getFullYear()+"-"+(dd2.getMonth()+1)+"-"+dd2.getDate();	
					 $.post('${basePath}' + 'historyData/oxygen_lineForCurve',{deviceCode:$(id).combobox('getValue'),startTime:dateStart,endTime:dateEnd},function(r){
							r = eval("("+ r+ ")");
							option_CG = {
									    title: {
									        text: '溶氧度、温度实时曲线',
									        x: 'center',
									        align: 'right'
									    },
									    tooltip: {
									        trigger: 'axis'
									    },
									    legend: {
									        data:['溶氧度','温度'],
									        x: 'left',
									    },
									    toolbox: {
									        feature: {
									            saveAsImage: {}
									        }
									    },
									    dataZoom: {
									        show: false,
									        start: 0,
									        end: 100
									    },
									    xAxis: [{
									        type: 'category',
									        boundaryGap: false,
									        data: r.date
									    }],
									    yAxis:[
									            {
									                type: 'value',
									                scale: true,
									                name: '溶氧度',
									                max: 15,
									                min: 0,
									                boundaryGap: [0.1, 0.1],
									                axisLabel: {
									                    formatter: '{value}mg/L '
									                }
									            },
									            {
									                type: 'value',
									                scale: true,
									                name: '温度',
									                max: 30,
									                min: 0,
									                boundaryGap: [0.1, 0.1],
									                axisLabel: {
									                    formatter:'{value}°C'
									                }
									            }
									        ],
									    series: [
									        {	name:'溶氧度',
									            type:'line',
									            smooth:true,
									            yAxisIndex: 0, 
									            data: r.oxygen
									        },{
									        	name:'温度',
									            type:'line',
									            smooth:true,
									            yAxisIndex: 1, 
									            data: r.temperature
									        }
									    ]
									};
							
							monitorData_TO_curve.setOption(option_CG);
						});
					
				 flag_TO=setInterval(function (){	
					 if($("#curve_monitorData_device").length>0){
							var dd = new Date(); 
							dd.setDate(dd.getDate()+1); 
							var dateEnd = dd.getFullYear()+"-"+(dd.getMonth()+1)+"-"+dd.getDate();	
							var dd2 = new Date(); 
							dd2.setDate(dd2.getDate()); 
							var dateStart = dd2.getFullYear()+"-"+(dd2.getMonth()+1)+"-"+dd2.getDate();
						    $.post('${basePath}' + 'historyData/oxygen_lineForCurve',{deviceCode:$(id).combobox('getValue'),startTime:dateStart,endTime:dateEnd},function(r){
									r = eval("("+ r+ ")");
									option_CG.xAxis[0].data = r.date;
									option_CG.series[0].data = r.oxygen;
									option_CG.series[1].data = r.temperature;
									monitorData_TO_curve.setOption(option_CG);
							 });   
					 }
					}, 5000);	
				}else 
				//PH值传感器
				if(dataKind == LXBH_CGQ_PH){
					var deviceCode=$('#curve_monitorData_device').combobox('getValue');
					var monitorData_PH_curve = echarts.init(document.getElementById('curve_monitorData_TO'));
					var dd = new Date(); 
					dd.setDate(dd.getDate()+1); 
					var dateEnd = dd.getFullYear()+"-"+(dd.getMonth()+1)+"-"+dd.getDate();	
					var dd2 = new Date(); 
					dd2.setDate(dd2.getDate()); 
					var dateStart = dd2.getFullYear()+"-"+(dd2.getMonth()+1)+"-"+dd2.getDate();
					$.post('${basePath}' + 'historyData/PH_lineForCurve',{deviceCode:deviceCode,startTime:dateStart,endTime:dateEnd},function(r){
						r = eval("("+ r+ ")");
						option_PH = {
								    title: {
								        text: 'PH实时曲线',
								        x: 'center',
								        align: 'right'
								    },
								    tooltip: {
								        trigger: 'axis'
								    },
								    legend: {
								        data:['PH'],
								        x: 'left'
								    },
								    toolbox: {
								        feature: {
								            saveAsImage: {}
								        }
								    },
								    dataZoom: {
								        show: false,
								        start: 0,
								        end: 100
								    },
								    xAxis: [{
								        type: 'category',
								        boundaryGap: false,
								        data: r.date
								    }],
								    yAxis:[
								            {
								                type: 'value',
								                scale: true,
								                name: 'PH',
								                max: 15,
								                min: 0,
								                boundaryGap: [0.1, 0.1],
								                axisLabel: {
								                    formatter: '{value} '
								                }
								            }
								        ],
								    series: [
								        {	name:'PH',
								            type:'line',
								            smooth:true,
								            yAxisIndex: 0, 
								            data: r.PH
								        }
								    ]
								};
						
						monitorData_PH_curve.setOption(option_PH);
					});
					
					flag_TO=setInterval(function (){
						if($("#curve_monitorData_device").length>0){
							var dd = new Date(); 
							dd.setDate(dd.getDate()+1); 
							var dateEnd = dd.getFullYear()+"-"+(dd.getMonth()+1)+"-"+dd.getDate();	
							var dd2 = new Date(); 
							dd2.setDate(dd2.getDate()); 
							var dateStart = dd2.getFullYear()+"-"+(dd2.getMonth()+1)+"-"+dd2.getDate();
							var deviceCode=$('#curve_monitorData_device').combobox('getValue');
							$.post('${basePath}' + 'historyData/PH_lineForCurve',{deviceCode:deviceCode,startTime:dateStart,endTime:dateEnd},function(r){
								r = eval("("+ r+ ")");	
								option_PH.xAxis[0].data = r.date;
								option_PH.series[0].data = r.PH;
							    monitorData_PH_curve.setOption(option_PH);
							    
						    });
						}
						}, 5000);	
				}
				
		});	
		}
</script>
  </body>
</html>
