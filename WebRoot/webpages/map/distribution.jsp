<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>人员分布</title>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,title:'养殖点列表'" style="width:200px;">
		<div id="distribution_dept_tree"></div>
	</div>
	<div data-options="region:'center'">
		<div id="distribution_map" style="width:100%;height:100%"></div>
	</div>
</div>
<script type="text/javascript" src="${basePath}js/bmap.js"></script>
<script type="text/javascript">
$(function() {
	var map = initBMap();//初始化地图
	initDetpTree();
	
	function initBMap() {
		// 百度地图API功能
		var map = new BMap.Map('distribution_map');    // 创建Map实例
		map.centerAndZoom(new BMap.Point(116.59, 35.38), 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.setCurrentCity('济宁');          // 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		return map;
	}
	
	function initDetpTree() {
		//初始化左侧养殖点树
		$('#distribution_dept_tree').tree({
			url: '${basePath}map/dept/tree',
			onClick: function(node) {
				console.log(JSON.stringify(node));
				console.log(node.children);
				if (node.children == 0) {//如果是叶子结点
					var code = node.id;
					//单击时地图移动到该点
					centerPoint(map, '${basePath}map/dept/info', code);
				}
			}
		});
		//地图显示用户下辖养殖点
		$.post('${basePath}map/dept/list', {}, function(data) {
			addOverlays(map, data, 11, '${basePath}map/dept/winContent', 'distribution');
		}, 'json');
	}

});
</script>
</body>
</html>