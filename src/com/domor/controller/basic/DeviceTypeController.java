package com.domor.controller.basic;

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
import com.domor.service.basic.DeviceTypeService;
import com.domor.util.AuthFilter;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("deviceType")
public class DeviceTypeController {
	
	@Autowired
	private DeviceTypeService service;

	@AuthFilter
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "/webpages/basic/deviceType/index";
	}
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = service.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> users  = service.query(params);
		PagerReturns pager = new PagerReturns(users, total);
		return pager;
	}
	
	@RequestMapping(value = "/deviceType_add", method = RequestMethod.GET)
	public ModelAndView deviceType_addGet(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/deviceType/add");
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deviceType_add", method = RequestMethod.POST)
	public Object deviceType_addPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> deviceType = ParamUtils.getParameterMap(request);
		deviceType.put("creator", username);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int isSame = service.getByCode(deviceType);
			if(isSame>0){
				resultMap.put("errorMsg", "类型编号已存在");
			}else{
				service.insert(deviceType);
			}
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加设备类型信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/deviceType_edit", method = RequestMethod.GET)
	public Object deviceType_editGet(HttpServletRequest request,int id) {
		Map<String,Object> deviceType = service.getById(id);
		return new ModelAndView("/webpages/basic/deviceType/edit", "deviceType", deviceType);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deviceType_edit", method = RequestMethod.POST)
	public Object deviceType_editPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> deviceType = ParamUtils.getParameterMap(request);
		deviceType.put("editor", username);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int isSame = service.getByCode(deviceType);
			if(isSame>0){
				resultMap.put("errorMsg", "类型编号已存在");
			}else{
				service.update(deviceType);
			}
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加设备类型信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
}
