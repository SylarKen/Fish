package com.domor.controller.basic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.PagerReturns;
import com.domor.service.basic.DeviceService;
import com.domor.util.AuthFilter;
import com.domor.util.ParamUtils;
import com.domor.util.TreeNodeUtils;

@Controller
@RequestMapping("device")
public class DeviceController {
	
	@Autowired
	private DeviceService service;

	@AuthFilter
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "/webpages/basic/device/index";
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
	
	@RequestMapping(value = "/device_add", method = RequestMethod.GET)
	public ModelAndView device_addGet(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/device/add");
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/device_add", method = RequestMethod.POST)
	public Object device_addPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> device = ParamUtils.getParameterMap(request);
		device.put("creator", username);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.insert(device);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加设备信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/device_edit", method = RequestMethod.GET)
	public Object device_editGet(HttpServletRequest request) {
		String code = ParamUtils.getStringParameter(request, "code");
		Map<String,Object> device = service.getByCode(code);
		return new ModelAndView("/webpages/basic/device/edit", "device", device);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/device_edit", method = RequestMethod.POST)
	public Object device_editPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> device = ParamUtils.getParameterMap(request);
		device.put("editor", username);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.update(device);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加设备信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getTypes")
	public Object getTypes(HttpServletRequest request) {
		return service.getTypes();
	}
	
	@RequestMapping(value = "/selectPondDialog", method = RequestMethod.GET)
	public String selectPondDialog(Model model,String areaCode) {
		model.addAttribute("areaCode", areaCode);
		return "/webpages/basic/device/select_pond_dialog";
	}
	
	@ResponseBody
	@RequestMapping("/queryPonds")
	public Object queryPonds(HttpServletRequest request ) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> list  = service.getPonds(params);
		PagerReturns pager = TreeNodeUtils.getTreeDataDept(list, params);
		return pager;
	}
	
	@RequestMapping(value = "/selectCollectorDialog", method = RequestMethod.GET)
	public String selectCollectorDialog(Model model,String pointCode) {
		model.addAttribute("pointCode", pointCode);
		return "/webpages/basic/device/select_collector_dialog";
	}
 
}
