<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>渔业综合服务平台</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
</head>
<body>
<form id="collector_add_form" method="post" action='${basePath}collector/collector_add'>
	<table style="padding:20px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">序 列 号：</td>
			<td>
				<input id="collector_add_id" class="easyui-textbox" name="collectorId" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">名&nbsp;&nbsp;称：</td>
			<td>
				<input id="collector_add_name" class="easyui-textbox" name="collectorName" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">地&nbsp;&nbsp;区：</td>
			<td>
				<input id="collector_add_areaName" name="areaName"  style="width:210px;">
			    <input id="collector_add_areaCode" name="areaCode" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">养 殖 点：</td>
			<td>
				<input id="collector_add_pointName" name="pointName"  style="width:210px;">
			    <input id="collector_add_pointCode" name="pointCode" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">购买时间：</td>
			<td>
				<input id="collector_add_buyDate" class="easyui-datebox" name="buyDate" style="width:210px;" data-options="required:true" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">生效时间：</td>
			<td>
				<input id="collector_add_effectiveDate" class="easyui-datebox" name="effectiveDate"  style="width:210px;"  data-options="required:true" /> 
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">到期时间：</td>
			<td>
				<input id="collector_add_expiringDate" class="easyui-datebox" name="expiringDate"  style="width:210px;" data-options="required:true" /> 
			</td>
		</tr>	
	</table>
</form>
<script type="text/javascript">
$(function() {
	//选择区域对话框
	$('#collector_add_areaName').textbox({
		editable: false,
		width:210,
		buttonText:'查询',    
		iconAlign:'right',
		required:true,
		icons:[{
			iconCls:'icon-clear',
			handler: function(e){
				$(e.data.target).textbox('clear').textbox('textbox').focus();
			}
		}],
        onClickButton:function(){
      	 	showSelectAreaDialog($("#collector_add_areaCode").val(),function(row){
				$("#collector_add_areaName").textbox('setValue',row.text);
				$("#collector_add_areaCode").val(row.id);
	        });
        }
    });
	//选择机房对话框
	$('#collector_add_pointName').textbox({
    	editable: false,
    	width:210,
    	buttonText:'查询',    
        iconAlign:'right',
        required:true,
        icons:[{
			iconCls:'icon-clear',
			handler: function(e){
				$(e.data.target).textbox('clear').textbox('textbox').focus();
			}
		}],
        onClickButton:function(){
        	var areaCode = $("#collector_add_areaCode").val();
        	if(!areaCode){
        		$.messager.alert("温馨提示", "请先选择所在地区！");
        		return;
        	}
      	 	showSelectPointDialog(areaCode,function(row){
          	     $("#collector_add_pointName").textbox('setValue',row.name);
   	 		 	 $("#collector_add_pointCode").val(row.code);
	        });
        }
    });
	
});
</script>
</body>
</html>
