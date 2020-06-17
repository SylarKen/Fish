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
<form id="collector_edit_form" method="post" action='${basePath}collector/collector_edit'>
	<table style="padding:20px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">编&nbsp;&nbsp;号：</td>
			<td>
				<input id="collector_edit_code" class="easyui-textbox" name="collectorCode" value="${collector.collectorCode }" readonly="readonly" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">序 列 号：</td>
			<td>
				<input id="collector_edit_id" class="easyui-textbox" name="collectorId" value="${collector.collectorId }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">名&nbsp;&nbsp;称：</td>
			<td>
				<input id="collector_edit_name" class="easyui-textbox" name="collectorName" value="${collector.collectorName }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">地&nbsp;&nbsp;区：</td>
			<td>
				<input id="collector_edit_areaName" name="areaName" value="${collector.areaName }" readonly="readonly" style="width:210px;" data-options="required:true" >
			    <input id="collector_edit_areaCode" name="areaCode" value="${collector.areaCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">养 殖 点：</td>
			<td>
				<input id="collector_edit_pointName" name="pointName" value="${collector.pointName }" readonly="readonly" style="width:210px;" >
			    <input id="collector_edit_pointCode" name="pointCode" value="${collector.pointCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">购买时间：</td>
			<td>
				<input id="collector_edit_buyDate" class="easyui-datebox" name="buyDate" value="${collector.buyDate }" style="width:210px;" data-options="required:true" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">生效时间：</td>
			<td>
				<input id="collector_edit_effectiveDate" class="easyui-datebox" name="effectiveDate" value="${collector.effectiveDate }"  style="width:210px;"  data-options="required:true" /> 
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">到期时间：</td>
			<td>
				<input id="collector_edit_expiringDate" class="easyui-datebox" name="expiringDate" value="${collector.expiringDate }"  style="width:210px;" data-options="required:true" /> 
			</td>
		</tr>	
		<tr style="height:40px;">
   			<td style="width:120px;text-align:right;">是否可用：</td>
   			<td>
   			    <select class="easyui-combobox" id="collector_edit_delete_flag" select_value="${collector.delete_flag }" name="delete_flag"  data-options="panelHeight:'auto',width:'210px'">
    				<option value="0">可用</option>
    				<option value="1">不可用</option>
   				</select>
   			</td>
   		</tr>
	</table>
</form>
<script type="text/javascript">
$(function() {
	$("#collector_edit_delete_flag").children("option[value='"+$('#collector_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');
	//选择区域对话框
	/* $('#collector_edit_areaName').textbox({
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
      	 	showSelectAreaDialog($("#collector_edit_areaCode").val(),function(row){
				$("#collector_edit_areaName").textbox('setValue',row.text);
				$("#collector_edit_areaCode").val(row.id);
	        });
        }
    });
	//选择机房对话框
	$('#collector_edit_pointName').textbox({
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
        	var area = $("#collector_edit_pointCode").val();
        	if(!area){
        		$.messager.alert("温馨提示", "请先选择所在地区！");
        		return;
        	}
      	 	showSelectPointDialog(area,function(row){
      	 		$("#collector_edit_pointName").textbox('setValue',row.name);
  	 		 	$("#collector_edit_pointCode").val(row.code);
	        });
        }
    }); */
	
});
</script>
</body>
</html>
