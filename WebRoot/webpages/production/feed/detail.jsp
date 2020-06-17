<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#feed_detail_table{
	margin-top:10px;
	margin-left:10px;
}
#feed_detail_table tr{
	height:20px;
}
#feed_detail_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#feed_detail_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="feed_detail_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="feed_detail_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input disabled class="easyui-textbox" id="feed_detail_pondName" name="pondName" value="${ bean.pondName }"/>
					<input type="hidden" id="feed_detail_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>饵料：</td>
				<td>
					<input disabled class="easyui-textbox" id="feed_detail_foodName" name="foodName" value="${ bean.foodName }"/>
					<input type="hidden" id="feed_detail_foodId" name="foodId" value="${ bean.foodId }"/>
				</td>
			</tr>
			<tr>
				<td>生产厂家：</td>
				<td>
					<input disabled class="easyui-textbox" name="foodFactory" value="${ bean.foodFactory }"/>
				</td>
				<td>批号/生产日期：</td>
				<td>
					<input disabled class="easyui-textbox" name="foodPihao" value="${ bean.foodPihao }"/>
				</td>
			</tr>
			<tr>
				<td>投饲量：</td>
				<td>
					<input disabled class="easyui-textbox" name="feedAmount" value="${ bean.feedAmount }"/>
				</td>
				<td>投饲时间：</td>
				<td>
					<input disabled class="easyui-datetimebox" name="feedTime" value="${ bean.feedTime }" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>摄食情况：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="sheShiQingKuang" value="${ bean.sheShiQingKuang }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>养殖密度：</td>
				<td>
					<input disabled class="easyui-textbox" name="yangZhiMiDu" value="${ bean.yangZhiMiDu }"/>
				</td>
				<td>光照情况：</td>
				<td>
					<input disabled class="easyui-textbox" name="guangZhaoQiangDu" value="${ bean.guangZhaoQiangDu }"/>
				</td>
			</tr>
			<tr>
				<td>水质：</td>
				<td>
					<input disabled class="easyui-textbox" name="shuiZhi" value="${ bean.shuiZhi }"/>
				</td>
				<td>水温：</td>
				<td>
					<input disabled class="easyui-textbox" name="shuiWen" value="${ bean.shuiWen }"/>
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>是否可用：</td>
    			<td>
    			    <select disabled class="easyui-combobox" name="delete_flag"  select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'">
	    				<option value="0">可用</option>
	    				<option value="1">不可用</option>
    				</select>
    			</td>
			</tr>
		</table>
	</form>
<script>
$(function(){
	//所有select下拉的初始化
	$("#feed_detail_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
});
</script>
</body>
</html>
