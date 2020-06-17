<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style type="text/css">
.report_detail_bigImgWrapper {
	overflow: hidden;
}

#report_detail_reportDiv {
	margin-top: 10px;
}

#report_detail_reportDiv .reportDiv {
	margin: 8px;
	background-color: #E4E4E4;
	border-radius: 5px;
	overflow: hidden;
	position: relative;
}

#report_detail_reportDiv .titleDiv {
	border-bottom: 1px solid #ABABAB;
	margin: 5px 8px;
	font-size: 13px;
	padding-top: 5px;
}

#report_detail_reportDiv .descDiv {
	padding: 5px;
}
</style>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,title:'问题'"  style="width:50%;">
		<div class="easyui-layout" data-options="fit:true,border:false" >
			<div data-options="region:'north',border:false" style="padding:10px;overflow:hidden">
				<div style="color:#3BAAE3;width:100%;text-align:center;font-weight:bold;font-size:16px;margin-bottom:3px;">${bean.title}</div>
				<div style="width:100%;text-align:center;border-top:2px solid #ddd;padding-top:2px;">
					<input type="hidden" id="report_detail_reportId" value="${bean.id}"/>
					<span>上报时间：${bean.reportTime}</span> 
					<span style="float:left;">上报人：${bean.creator}</span> 
					<span style="float:right;margin-right:10px;">类型：${bean.typeText}</span>
				</div>
			</div>
			<div data-options="region:'center',border:false" style="padding:10px;">
				<div class="report_detail_bigImgWrapper">${bean.content}</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center',split:true,title:'回复'">
		<div id="report_detail_reportDiv" class="report_detail_bigImgWrapper"></div>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		report_detail_refresh();
		//图片点击显示大图
		$(".report_detail_bigImgWrapper").delegate("img", "click", function(){
			showBigImage($(this).attr("src"));
		});
	});
	//取消关闭
	function report_detail_close() {
		$("#main_center_tabs").tabs('close', "问题查看");//关闭
	}
	function report_detail_refresh(){
		$.post(webContext + "report/getReplys", { reportId : $("#report_detail_reportId").val() }, function(data){
			$("#report_detail_reportDiv").empty();
			if(data && data.ok){
				var replyArr = data.replyArr;
				for(var i=0; i<replyArr.length; i++){
					var r = replyArr[i];
					var divHtml = '<div class="reportDiv"><div class="titleDiv">'
					+ "<span style='width:80px;margin-right:10px;font-weight:bold;'>" + r.creator + "</span>" + timeFormatter(r.createTime) 
					+ '</div><div class="descDiv">'+ r.content +'</div></div>';
					$("#report_detail_reportDiv").append(divHtml);
				}
			}else{
				$("#report_detail_reportDiv").append("<div style='padding:10px;text-align:center;'>暂无回复</div>");
			}
		},"json");
		
	}
</script>
<script type="text/javascript" src="<%= basePath %>js/showBigImg/showBigImg.js"></script>
</body>
</html>