package com.domor.controller.production;

import java.sql.Timestamp;
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
import com.domor.service.production.ReportService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("report")
public class ReportController {	

	@Autowired
	private ReportService reportService;

	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/production/report/index";
	}
	
	@AuthFilter
	@RequestMapping("/add")
	public String add(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		m.addAttribute("bean", params);
		return "/webpages/production/report/add";
	}
	
	@AuthFilter
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = reportService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/report/edit";
	}
	
	@AuthFilter
	@RequestMapping("/detail")
	public String detail(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = reportService.getById(id);
		repairBean(bean);
		m.addAttribute("bean", bean);
		return "/webpages/production/report/detail";
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
		Integer total = reportService.getCount(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String,Object>> products = reportService.getData(params);
		PagerReturns pager = new PagerReturns();
		pager.setTotal(total);
		pager.setRows(products);
		return pager;
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/getReplys")
	public Object getReplys(HttpServletRequest request) {
		Map<String, Object> rtn = new HashMap<String, Object>();
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> replyArr = reportService.getReplyByReportId(params);
		if( replyArr == null || replyArr.size() == 0 ){
			rtn.put("ok", false);
			return rtn;
		}
		rtn.put("ok", true);
		rtn.put("replyArr", replyArr);
		return rtn;
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
			Integer rtn = reportService.add(params);
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
			Map<String, Object> params = ParamUtils.getParameterMap(request);
			Integer rtn = reportService.edit(params);
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
	
	@LogAddFilter
	@AuthFilter
	@ResponseBody
	@RequestMapping("/report")
	public Object report( HttpServletRequest request ) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("ok", false);
		try {
			Map<String, Object> params = ParamUtils.getParameterMap(request);
			Integer rtn = reportService.report(params);
			if(rtn <= 0){
				rtnMap.put("errorMsg", "操作失败！");
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
	
	
	private void repairBean(Map<String, Object> bean){
		//类型：0其他，1鱼苗，2喂养，3用药，4捕捞
		int type = MapUtils.getIntValue(bean, "type");
		String text = "未知";
		switch(type){
			case 0: text = "其他"; break;
			case 1: text = "鱼苗"; break;
			case 2: text = "喂养"; break;
			case 3: text = "用药"; break;
			case 4: text = "捕捞"; break;
		}
		bean.put("typeText", text);
		//上报时间
		Object reportTime = bean.get("reportTime");
		if(reportTime != null){
			Timestamp t = (Timestamp)reportTime;
			String reportTimeStr = t.toString().substring(0, 19);
			bean.put("reportTime", reportTimeStr);
		}
		
	}
}
