<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<style>
#report_edit_form {
	margin:0;
	padding:0;
}
#report_edit_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<form id="report_edit_form">
	<input type="hidden" name="id" value="${ bean.id }"/>
	<div data-options="region:'north',border:false" style="height:50px;padding:10px;overflow:hidden">
		<span class="condition" > 
			<label>标题：</label> 
			<input class="easyui-textbox" name="title" value="${ bean.title }" data-options="required:true" style="width:400px"/>
		</span>
		<span class="condition" > 
			<label>类型：</label> 
			<select class="easyui-combobox" name="type" select_value="${ bean.type }" style="width:120px;" data-options="panelHeight:'auto',editable:false">
				<option value="0">其他</option>
				<option value="1">鱼苗</option>
				<option value="2">喂养</option>
				<option value="3">用药</option>
				<option value="4">捕捞</option>
			</select>
		</span>
	</div>
	<div data-options="region:'center',border:false,title:'具体内容'" style="padding:10px;overflow:hidden">
		<!-- 加载编辑器的容器 -->
		<script id="report_edit_content" name="content" type="text/plain">${ bean.content }</script>
		<!-- 实例化编辑器 -->
		<script type="text/javascript">
			if(report_edit_ue){
				UE.getEditor('report_edit_content').destroy();
			}
			var report_edit_ue = UE.getEditor('report_edit_content', 
				{ 
					initialFrameHeight: ($(window).height() - 320),
					autoFloatEnabled: true, 
					autoHeightEnabled: false
				}
			);
			//所有select下拉的初始化
			$("#report_edit_form select").each(function(i){
				$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
			});
			//保存
			function report_edit_save(){
				if ($("#report_edit_form").form('validate')) {
					$("#report_edit_save_btn").linkbutton('disable');
					$.post( webContext + "report/editSave", getFormJson("report_edit_form"), 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#report_edit_save_btn").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								report_edit_close();
								report_search();//刷新
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请正确填写红色背景高亮的字段！");
				}
			}
			//取消关闭
			function report_edit_close(){
				$("#main_center_tabs").tabs('close', "问题编辑");//关闭
			}
		</script>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;overflow:hidden;">
		<div style="margin:8px;float:right;">
			<a id="report_edit_save_btn" href="#" class="easyui-linkbutton" onclick="report_edit_save()" data-options="iconCls:'icon-save'">保存</a> 
			<a id="report_edit_close_btn" href="#" class="easyui-linkbutton" onclick="report_edit_close()" data-options="iconCls:'icon-cross'">关闭</a>
		</div>
	</div>
	</form>
</div>
</body>
</html>