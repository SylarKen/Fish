package com.domor.controller.production;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.model.PagerReturns;
import com.domor.service.production.FeedService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("feed")
public class FeedController {	

	@Autowired
	private FeedService feedService;

	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/production/feed/index";
	}
	
	@AuthFilter
	@RequestMapping("/add")
	public String add(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		m.addAttribute("bean", params);
		return "/webpages/production/feed/add";
	}
	
	@AuthFilter
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = feedService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/feed/edit";
	}
	
	@AuthFilter
	@RequestMapping("/detail")
	public String detail(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = feedService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/feed/detail";
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/getPagerData")
	public Object getPagerData(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		String pondCodes = MapUtils.getStringValue(params, "pondCodes");
		String[] pondCodeArr = pondCodes.split(",");
		params.put("pondCodeArr", pondCodeArr);
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		params.put("creator", user.get("username").toString());
		Integer total = feedService.getCount(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String,Object>> products = feedService.getData(params);
		PagerReturns pager = new PagerReturns();
		pager.setTotal(total);
		pager.setRows(products);
		return pager;
	}
	
	@LogAddFilter
	@AuthFilter
	@ResponseBody
	@RequestMapping("/addSave")
	public Object addSave( HttpServletRequest request ) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("ok", false);
		try {
			@SuppressWarnings("unchecked")
			Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
			Map<String, Object> params = ParamUtils.getParameterMap(request);
			params.put("creator", user.get("username").toString());
			Integer rtn = feedService.add(params);
			if(rtn <= 0){
				rtnMap.put("errorMsg", "新增失败！");
				return rtnMap;
			}
			rtnMap.put("ok", true);
			return rtnMap;
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("errorMsg", e.getMessage());
			return rtnMap;
		}
	}
	
	@LogAddFilter
	@AuthFilter
	@ResponseBody
	@RequestMapping("/editSave")
	public Object editSave( HttpServletRequest request ) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("ok", false);
		try {
			@SuppressWarnings("unchecked")
			Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
			Map<String, Object> params = ParamUtils.getParameterMap(request);
			params.put("editor", user.get("username").toString());
			Integer rtn = feedService.edit(params);
			if(rtn <= 0){
				rtnMap.put("errorMsg", "修改失败！");
				return rtnMap;
			}
			rtnMap.put("ok", true);
			return rtnMap;
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("errorMsg", e.getMessage());
			return rtnMap;
		}
	}
}
