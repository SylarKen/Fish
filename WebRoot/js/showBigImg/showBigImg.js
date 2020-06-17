/**
 * 首先引入JS
 * <script type="text/javascript" src="<%= basePath %>js/showBigImg/showBigImg.js"></script>
 * 核心：DOM单击事件调用此方法，单击事件DOM必须有属性bigSrc，表示大图的路径
 */
function showBigImage(src) {
	if(!$.trim(src)){
		alert("产品图片路径为空，无法查看大图！");
		return;
	}
	$("#bigimg").attr("src", src);
	$("<img/>").attr("src", src).load(function() {
		var windowW = $(window).width();
		var windowH = $(window).height();
		var realWidth = this.width;
		var realHeight = this.height;
		var imgWidth, imgHeight;
		var scale = 0.8;
		if (realHeight > windowH * scale) {
			imgHeight = windowH * scale;
			imgWidth = imgHeight / realHeight * realWidth;
			if (imgWidth > windowW * scale) {
				imgWidth = windowW * scale;
			}
		} else if (realWidth > windowW * scale) {
			imgWidth = windowW * scale;
			imgHeight = imgWidth / realWidth * realHeight;
		} else {
			imgWidth = realWidth;
			imgHeight = realHeight;
		}
		$("#bigimg").css("width", imgWidth);
		var w = (windowW - imgWidth) / 2;
		var h = (windowH - imgHeight) / 2;
		$("#innerdiv").css({
			"top" : h,
			"left" : w
		});
		$("#outerdiv").fadeIn("fast");
	});
	$("#outerdiv").click(function() {
		closeOuterDiv();
	});
}

function closeOuterDiv() {
	$("#outerdiv").fadeOut("fast");
}

//引入css样式
function includeLinkStyle(url) {
	var link = document.createElement("link");
	link.rel = "stylesheet";
	link.type = "text/css";
	link.href = url;
	document.getElementsByTagName("head")[0].appendChild(link);
}

//初始化
if($("#outerdiv").length==0){
	var outerdiv = '<div id="outerdiv">'  
		+ '<a class="close" onclick="closeOuterDiv()"></a>'
		+ '<div id="innerdiv" style="position:absolute;">'
		+ '<img id="bigimg" style="border:5px solid #fff;" src=""/>' 
		+ '</div></div>' ;
	$("body").append(outerdiv);
}
includeLinkStyle("./js/showBigImg/showBigImg.css");





