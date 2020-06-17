package com.domor.controller.basic;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.PagerReturns;
import com.domor.model.TreeNode;
import com.domor.service.basic.SensorNetService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.LogEditFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;
import com.domor.util.TreeNodeUtils;

@Controller
@RequestMapping("sensorNet")
public class SensorNetController {

	@Autowired
	private SensorNetService sensorNetService;
	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/basic/sensorNet/sensorNet";
	}
	
	/**
	 * 查询养殖点树
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		//查询出符合条件的所有数据
		List<Map<String, Object>> list  = sensorNetService.getDepts(params);
		List<Map<String, Object>> listCollectors  = sensorNetService.getCollectors(params);
		for (Map<String, Object> map : listCollectors) {
			map.put("grade", 3);
			list.add(map);
		}
		//分页查询
		PagerReturns pager = TreeNodeUtils.getTreeDataDept(list, params);
		return pager;
	}
	
	
	@ResponseBody
	@RequestMapping("/queryOxygen")
	public Object queryOxygen(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = sensorNetService.countOxygen(params);
		
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> users  = sensorNetService.queryOxygen(params);
		PagerReturns pager = new PagerReturns(users, total);
		return pager;
	}
	
	/**
	 * 分页查询信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unused")
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/getSensors", method = RequestMethod.POST)
	public Object getSensors(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		System.out.println("=============="+params.toString());
		int grade  = Integer.parseInt(params.get("grade").toString());
		if(grade==3){
			params.put("collectorId", params.get("deptCode").toString());
			params.remove("deptCode");
		}
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");	
		params.put("username", user.get("username").toString());
		int  total = sensorNetService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> users  = sensorNetService.query(params);
		PagerReturns pager = new PagerReturns(users, total);
		return pager;
	}
	
	@RequestMapping("/selectOxygen")
	public ModelAndView selectOxygen(HttpServletRequest request) {
		String data = ParamUtils.getStringParameter(request, "data", "[]");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/webpages/basic/sensorNet/sensorNet_addOxygen");
		mv.addObject("data", data);
		return mv;
	}
	
	@RequestMapping("/selectAerator")
	public ModelAndView selectAerator(HttpServletRequest request) {
		String data = ParamUtils.getStringParameter(request, "data", "[]");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/webpages/basic/sensorNet/sensorNet_addAerator");
		mv.addObject("data", data);
		return mv;
	}
	
	/**
	 * 采集器传感器关联表  device 中的fatherID 
	 * @param request
	 * @return
	 */
	@AuthFilter
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/addCollectorDevice", method = RequestMethod.POST)
	public Object addCollectorDevice(HttpServletRequest request) {
		Map<String,Object> params = ParamUtils.getParameterMap(request);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			int add1 = sensorNetService.addCollectorDevice(params);
			int add2 = sensorNetService.addDeviceFatherID(params);
			int add3 = add1 +add2;
			resultMap.put("errorMsg", add3);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加时发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	

	/**
	 * delete 采集器传感器关联表  device 中的fatherID 
	 * @param request
	 * @return
	 */
	@AuthFilter
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/deleteCollectorDevice", method = RequestMethod.POST)
	public Object deleteCollectorDevice(HttpServletRequest request) {
		Map<String,Object> params = ParamUtils.getParameterMap(request);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			int add1 = sensorNetService.deleteCollectorDevice(params);
			int add2 = sensorNetService.deleteDeviceFatherID(params);
			int add3 = add1 +add2;
			resultMap.put("errorMsg", add3);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加时发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	
	/**
	 * 配置溶氧度传感器跳转页面
	 * @param request
	 * @return
	 */
	@AuthFilter
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(HttpServletRequest request) {
		String value = null;
		try {
			value = new String(request.getParameter("name").getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}///Fish/WebRoot/.jsp
		//System.out.println("============="+request.getParameter("id").toString());
		return "webpages/basic/sensorNet/sensorNet_add";
	}
	

	
	/**
	 * 配置心跳包周期跳转页面
	 * @param request
	 * @return
	 */
	@AuthFilter
	@RequestMapping(value = "/heartBeat", method = RequestMethod.GET)
	public String heartBeat(HttpServletRequest request) {	
		String value = null;
		try {
			value = new String(request.getParameter("name").getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}///Fish/WebRoot/.jsp
		//System.out.println("============="+request.getParameter("id").toString());
		return "webpages/basic/sensorNet/sensorNet_Heart_Beat";
	}
	
	
	/**
	 *readHeartBeatCycle
	 * @param request
	 * @return
	 */
	@LogAddFilter
	@AuthFilter
	@ResponseBody
	@RequestMapping(value ="/readHeartBeatCycle", method = RequestMethod.POST)
	public Object readHeartBeatCycle( HttpServletRequest request ) {
		Map<String,Object> params = ParamUtils.getParameterMap(request);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String,Object> readHeartBeatCycle = sensorNetService.readHeartBeatCycle(params);
			return readHeartBeatCycle;
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("errorMsg", e.getMessage());
			return rtnMap;
		}
	}
	
	
	/**
	 *updateHeartBeatCycle
	 * @param request
	 * @return
	 */
	@LogAddFilter
	@AuthFilter
	@ResponseBody
	@RequestMapping(value ="/updateHeartBeatCycle", method = RequestMethod.POST)
	public Object updateHeartBeatCycle( HttpServletRequest request ) {
		Map<String,Object> params = ParamUtils.getParameterMap(request);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			int updateHeartBeatCycle = sensorNetService.updateHeartBeatCycle(params);
			rtnMap.put("success", updateHeartBeatCycle);
			return rtnMap;
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("errorMsg", e.getMessage());
			return rtnMap;
		}
	}
	
}
