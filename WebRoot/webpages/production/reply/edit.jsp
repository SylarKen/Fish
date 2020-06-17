<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<style>
#reply_edit_form {
	margin:0;
	padding:0;
}
#reply_edit_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<form id="reply_edit_form">
	<input type="hidden" id="reply_edit_id" name="id" value="${ bean.id }"/>
	<input type="hidden" name="reportId" value="${ bean.reportId }"/>
	<div data-options="region:'center',border:false" style="padding:10px;overflow:hidden">
		<!-- 加载编辑器的容器 -->
		<script id="reply_edit_content" name="content" type="text/plain">${ bean.content }</script>
		<!-- 实例化编辑器 -->
		<script type="text/javascript">
			if(reply_edit_ue){
				UE.getEditor('reply_edit_content').destroy();
			}
			var reply_edit_ue = UE.getEditor('reply_edit_content', 
				{ 
					initialFrameHeight: ($(window).height() - 245),
					autoFloatEnabled: true, 
					autoHeightEnabled: false
				}
			);
			//保存
			function reply_edit_save(){
				if ($("#reply_edit_form").form('validate')) {
					$("#reply_edit_save_btn").linkbutton('disable');
					$.post( webContext + "reply/editSave", getFormJson("reply_edit_form"), 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#reply_edit_save_btn").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								var $replyDiv = $("#reply_detail_replyDiv");
								if($replyDiv.length == 1){
									reply_detail_refresh();
								}
								if($("#reply_datagrid").length > 0){
									search_load('reply_datagrid', 'reply_search_form');
								}
								reply_edit_close();
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请正确填写红色背景高亮的字段！");
				}
			}
			//取消关闭
			function reply_edit_close(){
				$("#main_center_tabs").tabs('close', "回复编辑");//关闭
			}
			//所有select下拉的初始化
			$("#reply_edit_form select").each(function(i){
				$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
			});
		</script>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;overflow:hidden;">
		<div style="margin:8px;float:right;">
			是否可用：
			<select class="easyui-combobox" name="delete_flag"  select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'" style="width:80px;">
  				<option value="0">可用</option>
  				<option value="1">不可用</option>
			</select>
			<a id="reply_edit_save_btn" href="#" class="easyui-linkbutton" onclick="reply_edit_save()" data-options="iconCls:'icon-save'">保存</a> 
			<a id="reply_edit_close_btn" href="#" class="easyui-linkbutton" onclick="reply_edit_close()" data-options="iconCls:'icon-cross'">关闭</a>
		</div>
	</div>
	</form>
</div>
</body>
</html>