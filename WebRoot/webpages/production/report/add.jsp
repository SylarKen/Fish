<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<style>
#report_add_form {
	margin:0;
	padding:0;
}
#report_add_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<form id="report_add_form">
	<div data-options="region:'north',border:false" style="height:50px;padding:10px;overflow:hidden">
		<span class="condition" > 
			<label>标题：</label> 
			<input class="easyui-textbox" name="title" data-options="required:true" style="width:400px"/>
		</span>
		<span class="condition" > 
			<label>类型：</label> 
			<select class="easyui-combobox" name="type" style="width:120px;" data-options="panelHeight:'auto',editable:false">
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
		<script id="report_add_content" name="content" type="text/plain"></script>
		<!-- 实例化编辑器 -->
		<script type="text/javascript">
			if(report_add_ue){
				UE.getEditor('report_add_content').destroy();
			}
			var report_add_ue = UE.getEditor('report_add_content', 
				{ 
					initialFrameHeight: ($(window).height() - 320),
					autoFloatEnabled: true, 
					autoHeightEnabled: false
				}
			);
			//保存
			function report_add_save(){
				if ($("#report_add_form").form('validate')) {
					$("#report_add_save_btn").linkbutton('disable');
					$.post( webContext + "report/addSave", getFormJson("report_add_form"), 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#report_add_save_btn").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								report_add_close();
								report_search();//刷新
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请正确填写红色背景高亮的字段！");
				}
			}
			//取消关闭
			function report_add_close(){
				$("#main_center_tabs").tabs('close', "问题新增");//关闭
			}
		</script>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;overflow:hidden;">
		<div style="margin:8px;float:right;">
			<a id="report_add_save_btn" href="#" class="easyui-linkbutton" onclick="report_add_save()" data-options="iconCls:'icon-save'">保存</a> 
			<a id="report_add_close_btn" href="#" class="easyui-linkbutton" onclick="report_add_close()" data-options="iconCls:'icon-cross'">关闭</a>
		</div>
	</div>
	</form>
</div>
</body>
</html>