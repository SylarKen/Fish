<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
<title>渔业综合服务平台</title>
<jsp:include page="./common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/login.css" />
<script>
	var webContext = "<%=basePath%>";
	window.onload = function() {
		var showPwd = $("#showPwd"), pwd = $("#pwd");  
		showPwd.focus(function(){  
		   pwd.show().focus();  
		   showPwd.hide();  
		});  
		pwd.blur(function(){  
		   if(pwd.val()=="") {  
		       showPwd.show();  
		       pwd.hide();  
		    }  
		}); 
	};
	
	//回车提交表单
	document.onkeydown = function(evt){
	   var evt = window.event ? window.event : evt;
	   if (evt.keyCode==13) {
	    	loginSystem();
	   }
	};
	
	//登录
	function loginSystem(){
		//校验
		var key1 = $("#usernameId").val();
		var key2 = $("#pwd").val();
		
		if(!key1 || key1=="请输入用户名"){
			$.messager.alert("温馨提示","请输入用户名!");
			return;
		}
		if(!key2 || key2=="请输入密码"){
			$.messager.alert("温馨提示","密码不能为空!");
			return;
		}
		$.post(webContext + "system/login", {key1:key1, key2:key2}, function(d){
			if(d.ok){                          
				window.location.href = webContext;
			} else{                                 
				$.messager.alert("温馨提示",d.msg);
			}
		}, "json");
	}
</script>
</head>

<body>
	<div class="regist_header clearfix">
		<div class="wrap headtitle">渔业综合服务平台</div>
	</div>
	<input id="isAutoLogin" value="0" type="hidden" />
	<input id="autoLoginFlag" value="1" type="hidden" />
	<div class="login_wrap">
		<div class="wrap clearfix">
			<div class="mod_login_wrap login_entry_css">
				<div class="clearfix">
					<div>
						<h3>用户登录</h3>
					</div>
				</div>
				<div class="login_form">
					<i class="arraow">&nbsp;</i>
					<div class="form_item_wrap">
						<div class="form_item">
							<label class="user_ico">&nbsp;</label>
							<input id="usernameId" type="text" name="key1" class="ipt ipt_username gay_text" value="请输入用户名"
								onfocus="if(this.value=='请输入用户名') this.value=''" onblur="if(!this.value) this.value='请输入用户名'" />
						</div>
						<div class="form_item">
							<label class="paswd_ico">&nbsp;</label>
							<input type='password' style="display:none;" />
							<input id="pwd" type="password" name="key2" class="ipt ipt_password gay_text" style="display:none;" />
							<input id="showPwd" type="text" value="请输入密码" class="ipt ipt_password gay_text"/>
						</div>
						<br />
						<button id="login_button" type="button" onclick="loginSystem()" class="login_btn">登录</button>
						<div style=" margin:8px 3px; height:20px; font-size:14px">        
					        <%-- <a style="color:#757575;font-family:'microsoft yahei';float:left" href="<%=basePath%>register.jsp">注册新账号</a> --%>
					        <!-- <a style="color:#757575;font-family:'microsoft yahei';float:right" href="javascript:void(0);">忘记密码?</a> -->
					    </div>
					</div>
				</div>
			</div>
			<div class="mod_left_banner">
				<a id="imgLink" target="_blank">
					<img id="img" src="<%=basePath%>image/loginmain.jpg" height="300" width="400" />
				</a>
			</div>
		</div>
	</div>

	<div id="simplefooter">
		<a href="javascript:void(0);" target="_blank">山东一脉物联网科技有限公司</a> |
		<a href="http://www.domor.net/" target="_blank">山东动脉智能科技股份有限公司</a>
		<p>Copyright © 济宁市任城区 2016，All Rights Reserved</p>
	</div>
</body>
</html>