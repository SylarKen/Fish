<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	Map<Object,Object> user = (Map<Object,Object>)session.getAttribute("user");	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>绩效考核系统</title>
<%-- <jsp:include page="/common.jsp"></jsp:include> --%>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="实时监控">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#map_label{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
</style>
</head>
<body>
	<div class="easyui-layout" style="width:100%;height:100%;">
		<div region="west" split="true" title="传感器列表" style="width:15%;">
			<div id="sensor_list"></div>
		</div>
		<div region="center" title="监控数据">
			<div style="width:100%;height:7%;">
				<form id="monitorData_search_form" style="margin:5px 5px;">
					<table id="flow_search" style="word-break: keep-all;font-size:14px">
						<tr>
							<td style="display:none">池塘：</td>
							<td style="display:none"><input type="text"
								id="monitorData_pond"></td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td>传感器：</td>
							<td><input type="text" id="monitorData_device"
								name="collector"></td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td><a href="#" class="easyui-linkbutton"
								iconcls="icon-search"
								onclick="search_monitorData('#monitorData_device','#sensor_list')">查询</a></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="easyui-layout" style="width:100%;height:92%;">
				<div region="west" border="false"
					style="width:25%;height:100%;border-top:1px solid #AED0EA;border-right:1px solid #AED0EA;">
					<div class="easyui-layout" border="false"
						style="width:100%;height:100%;">
						<div region="north" title="监控数据图" border="false"
							style="height:50%;border-bottom:1px solid #AED0EA">
							<div id="monitorData_chart" style="width: 100%;height:100%;"></div>
						</div>
						<div region="center" title="监控数据列表" border="false"
							style="height:50%;">
							<div id="monitorData_list" style="height:100%;"></div>
						</div>
					</div>
				</div>
				<div region="center" style="width:75%;height:100%;border-bottom:0px"
					title="地图标注">
					<div id="map_label" style="height:100%;"></div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	var flag=1;
	$('#monitorData_device').combobox({
		valueField: 'deviceCode',
		textField: 'deviceName',
		panelHeight:'auto'
	});
	
	$('#monitorData_pond').combobox({
		valueField: 'code',
		textField: 'name',
		panelHeight:'auto',
	});
	
	$('#monitorData_list').datagrid({
		onLoadSuccess:function(){
		$('#monitorData_list').datagrid("doCellTip");
		}
	});
	
	$('#sensor_list').tree({
		url: '${basePath}realtimeMonitorData/pondTree',
		onSelect:function(node){
			if(node.id.length==7){
				$("#monitorData_device").combobox('clear');
				$('#monitorData_device').combobox({
					  url:'${basePath}realtimeMonitorData/queryDeviceByPond',
					  queryParams:{"pondCode":node.id},
					  onLoadSuccess:function(){
						  var data = $(this).combobox('getData');
						  console.log('=============== data: ' + JSON.stringify(data));
						  var code=null;
						  if(data.length>0){
						  code=data[0].deviceCode;
						  }
						  $(this).combobox('select', code);
						  if(flag==1){
						  sensorListInit('#monitorData_device','#sensor_list');
						  flag=2;
						  }else{
						  sensorListLoad('#monitorData_device','#sensor_list');
						  }
						  load_monitorData('#monitorData_device','#sensor_list');
						  
					  }
				  });
				$.post('${basePath}' + 'realtimeMonitorData/queryLngLatOnly',{pondId:node.id},function(r){
					r = jQuery.parseJSON(r);
					//百度地图API功能
					var map = new BMap.Map("map_label");    // 创建Map实例
					var point=new BMap.Point(r[0].lng, r[0].lat);
					map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
					var marker = new BMap.Marker(point);  // 创建标注
					map.addOverlay(marker);              // 将标注添加到地图中
					marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
					map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
					map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
				});
			}
			},
		onLoadSuccess:function(node,data){
			var roots=$('#sensor_list').tree('getRoots');
			for(var i=0;i<roots.length;i++){
				  children=$('#sensor_list').tree('getChildren',roots[i].target);
				  for(var j=0;j<children.length;j++){
					  if(children[j].id.length==7){
						  $('#sensor_list').tree("select",children[j].target); 
						 	break;
					  }
				  }
				 }
		}
	});
});	

