<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>渔业综合服务平台</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="区划选择对话框">
</head>
<body>
<div class="easyui-layout" style="width:100%;height:100%;">
    <!-- <div data-options="region:'north'" style="height:50px;">
    	<form id="area_dialog_search_form">
    		<input type="hidden" name="operation" value="query">
	    	<ul class="search-param-list">
	    		<li><span>名称：</span><input class="easyui-textbox" id="area_dialog_search_areaname" name="areaname"/></li>
	    		<li style="margin-left:10px;">
	    			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="search_load('area_dialog_list', 'area_dialog_search_form', 'treegrid')">查询</a>
	    		</li>
	    	</ul>
    	</form>
    </div> -->
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="area_dialog_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	// 省市区树
	$('#area_dialog_list').tree({
		onlyLeafCheck:true,
		checkbox: true,
		onLoadSuccess:function(node, data){	
			$(this).find('span.tree-checkbox').unbind().click(function(){
				return false;
			});
		},onSelect : function(node){
			if(!$(this).tree("isLeaf",node.target)){
				return false;
			}
				
			var cknodes = $(this).tree("getChecked");
			for(var i = 0 ; i < cknodes.length ; i++){
				$(this).tree("uncheck", cknodes[i].target);
			}
			//再选中改节点
			$(this).tree("check", node.target);
		}
	});
	
	loadTreeData();
});
function loadTreeData() {
	$.ajax({  
	    async: false, //【重要】：设置false不然出不来数据         
	    url: '<%=basePath%>area/select_area_tree', //方法所在页面和方法名  
	    dataType: "json",  
	    success: function (data) { //请求成功后处理函数
	        $('#area_dialog_list').tree("loadData", data);
	        if("${selectValue}"){
	        	var node = $('#area_dialog_list').tree('find', "${selectValue}");
		        $('#area_dialog_list').tree('select', node.target);  
		        
		        var parents = [];
		        getAllParents(node,parents)
		        for(var i = 0 ; i < parents.length ; i++){
		        	$('#area_dialog_list').tree("expand", parents[i].target);
				}
	        }
	        
	    }
	}); 
}

function getAllParents(node,parents){
	  var parent = $('#area_dialog_list').tree("getParent", node.target);
	  if(parent){
		  parents.push(parent);
		  getAllParents(parent,parents);
	  }
}
</script>
</body>
</html>
