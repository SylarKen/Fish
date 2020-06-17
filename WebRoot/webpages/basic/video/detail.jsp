<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#video_detail_table{
	margin-top:10px;
	margin-left:10px;
}
#video_detail_table tr{
	height:20px;
}
#video_detail_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}

</style>
	<form id="video_detail_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="video_detail_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input disabled class="easyui-textbox" id="video_detail_pondName" name="pondName" value="${ bean.pondName }" style="width:150px;"/>
					<input type="hidden" id="video_detail_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>是否可用：</td>
    			<td>
    			    <select disabled class="easyui-combobox" name="delete_flag" select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'">
	    				<option value="0">可用</option>
	    				<option value="1">不可用</option>
    				</select>
    			</td>
			</tr>
			<tr>
				<td>视频地址：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="videosrc" value="${ bean.videosrc }" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>缩略图地址：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="snapimg" value="${ bean.snapimg }" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:400px;height:60px" />
				</td>
			</tr>
		</table>
	</form>
<script>

$(function(){
	//所有select下拉的初始化
	$("#video_detail_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
	
});


</script>
</body>
</html>