function fomatFloat(src,pos){ 
	return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos); 
	} 

function sensorListInit(id,pId){
	var deviceCode=$(id).combobox('getValue');
	var pondCode=$(pId).tree("getSelected").id; 
	var height=$('#monitorData_list').height();
	$('#monitorData_list').datagrid(
			{
			url : '${basePath}'+ 'realtimeMonitorData/query',
			queryParams:{deviceCode: deviceCode,
							pondCode:pondCode},
			fitColumns:true,
			fit:true,
			height:height,
			nowrap : true,
			idField : 'id',
			striped : true, // 奇偶行是否区分
			singleSelect : true,// 单选模式
			rownumbers : true,// 行号
			pagination : true,
			pageSize : 10, // 每一页多少条数据
			pageList : [10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
			pagePosition : 'bottom',
			
			columns : [ [
					{field : 'deviceName',title : '传感器名称',width : 100},
					{field : 'typeName',title : '传感器类型',width : 80,hidden:true},
					{field : 'sensorValue',title : '值',width : 150,
						formatter : function(value, row) {
							if(row.typeCode==LXBH_CGQ_RYWD){
								return '温度:'+row.value1+'℃'+';'+'溶氧度:'+row.value+'mg/L';
							}
							else if(row.typeCode==LXBH_CGQ_PH){
								return row.value;
							}else 
								return null;
						}
					},
					{field : 'updateValueTime',title : '检测时间',width : 120,
						formatter : function(value, row) {
						return timeFormatter(value);
					}
					},
					{field : 'humidityValue',title : '空气湿度',width : 120,hidden:true},
					{field : 'salinityValue',title : '盐度',width : 120,hidden:true},
					{field : 'windValue',title : '风力',width : 120,hidden:true},
					{field : 'windDirection',title : '风向',width : 120,hidden:true}
					] ],
			});	
}
 
function sensorListLoad(id,pId){
	var deviceCode=$(id).combobox('getValue');
	var pondCode=$(pId).tree("getSelected").id; 
	$('#monitorData_list').datagrid("load",{
		deviceCode: deviceCode,
		pondCode:pondCode
	});
}
 
function load_monitorData(id,pId){
	var deviceCode=$(id).combobox('getValue');
	
	var monitorData_chart = echarts.init(document.getElementById('monitorData_chart'));
	$.post('${basePath}' + 'realtimeMonitorData/queryChart',{deviceCode: deviceCode},function(r){
		r = eval("("+ r+ ")");
		var oxygen=null;
		var ph=null;
		var temperature=null;
		
		if(r[0].typeCode==LXBH_CGQ_RYWD){
		for(var i=0;i<r.length;i++){
				 oxygen=r[i].value;
				 oxygen=fomatFloat(oxygen,1);
				 temperature=r[i].value1;
				 temperature=fomatFloat(temperature,1);
		}
		}if(r[0].typeCode==LXBH_CGQ_PH){
			ph=r[0].value;
		}
		
		if(ph==null){
		monitorData_chart.setOption({
			tooltip : {
		        formatter: "{a} <br/>{b} : {c}%"
		    },
		    series : [
		         {
            name:'油表',
            type:'gauge',
            center : ['50%', '60%'],    // 默认全局居中
            radius : '70%',
            min:0,
            max:50,
            startAngle:145,
            endAngle:35,
            splitNumber:5,
            axisLine: {            // 坐标轴线
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
                    width: 5
                }
            },
            axisTick: {            // 坐标轴小标记
                splitNumber:2,
                length :10,        // 属性length控制线长
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: 'auto'
                }
            },
            axisLabel: {
                formatter:function(v){
                    switch (v + '') {
                        case '0': return '冷';
                        case '50': return '热';
                        default: return '';
                    }
                }
            },
            splitLine: {           // 分隔线
                length :15,         // 属性length控制线长
                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                    color: 'auto'
                }
            },
            pointer: {
                width:2
            },
             title : {
                show: true,
                offsetCenter: ['0%', -20],       // x, y，单位px
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: '#333',
                    fontSize : 12
                }
            },
            detail : {
                show : true,
                backgroundColor: 'rgba(0,0,0,0)',
                borderWidth: 0,
                borderColor: '#ccc',
                width: 100,
                height: 40,
                offsetCenter: ['0%', -35],       // x, y，单位px
                formatter:'{value}℃',
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: 'auto',
                    fontSize : 12
                }
            },
            data:[{value: temperature, name: '温度'}]
        },
        {
            name:'溶氧',
            type:'gauge',
            center : ['50%', '60%'],    // 默认全局居中
            radius : '70%',
            min:0,
            max:100,
            startAngle:325,
            endAngle:215,
            splitNumber:5,
            axisLine: {            // 坐标轴线
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: [[0.2, '#ff4500'],[0.8, '#48b'],[1, '#228b22']], 
                    width: 5
                }
            },
            axisTick: {            // 坐标轴小标记
            	splitNumber:2,
            	length :10,        // 属性length控制线长
                lineStyle: {       // 属性lineStyle控制线条样式
                    color: 'auto'
                }
            },
            axisLabel: {
                formatter:function(v){
                    switch (v + '') {
                        case '0' : return '低';
                        case '50' : return '中';
                        case '100' : return '高';
                    }
                }
            },
            splitLine: {           // 分隔线
                length :15,         // 属性length控制线长
                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                    color: 'auto'
                }
            },
            pointer: {
                width:2
            },
            title : {
                show: true,
                offsetCenter: ['0%', 20],       // x, y，单位px
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: '#333',
                    fontSize : 12
                }
            },
            detail : {
                show : true,
                backgroundColor: 'rgba(0,0,0,0)',
                borderWidth: 0,
                borderColor: '#ccc',
                width: 100,
                height: 40,
                offsetCenter: ['0%', 38],       // x, y，单位px
                formatter:'{value}mg/L',
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: 'auto',
                    fontSize : 12
                }
            },
            data:[{value: oxygen, name: '溶氧'}]
        },
		    ]
	    });
		}else{
			monitorData_chart.setOption({
				tooltip : {
			        formatter: "{a} <br/>{b} : {c}%"
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    series : [
			         {
	            name:'业务指标',
	            type:'gauge',
	            center : ['50%', '60%'],    // 默认全局居中
	            radius : 75,
	            min:0,
	            max:14,
	            splitNumber:14,
	            axisLine: {            // 坐标轴线
	                lineStyle: {       // 属性lineStyle控制线条样式
	                    width: 10
	                }
	            },
	            axisTick: {            // 坐标轴小标记
	                splitNumber: 2,   // 每份split细分多少段
	                length :4,        // 属性length控制线长
	            },
	             splitLine: {           // 分隔线
	                length: 8,         // 属性length控制线长
	                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
	                   
	                }
	            },
	            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
	                formatter: function(v){
	                    switch (v+''){
	                        case '0': return '酸';
	                        case '7': return '中';
	                        case '14': return '碱';
	                        default: return '';
	                    }
	                },
	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
	                    color: '#000',
	                    fontSize: 15,
	                }
	            },
	            pointer: {
	                width:3,
	                length: '90%',
	                color: 'rgba(255, 255, 255, 0.8)'
	            },
	           
	            title : {
	                show : true,
	                offsetCenter: [0, '80%'],       // x, y，单位px
	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
	                    color: '#000',
	                    fontSize: 15
	                }
	            },
	            detail : {
	                show : true,
	                backgroundColor: 'rgba(0,0,0,0)',
	                borderWidth: 0,
	                borderColor: '#ccc',
	                width: 100,
	                height: 40,
	                offsetCenter: [-20, 0],       // x, y，单位px
	                formatter:'{value}',
	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
	                    fontSize :15
	                }
	            },
	            data:[{value: ph, name: 'PH值'}]
	        }
			    ]
		    });
		}
	});
}
</script>
</body>
</html>
