<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#pond_tree_dialog_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#pond_tree_dialog_search_form .conditionSpan input,select {
	width:100px;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<div data-options="region:'north',border:false">
		<form id="pond_tree_dialog_search_form" style="margin:0 5px;">
		<div>
			<span class="conditionSpan">
				<span>池塘名称：</span>
				<input class="easyui-textbox" name="pondName" />
			</span>
			<span class="conditionSpan">
				<a class="easyui-linkbutton" onclick="pond_tree_dialog_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
			</span>
		</div>
		</form>	
	</div>
	<div data-options="region:'center',border:false" style="width:100%;">
		<table id="pond_tree_dialog_tree"></table>
	</div>
</div>
<script>
var selecting = false;
$(function(){
	var isSingleCheck = "${isSingleCheck}" == "1" ? true:false;
	var deptCode = '${deptCode}';
	var url = deptCode?(webContext + "production/getUserPondTree?deptCode="+deptCode):(webContext + "production/getUserPondTree");
	$('#pond_tree_dialog_tree').treegrid({
		url : url,
		checkbox : true,
		fit : true,
		nowrap : true,
		collapsible : true,
		pagination : false,
		autoRowHeight : false,
		singleSelect: isSingleCheck,
		selectOnCheck : true,
		checkOnSelect : true,
		idField : "code",
		treeField : "name",
		columns : [ [ 
			{ field: 'ck', checkbox: true },
			{field : 'code',title : '编码',width : 80},
			{field : 'name',title : '名称',width : 170
		} ] ],
		onSelect : function(node) {
			if(!selecting){
				selecting = true;
				var children = $('#pond_tree_dialog_tree').treegrid("getChildren", node.code);
				for(var i=0; i<children.length; i++){
					$('#pond_tree_dialog_tree').treegrid("select", children[i].code);
				}
				selecting = false;
			}
			
		},
		onUnselect : function(node){
			if(!selecting){
				selecting = true;
				var children = $('#pond_tree_dialog_tree').treegrid("getChildren", node.code);
				for(var i=0; i<children.length; i++){
					$('#pond_tree_dialog_tree').treegrid("unselect", children[i].code);
				}
				selecting = false;
			}
		},
		onLoadSuccess : function(row, data) {
			var checkedPonds = $.trim('${checkedPonds}');
	    	if(!checkedPonds || !data || data.length == 0){
	    		return;
	    	}
	    	var checkedPondsArr = checkedPonds.split(",");
	    	for(var i=0; i<checkedPondsArr.length; i++){
	    		var pondCode = checkedPondsArr[i];
	    		$('#pond_tree_dialog_tree').treegrid("select", pondCode);
	    	}
		}
	});
});

//搜索
function pond_tree_dialog_search(){
	$('#pond_tree_dialog_tree').treegrid("load", getFormJson("pond_tree_dialog_search_form"));
}

	
</script>


</body>
</html>