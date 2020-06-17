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
<form id="collectorNewGate_edit_form" method="post" action='${basePath}collectorNewGateway/collectorNewGate_edit'>
	<table style="padding:20px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">编&nbsp;&nbsp;号：</td>
			<td>
				<input id="collectorNewGateway_edit_code" class="easyui-textbox" name="collectorCode" value="${collectorNewGateway.collectorCode }" readonly="readonly" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">序 列 号：</td>
			<td>
				<input id="collectorNewGateway_edit_id" class="easyui-textbox" name="collectorId" value="${collectorNewGateway.collectorId }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">名&nbsp;&nbsp;称：</td>
			<td>
				<input id="collectorNewGateway_edit_name" class="easyui-textbox" name="collectorName" value="${collectorNewGateway.collectorName }" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">地&nbsp;&nbsp;区：</td>
			<td>
				<input id="collectorNewGateway_edit_areaName" name="areaName" value="${collectorNewGateway.areaName }" style="width:210px;" data-options="required:true" >
			    <input id="collectorNewGateway_edit_areaCode" name="areaCode" value="${collectorNewGateway.areaCode }" type="hidden">
			</td>
		</tr>
<%--		<tr style="height:40px;">--%>
<%--			<td style="width:120px;text-align:right;">养 殖 点：</td>--%>
<%--			<td>--%>
<%--				<input id="collectorNewGateway_edit_pointName" name="pointName" value="${collectorNewGateway.pointName }" readonly="readonly" style="width:210px;" >--%>
<%--			    <input id="collectorNewGateway_edit_pointCode" name="pointCode" value="${collectorNewGateway.pointCode }" type="hidden">--%>
<%--			</td>--%>
<%--		</tr>--%>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">池 &nbsp;塘：</td>
			<td>
				<input id="collectorNewGateway_edit_deptName" name="deptName" value="${collectorNewGateway.deptName }" style="width:210px;" >
				<input id="collectorNewGateway_edit_deptCode" name="deptCode" value="${collectorNewGateway.deptCode }" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">购买时间：</td>
			<td>
				<input id="collectorNewGateway_edit_buyDate" class="easyui-datebox" name="buyDate" value="${collectorNewGateway.buyDate }" style="width:210px;" data-options="required:true" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">生效时间：</td>
			<td>
				<input id="collectorNewGateway_edit_effectiveDate" class="easyui-datebox" name="effectiveDate" value="${collectorNewGateway.effectiveDate }"  style="width:210px;"  data-options="required:true" />
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">到期时间：</td>
			<td>
				<input id="collectorNewGateway_edit_expiringDate" class="easyui-datebox" name="expiringDate" value="${collectorNewGateway.expiringDate }"  style="width:210px;" data-options="required:true" />
			</td>
		</tr>	
		<tr style="height:40px;">
   			<td style="width:120px;text-align:right;">是否可用：</td>
   			<td>
   			    <select class="easyui-combobox" id="collectorNewGateway_edit_delete_flag" select_value="${collectorNewGateway.delete_flag }" name="delete_flag"  data-options="panelHeight:'auto',width:'210px'">
    				<option value="0">可用</option>
    				<option value="1">不可用</option>
   				</select>
   			</td>
   		</tr>
	</table>
</form>
<script type="text/javascript">

$(function() {
	$("#collectorNewGateway_edit_delete_flag").children("option[value='"+$('#collectorNewGateway_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');

	//选择区域对话框
	$('#collectorNewGateway_edit_areaName').textbox({
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
			showSelectAreaDialog($("#collectorNewGateway_edit_areaCode").val(),function(row){
				$("#collectorNewGateway_edit_areaName").textbox('setValue',row.text);
				$("#collectorNewGateway_edit_areaCode").val(row.id);
				$("#collectorNewGateway_edit_deptName").textbox('clear');
				$("#collectorNewGateway_edit_deptCode").val('');
			});
		}
	});

	//选择池塘对话框
	$('#collectorNewGateway_edit_deptName').textbox({
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
			var areaCode = $("#collectorNewGateway_edit_areaCode").val();
			if(!areaCode){
				$.messager.alert("温馨提示", "请先选择所在地区！");
				return;
			}
			showSelectPondDialog(areaCode,function(row){
				$("#collectorNewGateway_edit_deptName").textbox('setValue',row.name);
				$("#collectorNewGateway_edit_deptCode").val(row.code);
			});
		}
	});

	
});
</script>
</body>
</html>
