<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style type="text/css">
.reply_detail_bigImgWrapper {
	overflow: hidden;
}

#reply_detail_replyDiv {
	margin-top: 35px;
}

#reply_detail_replyDiv .replyDiv {
	margin: 8px;
	background-color: #E4E4E4;
	border-radius: 5px;
	overflow: hidden;
	position: relative;
}

#reply_detail_replyDiv .titleDiv {
	border-bottom: 1px solid #ABABAB;
	margin: 5px 8px;
	font-size: 13px;
	padding-top: 5px;
}

#reply_detail_replyDiv .descDiv {
	padding: 5px;
}

#reply_detail_replyDiv .alreadydelete {
	width: 200px;
	height: 100px;
	position: absolute;
	top: 0;
	left: 50px;
	background-image: url(<%= basePath %>image/alreadydelete.png);
}
</style>
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',split:true,title:'问题'"  >
			<div class="easyui-layout" data-options="fit:true,border:false" >
				<div data-options="region:'north',border:false" style="padding:10px;overflow:hidden">
					<div style="color:#3BAAE3;width:100%;text-align:center;font-weight:bold;font-size:16px;margin-bottom:3px;">${report.title}</div>
					<div style="width:100%;text-align:center;border-top:2px solid #ddd;padding-top:2px;">
						<input type="hidden" id="reply_detail_reportId" value="${report.id}"/>
						<input type="hidden" id="reply_detail_username" value="${user.username}"/>
						<span>上报时间：${report.reportTime}</span> 
						<span style="float:left;">上报人：${report.creator}</span> 
						<span style="float:right;margin-right:10px;">类型：${report.typeText}</span>
					</div>
				</div>
				<div data-options="region:'center',border:false" style="padding:10px;">
					<div class="reply_detail_bigImgWrapper" >${report.content}</div>
				</div>
			</div>
		</div>
		<div data-options="region:'east',split:true,title:'回复'" style="width:50%;">
			<div style="background:#D1DCDE;position:absolute;width:100%;z-index:100;">
				<a id="reply_detail_addBtn" href="javascript:reply_detail_add();" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="display:none;margin:5px 0px 5px 8px;">新增回复</a>
				<a id="reply_detail_editBtn" href="javascript:reply_detail_edit();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" style="display:none;margin:5px 0px 5px 8px;">编辑回复</a>
			</div>
			<div id="reply_detail_replyDiv" class="reply_detail_bigImgWrapper"></div>
		</div>
		</div>
	</div>
	<script type="text/javascript">
		var userBtnRights = null;// 表格按钮的权限
		$(function(){
			reply_detail_refresh();
			//图片点击显示大图
			$(".reply_detail_bigImgWrapper").delegate("img", "click", function(){
				showBigImage($(this).attr("src"));
			});
			//新增编辑按钮权限控制
			if(!userBtnRights){
				$.getJSON(webContext + 'system/getActionsByUser', {}, function(data) {
					userBtnRights = data?data:[];
					if(userBtnRights){
						for(var i=0,len=userBtnRights.length; i<len; i++){
							var menuUrl = userBtnRights[i].menuUrl;
							if(menuUrl == "reply/add"){
								$("#reply_detail_addBtn").show();
							}else if(menuUrl == "reply/edit"){
								$("#reply_detail_editBtn").show();
							}
						}
					}
				});
			}
		});
		
		function reply_detail_refresh(){
			$.post(webContext + "reply/getReplys", { reportId : $("#reply_detail_reportId").val() }, function(data){
				$("#reply_detail_replyDiv").empty();
				if(data && data.ok){
					var replyArr = data.replyArr;
					var username = $("#reply_detail_username").val();
					for(var i=0; i<replyArr.length; i++){
						var r = replyArr[i];
						var divHtml = '<div class="replyDiv"><div class="titleDiv">'
						+ ((username == r.creator)?'<input type="radio" name="replyRatio" value="'+ r.id +'">&nbsp;':'')
						+ "<span style='width:80px;margin-right:10px;font-weight:bold;'>" + r.creator + "</span>" + timeFormatter(r.createTime) 
						+ '</div><div class="descDiv">'+ r.content +'</div>'
						+ (r.delete_flag == 1?'<div class="alreadydelete"></div>':'')
						+ '</div>';
						$("#reply_detail_replyDiv").append(divHtml);
					}
				}else{
					$("#reply_detail_replyDiv").append("<div style='padding:10px;text-align:center;'>暂无回复</div>");
				}
			},"json");
			
		}
		
		function reply_detail_add() {
			tabManager('回复新增', webContext + "reply/add?reportId=${report.id}");
		}
		
		function reply_detail_edit(){
			var $replyRatio = $("#reply_detail_replyDiv input[name='replyRatio']:checked");
			if($replyRatio.length == 0){
				$.messager.alert("温馨提示", "请先选中一条回复记录");
				return;
			}
			tabManager('回复编辑', webContext + "reply/edit?id=" + $replyRatio.val());
		}
		//取消关闭
		function reply_detail_close() {
			$("#main_center_tabs").tabs('close', "问题查看");//关闭
		}
	</script>
	<script type="text/javascript" src="<%= basePath %>js/showBigImg/showBigImg.js"></script>
</body>
</html>