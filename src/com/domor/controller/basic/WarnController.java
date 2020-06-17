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
import com.domor.service.basic.WarnService;
import com.domor.util.AuthFilter;
import com.domor.util.DigestUtil;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("warn")
public class WarnController {

 
	@Autowired
	private WarnService service;

	@AuthFilter
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "/webpages/basic/warn/index";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public ModelAndView insertGet(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/warn/add");
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insertPost(HttpServletRequest request) {
		Map<String,Object> param = ParamUtils.getParameterMap(request);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.insert(param);
	
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加告警配置时发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public Object updateGet(HttpServletRequest request,int id) {
		Map<String,Object> warn = service.getById(id);
		return new ModelAndView("/webpages/basic/warn/edit", "warn", warn);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Object updatePost(HttpServletRequest request) {
		Map<String,Object> user = ParamUtils.getParameterMap(request);	
		return service.update(user);
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

 
 

}
