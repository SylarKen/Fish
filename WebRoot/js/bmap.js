/**
 * 百度地图常用方法封装
 */

/**
 * 添加覆盖物
 * @param map Map实例
 * @param lng 经度
 * @param lat 纬度
 * @param clean 是否清除之前的覆盖物，默认不请除
 */
function addOverlay(map, lng, lat, clean) {
	if (clean) {
		map.clearOverlays();
	}
	var point = new BMap.Point(lng, lat);    
	map.centerAndZoom(point, 15);
	map.enableScrollWheelZoom(true);//开启鼠标滚轮缩放
	var marker = new BMap.Marker(point);// 创建标注    
	map.addOverlay(marker);// 将标注添加到地图中
	return marker;
}

/**
 * 一次性添加多个覆盖物
 * @param map 地图对象
 * @param list 数据
 * @param zoom 地图缩放级别，默认为11
 * @param contentUrl 获取信息窗体内容所需要的url
 * @param type 类型：目前支持distribution和warn
 */
function addOverlays(map, list, zoom, contentUrl, type) {
	if (typeof(zoom) == 'undefined') {
		zoom = 11;
	}
	map.enableScrollWheelZoom(true);//开启鼠标滚轮缩放
	for (var i = 0; i < list.length; i++) {
		var d = list[i];
		var point = new BMap.Point(d.lng, d.lat);
		var data;
		if (contentUrl && d.code) {
			data = {url: contentUrl, code: d.code};
		}
		if (i == 0) {
			map.centerAndZoom(point, zoom, data);
		}
		var icon = d.icon;
		addMarker(map, point, data, type, icon);
	}
}

/**
 * 添加标识
 * @param map 地图对象
 * @param point 标识对应的地图上的点
 * @param data 包含url和code的对象
 * @param type 类型：目前支持distribution和warn
 * @param icon 自定义图标
 */
function addMarker(map, point, data, type, icon) {
	var marker;
	if (icon) {
		var iconUrl = webContext + icon;
		var myIcon = new BMap.Icon(iconUrl, new BMap.Size(26, 23), {});
		marker = new BMap.Marker(point, {icon: myIcon});
		addCopyRight(map);
	} else {
		marker = new BMap.Marker(point);
	}
	map.addOverlay(marker);
	if (data) {
		addClickHandler(map, marker, data.url, data.code, type);
	}
}

/**
 * 给标识点添加单击事件
 * @param map 地图对象
 * @param marker 标识
 * @param url 获取信息窗口内容的url
 * @param code 获取信息窗口内容需要的code
 * @param type 类型：目前支持distribution和warn
 */
function addClickHandler(map, marker, url, code, type) {
	marker.addEventListener("click", function(e){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		if (type == 'distribution') {
			$.post(url, {code: code}, function(data) {
				var infoWindow = new BMap.InfoWindow(data.content);
				map.openInfoWindow(infoWindow, point);
			}, 'json');
		} else if (type == 'warn') {
			openWarnInfoDialog(code);
		}
	});
}

/**
 * 设置地图中心点，地图默认绽放级别为15
 * @param map 地图对象
 * @param url 获取标识点信息所需要的url
 * @param code 获取标识点信息所需要的code
 */
function centerPoint(map, url, code) {
	$.post(url, {code: code}, function(data) {
		var point = new BMap.Point(data.lng, data.lat);    
		map.centerAndZoom(point, 15);
	}, 'json');
}

/**
 * 打开信息窗口
 * @param marker 标注
 * @param sContent 信息窗口需要显示的内容
 */
function openInfoWindow(marker, sContent) {
	var infoWindow = new BMap.InfoWindow(sContent);
	marker.addEventListener("click", function(){
		this.openInfoWindow(infoWindow);
	});
}

/**
 * 添加自定义版权控件（覆盖物图标颜色说明信息）
 */
function addCopyRight(map) {
	//var cr = new BMap.CopyrightControl({anchor: BMAP_ANCHOR_TOP_RIGHT,offset: new BMap.Size(160, 5)});//设置版权控件位置
	var cr = new BMap.CopyrightControl({anchor: BMAP_ANCHOR_TOP_LEFT});
	map.addControl(cr);//添加版权控件
	var bs = map.getBounds();//返回地图可视区域
	var content = "<div class='overlay-icon-illustrate'>";
	content += "<div><span style='background-color:green'></span>&nbsp;&nbsp;正常运行</div>";
	content += "<div><span style='background-color:blue'></span>&nbsp;&nbsp;蓝色告警</div>";
	content += "<div><span style='background-color:orange'></span>&nbsp;&nbsp;橙色告警</div>";
	content += "<div><span style='background-color:yellow'></span>&nbsp;&nbsp;黄色告警</div>";
	content += "<div><span style='background-color:red'></span>&nbsp;&nbsp;红色告警</div>";
	content += "</div>";
	cr.addCopyright({id: 1, content: content, bounds: bs});
}
