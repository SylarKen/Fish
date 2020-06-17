<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#video_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#video_edit_table tr{
	height:20px;
}
#video_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}

</style>
	<form id="video_edit_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="video_edit_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input class="easyui-textbox" id="video_edit_pondName" name="pondName" value="${ bean.pondName }" style="width:150px;"/>
					<input type="hidden" id="video_edit_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>是否可用：</td>
    			<td>
    			    <select class="easyui-combobox" name="delete_flag" select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'">
	    				<option value="0">可用</option>
	    				<option value="1">不可用</option>
    				</select>
    			</td>
			</tr>
			<tr>
				<td>视频地址：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="videosrc" value="${ bean.videosrc }" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>缩略图地址：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="snapimg" value="${ bean.snapimg }" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:400px;height:60px" />
				</td>
			</tr>
		</table>
	</form>
<script>

$(function(){
	$("#video_edit_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#video_edit_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#video_edit_pondCode").val(row.code);
				$("#video_edit_pondName").textbox("setValue", row.name);
			});			
		}
	});
	//所有select下拉的初始化
	$("#video_edit_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
	
});


</script>
</body>
</html>
