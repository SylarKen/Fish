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
import com.domor.service.production.FoodService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.ParamUtils;
import com.domor.util.MapUtils;

@Controller
@RequestMapping("food")
public class FoodController {	

	@Autowired
	private FoodService foodService;

	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/production/food/index";
	}
	
	@AuthFilter
	@RequestMapping("/add")
	public String add() {
		return "/webpages/production/food/add";
	}
	
	@AuthFilter
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = foodService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/food/edit";
	}
	
	@AuthFilter
	@RequestMapping("/select")
	public String select(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		m.addAttribute("selId", MapUtils.getStringValue(params, "selId"));
		return "/webpages/production/food/select";
	}
	
	@AuthFilter
	@RequestMapping("/detail")
	public String detail(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = foodService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/food/detail";
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/getPagerData")
	public Object getPagerData(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		params.put("creator", user.get("username").toString());
		Integer total = foodService.getCount(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String,Object>> products = foodService.getData(params);
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
			Integer rtn = foodService.add(params);
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
			Integer rtn = foodService.edit(params);
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
