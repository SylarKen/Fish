<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#drug_detail_table{
	margin-top:10px;
	margin-left:10px;
}
#drug_detail_table tr{
	height:20px;
}
#drug_detail_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#drug_detail_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="drug_detail_form">
		<input disabled type="hidden" name="id" value="${ bean.id }"/>
		<table id="drug_detail_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input disabled class="easyui-textbox" id="drug_detail_pondName" name="pondName" value="${ bean.pondName }"/>
					<input disabled type="hidden" id="drug_detail_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>发病时间：</td>
				<td>
					<input disabled class="easyui-datetimebox" name="faBingTime" value="${ bean.faBingTime }" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>发病品种：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="faBingBreed" value="${ bean.faBingBreed }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>诊断结果：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="zhenDuanResult" value="${ bean.zhenDuanResult }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>处方人：</td>
				<td>
					<input disabled class="easyui-textbox" name="chuFangRen" value="${ bean.chuFangRen }" />
				</td>
				<td>药品：</td>
				<td>
					<input disabled class="easyui-textbox" id="drug_detail_medicineName" name="medicineName" value="${ bean.medicineName }"/>
					<input disabled type="hidden" id="drug_detail_medicineId" name="medicineId" value="${ bean.medicineId }"/>
				</td>
			</tr>
			<tr>
				<td>生产厂家：</td>
				<td>
					<input disabled class="easyui-textbox" name="shengChanChangJia" value="${ bean.shengChanChangJia }"/>
				</td>
				<td>批号：</td>
				<td>
					<input disabled class="easyui-textbox" name="piHao" value="${ bean.piHao }"/>
				</td>
			</tr>
			<tr>
				<td>用药量：</td>
				<td>
					<input disabled class="easyui-textbox" name="yongYaoLiang" value="${ bean.yongYaoLiang }"/>
				</td>
				<td>用药浓度：</td>
				<td>
					<input disabled class="easyui-textbox" name="yongYaoNongDu" value="${ bean.yongYaoNongDu }"/>
				</td>
			</tr>
			<tr>
				<td>施药时间：</td>
				<td>
					<input disabled class="easyui-datetimebox" name="shiYaoTime" value="${ bean.shiYaoTime }" data-options="editable:false" />
				</td>
				<td>施药人：</td>
				<td>
					<input disabled class="easyui-textbox" name="shiYaoRen" value="${ bean.shiYaoRen }"/>
				</td>
			</tr>
			<tr>
				<td>用药理由：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="yongYaoLiYou" value="${ bean.yongYaoLiYou }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>用药效果：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="yongYaoXiaoGuo" value="${ bean.yongYaoXiaoGuo }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>休药期：</td>
				<td>
					<input disabled class="easyui-textbox" name="xiuYaoQi" value="${ bean.xiuYaoQi }"/>
				</td>
				<td>光照强度：</td>
				<td>
					<input disabled class="easyui-textbox" name="guangZhaoQiangDu" value="${ bean.guangZhaoQiangDu }" />
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
	$("#drug_detail_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
});
</script>
</body>
</html>
