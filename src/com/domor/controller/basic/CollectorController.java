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
import com.domor.service.basic.CollectorService;
import com.domor.util.AuthFilter;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("collector")
public class CollectorController {
	
	@Autowired
	private CollectorService service;

	@AuthFilter
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "/webpages/basic/collector/index";
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
	
	@RequestMapping(value = "/collector_add", method = RequestMethod.GET)
	public ModelAndView collector_addGet(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/collector/add");
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/collector_add", method = RequestMethod.POST)
	public Object collector_addPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> collector = ParamUtils.getParameterMap(request);
		collector.put("creator", username);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.insert(collector);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加采集器信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/collector_edit", method = RequestMethod.GET)
	public Object collector_editGet(HttpServletRequest request) {
		String code = ParamUtils.getStringParameter(request, "code");
		Map<String,Object> collector = service.getByCode(code);
		return new ModelAndView("/webpages/basic/collector/edit", "collector", collector);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/collector_edit", method = RequestMethod.POST)
	public Object collector_editPost(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = user.get("username").toString();
		Map<String,Object> collector = ParamUtils.getParameterMap(request);
		collector.put("editor", username);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.update(collector);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加采集器信息发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/selectPointDialog", method = RequestMethod.GET)
	public String selectPointDialog(Model model,String areaCode) {
		model.addAttribute("areaCode", areaCode);
		return "/webpages/basic/collector/select_point_dialog";
	}
 
}
