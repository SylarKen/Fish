package com.domor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.model.SearchDomain;
import com.domor.service.SystemService;
import com.domor.util.AuthFilter;
import com.domor.util.DigestUtil;

@Controller
@RequestMapping("system")
public class SystemController {

	@Autowired
	private SystemService systemService;

	@ResponseBody
	@RequestMapping("/login")
	public Object login(HttpServletRequest request, SearchDomain params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String md5pwd = DigestUtil.md5(params.getKey2());
		params.setKey2(md5pwd);
		List<Map<Object, Object>> users = systemService.getUser(params);
		boolean ok = true;// 默认成功
		String msg = "登录成功！";
		if (users != null && users.size() > 0) {
			Map<Object, Object> user = users.get(0);
			request.getSession().setAttribute("user", user);
			addBasePathAttributeInSession(request);
		} else {
			ok = false;
			msg = "账号或者密码错误！";
		}
		resultMap.put("ok", ok);
		resultMap.put("msg", msg);
		return resultMap;
	}
	
//	@ResponseBody
//	@RequestMapping("/regist")
//	public Object regist(HttpServletRequest request) {
//		/*
//		 *  1. 查询手机号是否已经注册
//		 *  2. 注册会员（会员注册时要不要发送短信验证码？注册成功后要不要发送短信验证码？）
//		 *  3. 返回值
//		 */
//		
//		return  null;
//	}

	@RequestMapping("/exit")
	public String exit(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:/login.jsp";
	}

	@AuthFilter
	@RequestMapping("/index")
	@SuppressWarnings("unchecked")
	public String index(Model model, HttpSession session) {
		Map<Object, Object> user = (Map<Object, Object>) session.getAttribute("user");
		List<Map<Object, Object>> menus = systemService.getMenusByUser(user.get("username").toString());
		model.addAttribute("menus", menus);
		return "/index";
	}

	@AuthFilter
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/getActionsByUser")
	public Object getActionsByUser(HttpSession session) {
		Map<Object, Object> user = (Map<Object, Object>) session.getAttribute("user");
		return systemService.getActionsByUser(user.get("username").toString());
	}

	@AuthFilter
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/editPwd_save")
	public Object editPwd_save(HttpSession session, SearchDomain params) {
		Map<String, Object> rtn = new HashMap<String, Object>();
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		//原始密码校验
		params.setKey1(user.get("username").toString());
		params.setKey2(DigestUtil.md5(params.getKey2()));
		List<Map<Object, Object>> users = systemService.getUser(params);
		if (users != null && users.size() > 0) {
			params.setKey3(DigestUtil.md5(params.getKey3()));
			Integer r = systemService.editPwd_save(params);
			if(r > 0){
				rtn.put("ok", true);
			}else{
				rtn.put("ok", false);
				rtn.put("errorMsg", "修改密码失败！");
			}
			return rtn;
		} else {
			rtn.put("ok", false);
			rtn.put("errorMsg", "原始密码输入错误！");
			return rtn;
		}
	}
	
	private void addBasePathAttributeInSession(HttpServletRequest request) {
		String path = request.getContextPath();
		StringBuffer basePath = new StringBuffer();
		basePath.append(request.getScheme())
			.append("://")
			.append(request.getServerName())
			.append(":")
			.append(request.getServerPort())
			.append(path)
			.append("/");
		request.getSession().setAttribute("basePath", basePath.toString());
	}

}
