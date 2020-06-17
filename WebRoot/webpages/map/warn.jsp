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
		<div id="warn_dept_tree"></div>
	</div>
	<div data-options="region:'center'">
		<div id="warn_map" style="width:100%;height:100%"></div>
	</div>
</div>
<style type="text/css">
.overlay-icon-illustrate {width: 100px;float: left;margin-top: 5px;}
.overlay-icon-illustrate span {
	width: 27px;
	height: 12px;
	display: inline-block;
}
</style>
<script type="text/javascript" src="${basePath}js/bmap.js"></script>
<script type="text/javascript">
$(function() {
	var map = initBMap();//初始化地图
	initDetpTree();
	
	function initBMap() {
		// 百度地图API功能
		var map = new BMap.Map('warn_map');    // 创建Map实例
		map.centerAndZoom(new BMap.Point(116.59, 35.38), 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.setCurrentCity('济宁');          // 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		return map;
	}
	
	function initDetpTree() {
		$('#warn_dept_tree').tree({
			url: '${basePath}map/dept/tree',
			onClick: function(node) {
				/* console.log(JSON.stringify(node));
				console.log(node.children); */
				if (node.children == 0) {//如果是叶子结点
					var code = node.id;
					//ajaxData(code);
					centerPoint(map, '${basePath}map/dept/info', code);
				}
			}
		});
		//地图显示用户下辖养殖点
		$.post('${basePath}map/dept/list', {isWarn: true}, function(data) {
			addOverlays(map, data, 11, '123', 'warn');
		}, 'json');
	}

});
function openWarnInfoDialog(code) {
	var $dialog = $("<div id='warn_info_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}webpages/map/warnInfo.jsp?pointCode=' + code,
        title: '告警信息',
        width: 700,
        height: 600,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '关闭',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}
</script>
</body>
</html>