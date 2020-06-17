package com.domor.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSONObject;
import com.domor.service.SystemService;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private SystemService service;

	public SystemService getService() {
		return service;
	}

	@Autowired
	public void setService(SystemService service) {
		this.service = service;
	}

	@Override
	@SuppressWarnings("unchecked")
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
			AuthFilter authPassport = ((HandlerMethod) handler).getMethodAnnotation(AuthFilter.class);

			String requestUri = request.getRequestURI();
			String contextPath = request.getContextPath();
			String url = requestUri.substring(contextPath.length());
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

			// 没有声明需要权限,或者声明不验证权限
			if (authPassport == null || authPassport.validate() == false)
				return true;
			else {
				Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");

				if (user == null) {// 没有登录 跳到登录界面
					PrintWriter out = response.getWriter();
					out.println("<html>");
					out.println("<script>");
					out.println("window.open ('" + basePath + "login.jsp','_top')");
					out.println("</script>");
					out.println("</html>");

					return false;
				} else {// 已经登录 进行权限验证
						// 在这里实现自己的权限验证逻辑
					List<Map<Object, Object>> allActions = service.getAllActions();
					boolean hasAction = false;
					for (Map<Object, Object> action : allActions) {
						String menuUrl = action.get("menuUrl") == null ? "" : action.get("menuUrl").toString();
						if (("/" + menuUrl).equals(url)) {
							hasAction = true;
							break;
						}
					}
					if (!hasAction)
						return true;

					List<Map<Object, Object>> actions = service.getActionsByUser(user.get("username").toString());
					hasAction = false;
					for (Map<Object, Object> action : actions) {
						String menuUrl = action.get("menuUrl") == null ? "" : action.get("menuUrl").toString();
						if (("/" + menuUrl).equals(url)) {
							hasAction = true;
							break;
						}
					}
					if (!hasAction) {
						PrintWriter out = response.getWriter();
						out.println("<html>");
						out.println("<script>");
						out.println("window.open ('" + basePath + "error.jsp','_top')");
						out.println("</script>");
						out.println("</html>");
						return false;
					}
					return true;
				}
			}
		} else
			return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
			LogAddFilter logAddPassport = ((HandlerMethod) handler).getMethodAnnotation(LogAddFilter.class);
			LogEditFilter logEditPassport = ((HandlerMethod) handler).getMethodAnnotation(LogEditFilter.class);
			LogDelFilter logDelPassport = ((HandlerMethod) handler).getMethodAnnotation(LogDelFilter.class);
			
			// 没有声明需要权限,或者声明不验证权限
			if (logAddPassport == null || logAddPassport.validate() == false || logEditPassport == null || logEditPassport.validate() == false || logDelPassport == null || logDelPassport.validate() == false )
				return;

			String requestUri = request.getRequestURI();
			String contextPath = request.getContextPath();
			String url = requestUri.substring(contextPath.length());
			Map<String, Object> params = ParamUtils.getParameterMap(request);
			String logContent = JSONObject.toJSONString(params);
			// 声明了新增操作的日志处理注解LogAddFilter
			if (logAddPassport != null && logAddPassport.validate()) {
				Map<String, Object> logParmas = new HashMap<String, Object>();
				logParmas.put("logType", 1);
				logParmas.put("logUrl", url);
				logParmas.put("logContent", logContent);
				service.log_save(logParmas);
			}

			// 声明了编辑操作的日志处理注解LogAddFilter
			if (logEditPassport != null && logEditPassport.validate()) {
				Map<String, Object> logParmas = new HashMap<String, Object>();
				logParmas.put("logType", 2);
				logParmas.put("logUrl", url);
				logParmas.put("logContent", logContent);
				service.log_save(logParmas);
			}

			// 声明了删除操作的日志处理注解LogAddFilter
			if (logDelPassport != null && logDelPassport.validate()) {
				Map<String, Object> logParmas = new HashMap<String, Object>();
				logParmas.put("logType", 3);
				logParmas.put("logUrl", url);
				logParmas.put("logContent", logContent);
				service.log_save(logParmas);
			}
		}

		super.postHandle(request, response, handler, modelAndView);
	}

}
