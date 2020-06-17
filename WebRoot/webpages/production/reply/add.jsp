<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<style>
#reply_add_form {
	margin:0;
	padding:0;
}
#reply_add_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<form id="reply_add_form">
	<input type="hidden" name="reportId" value="${ reportId }"/>
	<div data-options="region:'center',border:false" style="padding:10px;overflow:hidden">
		<!-- 加载编辑器的容器 -->
		<script id="reply_add_content" name="content" type="text/plain"></script>
		<!-- 实例化编辑器 -->
		<script type="text/javascript">
			if(reply_add_ue){
				UE.getEditor('reply_add_content').destroy();
			}
			var reply_add_ue = UE.getEditor('reply_add_content', 
				{ 
					initialFrameHeight: ($(window).height() - 245),
					autoFloatEnabled: true, 
					autoHeightEnabled: false
				}
			);
			//保存
			function reply_add_save(){
				if ($("#reply_add_form").form('validate')) {
					$("#reply_add_save_btn").linkbutton('disable');
					$.post( webContext + "reply/addSave", getFormJson("reply_add_form"), 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#reply_add_save_btn").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								var $replyDiv = $("#reply_detail_replyDiv");
								if($replyDiv.length == 1){
									reply_detail_refresh();
								}
								if($("#reply_datagrid").length > 0){
									search_load('reply_datagrid', 'reply_search_form');
								}
								reply_add_close();
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请正确填写红色背景高亮的字段！");
				}
			}
			//取消关闭
			function reply_add_close(){
				$("#main_center_tabs").tabs('close', "回复新增");//关闭
			}
		</script>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;overflow:hidden;">
		<div style="margin:8px;float:right;">
			<a id="reply_add_save_btn" href="#" class="easyui-linkbutton" onclick="reply_add_save()" data-options="iconCls:'icon-save'">保存</a> 
			<a id="reply_add_close_btn" href="#" class="easyui-linkbutton" onclick="reply_add_close()" data-options="iconCls:'icon-cross'">关闭</a>
		</div>
	</div>
	</form>
</div>
</body>
</html>