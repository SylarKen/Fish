<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<form id="dataDict_search_form"  method="post" action='<%=basePath %>dataDict/query'>
         <table id="SysLog_search" style="margin-top:10px;margin-left:30px;font-size:14px;">
             <tr>
                 <td>类型：</td>
                 <td>
                     <input class="easyui-textbox" type="text" id="SysDataDict_type" name="type"/>
                 </td>
                 <td>键：</td>
                 <td>
                     <input class="easyui-textbox" type="text" id="SysDataDict_key" name="key"/>
                 </td>
                 <td>
                     <a href="javascript:void(0);" class="easyui-linkbutton" iconcls="icon-search" onclick="search_load('dataDict-table', 'dataDict_search_form')">查询</a>
                 </td>
             </tr>
         </table>
    </form>
    <table id="dataDict-table"></table>
    

<div id="dataDict-dialog" class="easyui-dialog" style="width:400px;height:300px;padding:10px 20px" closed="true" buttons="#dataDict-dialog-buttons">
  <form id="dataDict-form" class="dialog_form" name="dataDictForm" method="post">
  	  <div class="fitem">
  	   <input type="hidden" name="id">
  	  </div>
  	  <div class="fitem">
      <label>类型:</label>
       <input id="dataDict_type"  name="type" class="easyui-textbox" required="true" data-options="width:'180px'" >
 	 </div>
  	  <div class="fitem">
      <label>键:</label>
       <input id="dataDict_key"  name="key" class="easyui-textbox" required="true" data-options="width:'180px'" >
 	 </div>
      <div class="fitem">
      <label>值:</label>
      <input id="dataDict_value"  name="value" class="easyui-textbox" required="true" data-options="width:'180px'" >
    </div>
      <div class="fitem">
      <label>备注:</label>
      <input class="easyui-textbox" type="text" name="memo"   data-options="multiline:true,width:'180px',height:'60px'">
    </div>
    <div class="fitem" id="ddd">
      <label>是否可用:</label>
      <input id="dataDict_df" name="delete_flag" class="easyui-textbox" data-options="width:'180px'">
    </div>
  </form> 	
</div>
<div id="dataDict-dialog-buttons">
  <a id="dataDict_sava" href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
  <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dataDict-dialog').dialog('close')">取消</a>
</div>
	<script>
	var url;//表单action值

$("#dataDict_df").combobox({
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
	valueField: 'value'
});
 
$("#dataDict-table").datagrid({
	columns: [[
		{field:'id', checkbox:true},
		{field:'type', title:'类型',width: 100},
		{field:'key', title:'键',width: 100},
		{field:'value', title:'值',width: 100},
		{field:'memo', title:'说明',width: 100},
		{field:'creator', title:'创建人',width: 100},
		{field:'createTime', title:'创建时间',width: 100,formatter:dateFormatter},
		{field:'lastEditor', title:'修改人',width: 100},
		{field:'lastEditTime', title:'修改时间',width: 100,formatter:dateFormatter},
		{field:'delete_flag',title: '是否可用',sortable: true,width: 80,
			formatter: function (value, row) {
				if (value == false) return '<span style=color:green; >是</span>';
				if (value == true) return '<span style=color:red; >否</span>';
			}    
        }
	]],
	fitColumns: true,//自动调整列的尺寸以适应网格的宽度并且防止水平滚动
	height:pageSize().height-190,
	idField: 'id',
	nowrap: true,//把数据显示在一行里
	pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
	pageSize: 20, //每一页多少条数据
	pagination: true,
	rownumbers: true,//行号
	striped: true, //奇偶行是否区分
	singleSelect: true,//设置为true，只允许选中一行
	sortName: 'type',
	toolbar: [
		{	
			url:'dataDict/add',
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				$('#dataDict-dialog').dialog('open').dialog('setTitle','新增数据');
				$('#ddd').hide();
				$('#dataDict-form').form('clear');
				url = webContext + 'dataDict/add';
			}
		},
		'-',
		{	
			url:'dataDict/edit',
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var row = $('#dataDict-table').datagrid('getSelected');
				if(row) {
					$('#dataDict-dialog').dialog('open').dialog('setTitle','编辑数据');
					$('#ddd').show();
					$('#dataDict-form').form('load',row);
					url = webContext + 'dataDict/edit';
				} else {
					 $.messager.alert("温馨提示", "请先选中一个数据！");
				}
			}
		},
		'-',
		{	
			url:'dataDict/del',
			text:'删除',
			iconCls:'icon-cut',
			handler:function(){
				var row = $('#dataDict-table').datagrid('getSelected');
				if (row){
					$.messager.confirm('Confirm','您确认要删除该数据吗？',function(r){
						if (r){
							$.post(webContext + 'dataDict/delete', {"id":row.id}, function(result){
								
								if (result.errorMsgFlag){
									$.messager.alert({
										title: 'Error',
										msg: result.errorMsg
									});
								} else {
									$('#dataDict-table').datagrid('reload');	// reload the user data
								}
							},'json');
						}
					});
				} else {
					 $.messager.alert("温馨提示", "请先选中一个数据！");
				}
			}
		}
	],
	url: webContext + 'dataDict/query'
});
actionButtonCtr('dataDict-table');

function save() {
	var form = $("#dataDict-form");
	if(form.form("validate")){
		$("#dataDict_sava").linkbutton("disable");//保存过程中按钮置灰
		$.post(url,getFormJson("dataDict-form"),function(result){
			$("#dataDict_sava").linkbutton("enable");//保存完毕后按钮恢复	
		    if (result.errorMsgFlag){
				$.messager.alert({
					title: 'Error',
					msg: result.errorMsg
				});
			} else {
				$('#dataDict-dialog').dialog('close');
				$('#dataDict-table').datagrid('reload');
			}
		});
	}  
}   
	</script>

  
  </body>
</html>
