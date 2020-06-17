<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<!-- 通过全局jsp 引用项目中通用的js 和  css插件 -->
		<jsp:include page="/common.jsp"></jsp:include>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/logino.css">
		<SCRIPT type="text/javascript">
			$(function(){
				//得到焦点
				$("#password").focus(function(){
					$("#left_hand").animate({
						left: "150",
						top: " -38"
					},{step: function(){
						if(parseInt($("#left_hand").css("left"))>140){
							$("#left_hand").attr("class","left_hand");
						}
					}}, 2000);
					$("#right_hand").animate({
						right: "-64",
						top: "-38px"
					},{step: function(){
						if(parseInt($("#right_hand").css("right"))> -70){
							$("#right_hand").attr("class","right_hand");
						}
					}}, 2000);
				});
				//失去焦点
				$("#password").blur(function(){
					$("#left_hand").attr("class","initial_left_hand");
					$("#left_hand").attr("style","left:100px;top:-12px;");
					$("#right_hand").attr("class","initial_right_hand");
					$("#right_hand").attr("style","right:-112px;top:-12px");
				});
			});
			
			function doSubmit() {
				document.loginForm.submit();
			}
			//回车提交表单：只要是在登陆页面点击回车按钮就提交表单
			document.onkeydown = function(evt){
			    var evt = window.event ? window.event:evt;
			    if (evt.keyCode==13) {
			    	document.loginForm.submit();
			    }
			}
		</SCRIPT>
	</head>

	<body id="body">
		<DIV class="top_div"></DIV>
		<DIV style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
			<DIV style="width: 165px; height: 96px; position: absolute;">
				<DIV class="tou"></DIV>
				<DIV class="initial_left_hand" id="left_hand"></DIV>
				<DIV class="initial_right_hand" id="right_hand"></DIV>
			</DIV>
			<form name="loginForm" action="<%=basePath%>system/login">
			<P style="padding: 30px 0px 10px; position: relative;">
				<SPAN class="u_logo"></SPAN>
				<INPUT class="ipt" type="text" name="key1" placeholder="请输入用户名或邮箱" value="">
			</P>
			<P style="position: relative;">
				<SPAN class="p_logo"></SPAN>
				<INPUT class="ipt" id="password" type="password"  name="key2" placeholder="请输入密码" value="">
			</P>
			<DIV style="height: 50px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
				<P style="margin: 0px 35px 20px 45px;">
					<SPAN style="float: left;">
						<A style="color: rgb(204, 204, 204);" href="#">忘记密码?</A> 
					</SPAN>
					<SPAN style="float: right;"><A style="color: rgb(204, 204, 204); margin-right: 10px;" href="#">注册</A>
						<A id="loginLink" style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;" href="javascript:doSubmit();">登录</A>
					</SPAN>
				</P>
			</DIV>
			</form>
		</DIV>
		<!--  
		<body class="lock">
			<div class="lock-header">

				<a class="center" id="logo" href="index.html"> <img
						class="center" alt="logo" src="logo.png"> </a>

			</div>
			<div class="login-wrap">
				<div class="metro single-size red">
					<div class="locked">
						<i class="icon-lock"></i>
						<span>登录</span>
					</div>
				</div>
				<form action="<%=basePath%>system/login">
					<div class="metro double-size green">
						<div class="input-append lock-input">
							<input id='j_user' name=key1 type="text" class=""
								placeholder="Username">
						</div>
					</div>
					<div class="metro double-size yellow">
						<div class="input-append lock-input">
							<input id='j_pwd' name='key2' type="password" class=""
								placeholder="Password">
						</div>
					</div>
					<div class="metro single-size terques login">
						<button type="submit" class="btn login-btn">
							登录
							<i class=" icon-long-arrow-right"></i>
						</button>
					</div>
				</form>
				<div class="metro double-size navy-blue ">
				</div>
		         <div class="metro double-size blue">
					<a href="<%=basePath%>system/regist" class="social-link"> <i class="icon-twitter-sign"></i><span>注册</span> </a>
				</div>
				<div class="metro double-size purple">
				</div>

			</div>
			-->
	</body>
</html>
