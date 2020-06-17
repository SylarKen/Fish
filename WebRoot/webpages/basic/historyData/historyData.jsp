<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>恒丰纺织</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body >
		<div class="easyui-layout" style="width:100%;height:100%;"data-options="fit:true">
		   <div region="west" split="true" title="传感器列表" style="width:15%;">
    	    <div id="history_sensor_list" ></div>
           </div>
		<div data-options="region:'center'" style="height:100%;">
		 <div class="easyui-layout" data-options="fit:true" style="height:100%;">
		 			<div data-options="region:'north'" style="height:7%;">
	    				<form id="general_search_form" style="margin:0 0;">
							<table id="flow_search" style="word-break: keep-all;font-size:1%">
								<tr>
									<td>起始日期：</td>
									<td><input name="startTime" id="general_countTime"/></td>
									<td>结束日期：</td>
									<td>
									   <input name="endTime" id="general_countTime2"/>
									</td>
									<td>
										 <input type = "hidden" name="endTimeHidden" id="general_countTime3" />
									</td>
									<td>
										 <input type = "hidden" name="dataKind" id="dataKind" />
									</td>
									<td>传感器名称：</td>
									<td>
					  					<input type="text" id="history_monitorData_device" name="sensorID">
									</td>
									<td  style="padding-left: 1%"><a  href="#" class="easyui-linkbutton" iconcls="icon-search"
										onclick="search_load_history('#history_monitorData_device')">查询</a></td>
								
									<td style="padding-left: 8%" ><a href="#" class="easyui-linkbutton" iconcls="icon-download"
										onclick="exportExcel()">导出Excel表格</a></td>	
								</tr>
							</table>
						</form>
					</div>
				<!-- center曲线 -->	
				<div data-options="region:'center'"  style="height:45%;">
					 <div id = "tabsCenter" class="easyui-tabs" style="width:100%;height:100%">
							<div  title="溶氧温度曲线" style="padding:1px;">
							    <div  id="Oxygen_line" style="width: 98%;height:98%"></div>
							</div>
							<div title="PH值曲线" style="padding:1px">
								<div  id="PH_line" style="width: 98%;height:98%;"></div>
							</div>
					</div>				
				</div>	
				<!-- south图表 -->	
				 <div data-options="region:'south'" style="height:45%;"> 
				<div id = "tabsSouth" class="easyui-tabs" style="width:100%;height:100%" >
							<div  title="溶氧温度数据" style="padding:1px;width: 99%;height:99%">
							   <table class="easyui-datagrid" style="width: 92%;height:92%" id="count_general_grid" ></table>
							</div>
							<div title="PH值数据" style="padding:1px;width: 99%;height:99%">
								<table class="easyui-datagrid" style="width: 92%;height:92%" id="count_general_grid2" ></table> 
							</div>
				</div>		
				</div>  
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	    var isOk = true;
		$(function() {
			$('#history_monitorData_device').combobox({
				valueField: 'deviceCode',
				textField: 'deviceName',
				panelHeight:'auto'
			});
			//获取当前日期
			var dd = new Date(); 
			dd.setDate(dd.getDate()-1); 
			var date = dd.getFullYear()+"-"+(dd.getMonth()+1)+"-"+dd.getDate();	
			var dd2 = new Date(); 
			dd2.setDate(dd2.getDate()); 
			var date2 = dd2.getFullYear()+"-"+(dd2.getMonth()+1)+"-"+dd2.getDate();
			//$('#general_countTime').datebox({ value : date });
			$('#general_countTime').datebox({ value : date });
			$('#general_countTime2').datebox({ value : date2 });
			$('#general_countTime3').datebox({ value : date2 });
			//传感器树
			$('#history_sensor_list').tree({
				url: '${basePath}realtimeMonitorData/pondTree',
				onSelect:function(node){
					if(node.id.length==7){
					$.post('${basePath}' + 'realtimeMonitorData/queryDeviceByPond',{pondCode:node.id},function(r){
						r = eval("("+ r+ ")");
						//debugger;
						//r = jQuery.parseJSON(r);
						$("#history_monitorData_device").combobox('clear');
						$("#history_monitorData_device").combobox('loadData',r);
						
					});
					}
					},
					onLoadSuccess:function(node,data){
						var roots=$('#history_sensor_list').tree('getRoots');
						for(var i=0;i<roots.length;i++){
							  children=$('#history_sensor_list').tree('getChildren',roots[i].target);
							  for(var j=0;j<children.length;j++){
								  if(children[j].id.length==7){
									  $('#history_sensor_list').tree("select",children[j].target); 
									 	break;
								  }
							  }
							  var defaultId=$('#history_sensor_list').tree("getSelected").id; 
							  $("#history_monitorData_device").combobox({
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
									  $("#curve_panel").layout('collapse','south');
									  
									  if(isOk==true){
										  search_load_history('#history_monitorData_device'); 
										  isOk = false;
									  }
								  }
								 
							  });
							  
							 }
					}
					
			});	
	
		});
		
		//打开溶氧温度曲线数据 关闭PH曲线数据
		function showOxygenTabs(){
			//"溶氧温度数据" "PH值数据""PH值曲线"
			tab_option1 = $('#tabsCenter').tabs('getTab',"溶氧温度曲线").panel('options').tab;  
			tab_option2 = $('#tabsSouth').tabs('getTab',"溶氧温度数据").panel('options').tab; 
			tab_option3 = $('#tabsCenter').tabs('getTab',"PH值曲线").panel('options').tab;  
			tab_option4 = $('#tabsSouth').tabs('getTab',"PH值数据").panel('options').tab; 
			tab_option1.show(); 
			tab_option2.show(); 
			tab_option3.hide(); 
			tab_option4.hide(); 
			$('#tabsCenter').tabs('select',"溶氧温度曲线");
			$('#tabsSouth').tabs('select',"溶氧温度数据");
		}
		//关闭溶氧温度曲线数据,打开PH曲线数据
		function closeOxygenTabs(){
			tab_option1 = $('#tabsCenter').tabs('getTab',"溶氧温度曲线").panel('options').tab;  
			tab_option2 = $('#tabsSouth').tabs('getTab',"溶氧温度数据").panel('options').tab; 
			tab_option3 = $('#tabsCenter').tabs('getTab',"PH值曲线").panel('options').tab;  
			tab_option4 = $('#tabsSouth').tabs('getTab',"PH值数据").panel('options').tab; 
			tab_option3.show(); 
			tab_option4.show(); 
			tab_option1.hide(); 
			tab_option2.hide();	
			$('#tabsCenter').tabs('select',"PH值曲线");
			$('#tabsSouth').tabs('select',"PH值数据");
		}
		
		//加载数据和曲线
		function search_load_history(id){
			var startT=$('#general_countTime').datebox('getValue');
			var endT = $('#general_countTime2').datebox('getValue');
			var endTHidden = $('#general_countTime3').datebox('getValue');
			var date1=dateFormatter1(endT).getTime()-dateFormatter1(startT).getTime(); //时间差的毫秒数
			var date2=dateFormatter1(startT).getTime()-dateFormatter1(endTHidden).getTime();
			var date3=dateFormatter1(endT).getTime()-dateFormatter1(endTHidden).getTime();
			//计算出相差天数
			var days1=Math.floor(date1/(24*3600*1000));//endT-startT
			var days2=Math.floor(date2/(24*3600*1000));//startT-hidden
			var days3=Math.floor(date3/(24*3600*1000));//endT-hidden
			if(date2>-1){
				$.messager.alert('提示','起始日期不能超过当前日期!');
				return;
			}else if(days3>0){
				$.messager.alert('提示','结束日期不能超过当前日期!');
				return;
			}else if(days1>30){
				$.messager.alert('提示','起始日期和结束日期不能超过30天!');
				return;
			}else if(days1<0){
				$.messager.alert('提示','起始日期不能超过结束日期!');
				return;
			}
			var height=$('#tabsSouth').height();
			$.post('${basePath}' + 'historyData/querySensorID',{sensorID:$(id).combobox('getValue')},function(r){
				r = eval("("+ r+ ")");
				var dataKind = r.dataKind;
				$('#dataKind').val(dataKind);
				//溶氧温度传感器
				if(dataKind == LXBH_CGQ_RYWD){
					showOxygenTabs();
					$('#count_general_grid').datagrid(
							{
							url : '${basePath}'+ 'historyData/oxygenTemperature',
							nowrap : true,
							idField : 'id',
							fit:true,
							height:height,
							striped : true, // 奇偶行是否区分
							singleSelect : true,// 单选模式
							rownumbers : true,// 行号
							sortName: 'time',
							pagination : true,
							pageSize : 5, // 每一页多少条数据
							pageList : [5,10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
							pagePosition : 'bottom',
							queryParams:{deviceCode:$(id).combobox('getValue'),startTime:$('#general_countTime').datebox('getValue'),endTime:$('#general_countTime2').datebox('getValue')},
						   	fitColumns: true,//自动调整列的尺寸以适应网格的宽度并且防止水平滚动
						   	frozenColumns:[[    
										{field : 'id',title : '',checkbox : true},
										{field : 'sensorID',title : '传感器编码',width : 100},
										{field : 'deviceName',title : '传感器名称',width : 120}
							            ]],
							columns : [ [
									{field : 'oxygen',title : '溶氧度(mg/L)',width : 60},
									{field : 'temperature',title : '温度(℃)',width : 60},
									{field : 'time',title : '采集时间',width : 100,formatter:timeFormatter}
									 ] ]
							});	
					var Oxygen_line = echarts.init(document.getElementById('Oxygen_line'));
					$.post('${basePath}' + 'historyData/oxygen_line',{deviceCode:$(id).combobox('getValue'),startTime:$('#general_countTime').datebox('getValue'),endTime:$('#general_countTime2').datebox('getValue')},function(r){
						r = eval("("+ r+ ")");
						option_oxygen = {
								    title: {
								        text: '溶氧度、温度历史曲线',
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
								            //step:'start',
								            smooth:true,
								           // itemStyle: {normal: {areaStyle: {type: 'default'}}},
								          /*   xAxisIndex: 0,*/
								            yAxisIndex: 0, 
								            data: r.oxygen
								        },{
								        	name:'温度',
								            type:'line',
								           // step:'start',
								            smooth:true,
								           // itemStyle: {normal: {areaStyle: {type: 'default'}}},
								            /* xAxisIndex: 0,*/
								            yAxisIndex: 1, 
								            data: r.temperature
								        }
								    ]
								};
						
						Oxygen_line.setOption(option_oxygen);
					});
					
				}else 
				//PH值传感器
				if(dataKind == LXBH_CGQ_PH){
					closeOxygenTabs();
					//closeOxygenTabs();
					//$('#count_general_grid2').datagrid("load", getFormJson("general_search_form"));
					$('#count_general_grid2').datagrid(
							{
							url : '${basePath}'+ 'historyData/PHSensor',
							nowrap : true,
							idField : 'id',
							fit:true,
							striped : true, // 奇偶行是否区分
							singleSelect : true,// 单选模式
							rownumbers : true,// 行号
							sortName: 'sensorID',
							pagination : true,
							pageSize : 5, // 每一页多少条数据
							pageList : [5,10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
							pagePosition : 'bottom',
							queryParams:{deviceCode:$(id).combobox('getValue'),startTime:$('#general_countTime').datebox('getValue'),endTime:$('#general_countTime2').datebox('getValue')},
						   	fitColumns: true,//自动调整列的尺寸以适应网格的宽度并且防止水平滚动
						   	frozenColumns:[[    
										{field : 'id',title : '',checkbox : true},
										{field : 'sensorID',title : '传感器编码',width : 100},
										{field : 'deviceName',title : '传感器名称',width : 120}
							            ]],
							columns : [ [
				                    {field : 'PH',title : 'PH值',width : 70},
									{field : 'time',title : '采集时间',width : 70,formatter:timeFormatter}
									 ] ]
							});	
					
					var PH_line = echarts.init(document.getElementById('PH_line'));
					$.post('${basePath}' + 'historyData/PH_line',{deviceCode:$(id).combobox('getValue'),startTime:$('#general_countTime').datebox('getValue'),endTime:$('#general_countTime2').datebox('getValue')},function(r){
						
						r = eval("("+ r+ ")");
						option_PH = {
								    title: {
								        text: 'PH历史曲线',
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
								            //step:'start',
								            smooth:true,
								           // itemStyle: {normal: {areaStyle: {type: 'default'}}},
								          /*   xAxisIndex: 0,*/
								            yAxisIndex: 0, 
								            data: r.PH
								        }
								    ]
								};
						
						PH_line.setOption(option_PH);
					});
					
					
					
					
					
				}
			});
		}
		
		
		
		function exportExcel(){
			var urlParam = getFormJson("general_search_form");
			window.location.href = webContext + 'historyData/export?' + $.param(urlParam);
		}
		/**
		 * 日期格式化
		 */
		function dateFormatter1(e) {

			if (typeof (e) == "string") {// 如果是string或number(毫秒数)类型
				// 表示通过.Net MVC提供的 return Json(result,
				// JsonRequestBehavior.AllowGet);方式返回的/Date(1332919782070)/日期格式
				if (e.indexOf("Date") > 0) {
					/* json格式时间转js时间格式 */
					var value = e.substr(1, e.length - 2);
					var obj = eval('(' + "{Date: new " + value + "}" + ')');
					var date = obj["Date"];
					if (date.getFullYear() < 1900) {
						return "";
					}			
					return date;
				}	 
				// 表示其他字符串或数字格式日期
				var date = new Date(e);
				return date;
			} else if (typeof (e) == "number") {
				var date = new Date(e);
				return date;
			} else if (e) {// 如果是Date类型
				return e;
			} else {
				return "";
			}

		}
		
		
		function exportExcel() {
	 		$.messager.confirm('确认', '确认把该搜索结果导出Excel表格 ？', function(r) {
				if (r) {
					var startTime = $('#general_countTime').datebox('getValue');
					var endTime = $('#general_countTime2').datebox('getValue');
					var deviceCode = $('#history_monitorData_device').combobox('getValue');
					var dataKind = $('#dataKind').val(); 	
					var urlParam = getFormJson("general_search_form");
					$.messager.progress({
						title : '处理中',
						msg : '请稍后',
					});
					$.messager.progress('close');
					window.location.href= "${basePath}historyData/exportExcel?startTime="+startTime+"&endTime="+endTime+"&deviceCode="+deviceCode+"&dataKind="+dataKind;
					//window.location.href = webContext + 'historyData/exportExcel?' + $.param(urlParam);
				}
			}); 
	 		
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	</script>
</body>
</html>
