package com.domor.controller.basic;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.PagerReturns;
import com.domor.model.User;
import com.domor.service.basic.RoleService;
import com.domor.service.basic.UserService;
import com.domor.util.AuthFilter;
import com.domor.util.DigestUtil;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private UserService userService;

	@AuthFilter
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "/webpages/basic/user/user";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public ModelAndView insertGet(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/user/user_add");
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insertPost(HttpServletRequest request) {
		Map<String,Object> user = ParamUtils.getParameterMap(request);
		Map<String, Object> userMap = (Map<String, Object>) request.getSession().getAttribute("user");		
		user.put("password",DigestUtil.md5("123456"));
		user.put("creator",MapUtils.getStringValue(userMap, "username"));
		 
		Map<String,Object> exsitUser = userService.getByName(user.get("username").toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(exsitUser!=null){
			resultMap.put("errorMsg", "用户名[" + user.get("username").toString()+"]已存在，不能重名！");
			return resultMap;
		}
	
		try {
			userService.insert(user);			 
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加用户信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public Object updateGet(HttpServletRequest request) {
		String username = ParamUtils.getStringParameter(request, "username");
		Map<String,Object> user = userService.getByName(username);
		return new ModelAndView("/webpages/basic/user/user_edit", "user", user);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Object updatePost(HttpServletRequest request) {
		Map<String,Object> user = ParamUtils.getParameterMap(request);
		Map<String, Object> userMap = (Map<String, Object>) request.getSession().getAttribute("user");
		user.put("editor",MapUtils.getStringValue(userMap, "username"));
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			userService.update(user);			 
		}catch(Exception e){
			e.printStackTrace();
			StringBuffer sb = new StringBuffer("编辑用户信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		
		return resultMap;
	}
 
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = userService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> users  = userService.query(params);
		PagerReturns pager = new PagerReturns(users, total);
		return pager;
	}
 

	@AuthFilter
	@ResponseBody
	@RequestMapping("/user_initPwd")
	public Object user_initPwd(String username) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", username);
		params.put("password", DigestUtil.md5("123456"));
		try {
			userService.initUserPwd(params);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("初始化密码时发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}

}
