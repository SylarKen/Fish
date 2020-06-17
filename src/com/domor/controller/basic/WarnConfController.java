package com.domor.controller.basic;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.PagerReturns;
import com.domor.service.basic.CollectorService;
import com.domor.service.basic.DeviceService;
import com.domor.service.basic.WarnConfService;
import com.domor.util.ParamUtils;
import com.github.pagehelper.PageInfo;

/**
 * 告警配置控制器
 */
@Controller
@RequestMapping("warnConf")
public class WarnConfController {

	private Logger LOGGER = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private CollectorService collectorService;
	
	@Autowired
	private DeviceService deviceService;
	
	@Autowired
	private WarnConfService warnConfService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request, HttpServletResponse response) {
		return "webpages/basic/warn/config-info";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addGet(HttpServletRequest request, HttpServletResponse response) {
		return "webpages/basic/warn/config-info-add-simple";
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Object addPost(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getString(user, "username");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Map<String, Object> warnConf = ParamUtils.getParameterMap(request);
			String deviceCode = ParamUtils.getStringParameter(request, "deviceCode");
			if (warnConfService.findByDeviceCode(deviceCode) == null) {
				warnConf.put("creator", username);
				warnConf.put("createTime", new Date());
				warnConfService.add(warnConf);
			} else {
				throw new Exception("该设备已经配置了告警信息，不能重复配置");
			}
		} catch (Exception e) {
			LOGGER.error("添加告警配置信息出现错误：{}", e.getMessage());
			result.put("errorMsg", new StringBuffer("添加告警配置信息出现错误：").append(e.getMessage()).toString());
		}
		
		return result;
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView editGet(HttpServletRequest request, HttpServletResponse response) {
		int id = ParamUtils.getIntParameter(request, "id");
		Map<String, Object> warnConf = warnConfService.findById(id);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("webpages/basic/warn/config-info-edit-simple");
		mv.addObject("warnConf", warnConf);
		return mv;
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public Object editPost(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getString(user, "username");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Map<String, Object> warnConf = ParamUtils.getParameterMap(request);
			warnConf.put("editor", username);
			warnConf.put("editTime", new Date());
			warnConfService.edit(warnConf);
		} catch (Exception e) {
			LOGGER.error("编辑告警配置信息出现错误:", e);
			result.put("errorMsg", "编辑告警配置信息出现错误！");
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/query")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object query(HttpServletRequest request) {
	    int total = 0;//总的记录数
	    List<Map<String, Object>> list = null;// 需要返回的分页数据

	    try {
	        Map<String, Object> params = ParamUtils.getParameterMap(request); //查询参数
	        list  = warnConfService.query(params); //获取分布数据
	        PageInfo page = new PageInfo(list);// 获取总记录数
	        total = (int) page.getTotal();
	    } catch (Exception e) {
	        LOGGER.error("获取告警配置信息出现错误！错误信息： ", e);
	    }

	    PagerReturns pager = new PagerReturns(list, total);//对数据进行简单封装
	    return pager;
	}
	
	@ResponseBody
	@RequestMapping("/collectors")
	@SuppressWarnings({ "unchecked" })
	public Object collectors(HttpServletRequest request) {
		
		Map<String, Object> userMap = (Map<String, Object>) request.getSession().getAttribute("user");	
		String dept = MapUtils.getString(userMap, "dept");
		boolean hasBlank = ParamUtils.getBooleanParameter(request, "hasBlank", false);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pondCode", dept);
		
		List<Map<String, Object>> result = collectorService.query(params);
		if (hasBlank) {
			Map<String, Object> blank = new HashMap<String, Object>();
			blank.put("collectorCode", "");
			blank.put("collectorName", "== 请选择采集器 ==");
			blank.put("selected", "true");
			result.add(0, blank);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/devices")
	public Object devices(HttpServletRequest request) {
		
		String collectorCode = ParamUtils.getStringParameter(request, "collectorCode");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("collectorCode", collectorCode);
		
		return deviceService.query(params);
	}
}
