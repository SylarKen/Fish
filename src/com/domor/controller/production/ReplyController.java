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
import com.domor.service.production.ReplyService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("reply")
public class ReplyController {	

	@Autowired
	private ReplyService replyService;

	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/production/reply/index";
	}
	
	@AuthFilter
	@RequestMapping("/detail")
	public String detail(HttpServletRequest request, int id, Model m) {
		Map<String, Object> report = replyService.getReportById(id);
		repairBean(report);
		m.addAttribute("report", report);
		return "/webpages/production/reply/detail";
	}
	
	@AuthFilter
	@RequestMapping("/add")
	public String add(HttpServletRequest request, int reportId, Model m) {
		m.addAttribute("reportId", reportId);
		return "/webpages/production/reply/add";
	}
	
	@AuthFilter
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, int id, Model m) {
		Map<String, Object> bean = replyService.getById(id);
		m.addAttribute("bean", bean);
		return "/webpages/production/reply/edit";
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/getReplys")
	public Object getReplys(HttpServletRequest request) {
		Map<String, Object> rtn = new HashMap<String, Object>();
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		params.put("username", user.get("username").toString());
		List<Map<String, Object>> replyArr = replyService.getReplyByReportId(params);
		if( replyArr == null || replyArr.size() == 0 ){
			rtn.put("ok", false);
			return rtn;
		}
		rtn.put("ok", true);
		rtn.put("replyArr", replyArr);
		return rtn;
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/getPagerData")
	public Object getPagerData(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		Integer total = replyService.getCount(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String,Object>> products = replyService.getData(params);
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
			return replyService.add(request);
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
			return replyService.edit(request);
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
