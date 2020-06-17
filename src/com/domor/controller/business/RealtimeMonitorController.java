package com.domor.controller.business;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.PagerReturns;
import com.domor.service.business.RealtimeMonitorService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("realtimeMonitorData")
public class RealtimeMonitorController {
	@Autowired
	private RealtimeMonitorService realtimeMonitorService;
	private Logger logger = LoggerFactory.getLogger(RealtimeMonitorController.class);
	
	@AuthFilter
	@RequestMapping("/index")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("/webpages/business/realtimeMonitorData/index");
	}
	
	@AuthFilter
	@RequestMapping("/video")
	public ModelAndView video(HttpServletRequest request) {
		return new ModelAndView("/webpages/business/realtimeMonitorData/video");
	}
	
	/**
	 * 养殖点树
	 */
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/pondTree")
	public Object pondTree(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getStringValue(user, "username");
		return realtimeMonitorService.deptTree(username);
	}
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		
		int total = realtimeMonitorService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> data  = realtimeMonitorService.query(params);
		PagerReturns pager = new PagerReturns(data, total);
		return pager;
	}
	
	@ResponseBody
	@RequestMapping("/queryChart")
	public Object queryChart(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryNewChart(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryPond")
	public Object queryPond(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryPond(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryLngLat")
	public Object queryLngLat(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryLngLat(params);
	if (data.size()==0){
		data  = realtimeMonitorService.queryLngLatOnly(params);
	}
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryLngLatOnly")
	public Object queryLngLatOnly(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryLngLatOnly(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryLngLatByUsername")
	public Object queryLngLatByUsername(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryLngLatByUsername(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryDevice")
	public Object queryDevice(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryDevice(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryDeviceByPond")
	public Object queryDeviceByPond(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryDeviceByPond(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/queryDeviceByCode")
	public Object queryDeviceByCode(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = realtimeMonitorService.countDeviceByCode(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> data  = realtimeMonitorService.queryDeviceByCode(params);
		PagerReturns pager = new PagerReturns(data, total);
		return pager;
	}
	
	@ResponseBody
	@RequestMapping("/queryDeviceByLntLat")
	public Object queryDeviceByLntLat(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = realtimeMonitorService.countDeviceByLntLat(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> data  = realtimeMonitorService.queryDeviceByLntLat(params);
		PagerReturns pager = new PagerReturns(data, total);
		return pager;
	}
	
	@ResponseBody
	@RequestMapping("/queryCollector")
	public Object queryCollector(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = realtimeMonitorService.queryCollector(params);
	return data;
	}
	
	
	
	@AuthFilter
	@RequestMapping("/curve")
	public ModelAndView curve(HttpServletRequest request) {
		return new ModelAndView("/webpages/business/realtimeMonitorData/curve");
	}
	
	@ResponseBody
	@RequestMapping("/query_PHCurve")
	public Object query_PHCurve(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	params.put("LXBH_CGQ_PH",com.domor.util.Constant.LXBH_CGQ_PH);
	List<Map<String, Object>> data  = realtimeMonitorService.query_PHCurve(params);
	return data;
	}
	
	@ResponseBody
	@RequestMapping("/query_TOCurve")
	public Object query_TOCurve(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	params.put("LXBH_CGQ_RYWD", com.domor.util.Constant.LXBH_CGQ_RYWD);
	List<Map<String, Object>> data  = realtimeMonitorService.query_TOCurve(params);
	return data;
	}
	
	@AuthFilter
	@RequestMapping("/status")
	public ModelAndView status(HttpServletRequest request) {
		return new ModelAndView("/webpages/business/realtimeMonitorData/status");
	}
}
