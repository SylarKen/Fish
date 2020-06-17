package com.domor.controller.business;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.domor.model.PagerReturns;
import com.domor.service.basic.DeptService;
import com.domor.service.business.MapInfoService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;
import com.github.pagehelper.PageInfo;

/**
 * 地图信息模块控制器
 */
@Controller
@RequestMapping("map")
public class MapInfoController {
	
	private Logger LOGGER = LoggerFactory.getLogger(MapInfoController.class);
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private MapInfoService mapInfoService;
	
	/**
	 * 跳转至人员分布页面
	 */
	@AuthFilter
//	@SuppressWarnings("unchecked")
	@RequestMapping("/user/distribution")
	public String distribution(HttpServletRequest request, HttpServletResponse response) {
//		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		return "webpages/map/distribution";
	}
	
	/**
	 * 跳转至人员分布页面
	 */
	@AuthFilter
	@RequestMapping("/warn")
	public String warn(HttpServletRequest request, HttpServletResponse response) {
		return "webpages/map/warn";
	}
	
	/**
	 * 养殖点树
	 */
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/dept/tree")
	public Object deptTree(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getStringValue(user, "username");
		return mapInfoService.deptTree(username);
	}
	
	/**
	 * 根据编码获取养殖点信息
	 */
	@ResponseBody
	@RequestMapping("/dept/info")
	public Object deptInfo(HttpServletRequest request, HttpServletResponse response) {
		String code = ParamUtils.getStringParameter(request, "code");//养殖点编码
		Map<String, Object> map = deptService.findById(code);
		if (ParamUtils.getBooleanParameter(request, "infoWindow", true)) {
			String infoWindowContent = mapInfoService.infoWindowContent(code);
			map.put("content", infoWindowContent);
		}
		return map;
	}
	
	/**
	 * 获取用户下辖所有养殖点信息
	 */
	@ResponseBody
	@RequestMapping("/dept/list")
	@SuppressWarnings("unchecked")
	public Object deptList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getStringValue(user, "username");
		boolean isWarn = ParamUtils.getBooleanParameter(request, "isWarn", false);
		return mapInfoService.deptList(username, isWarn);
	}
	
	@ResponseBody
	@RequestMapping("/warn/query")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryWarn(HttpServletRequest request) {
	    int total = 0;//总的记录数
	    List<Map<String, Object>> list = null;// 需要返回的分页数据

	    try {
	        Map<String, Object> params = ParamUtils.getParameterMap(request); //查询参数
	        // 打印查询参数到日志文件
	        if (LOGGER.isDebugEnabled()) {
	            LOGGER.debug("告警信息查询参数: {}", JSON.toJSONString(params));
	        }

	        list  = mapInfoService.queryWarn(params); //获取分布数据

	        PageInfo page = new PageInfo(list);// 获取总记录数
	        total = (int) page.getTotal();
	    } catch (Exception e) {
	        LOGGER.error("获取告警信息出现错误！错误信息： ", e);
	    }

	    PagerReturns pager = new PagerReturns(list, total);//对数据进行简单封装
	    return pager;
	}
	
	/**
	 * 根据养殖点编码获取采集器数据信息，并拼接成百度地图信息窗体内容（字符串），以键值对的方式返回（key = content）
	 */
	@ResponseBody
	@RequestMapping("/dept/winContent")
	public Object winContent(HttpServletRequest request, HttpServletResponse response) {
		String code = ParamUtils.getStringParameter(request, "code");//养殖点编码
		Map<String, Object> result = new HashMap<String, Object>();
		String content = mapInfoService.infoWindowContent(code);
		if (StringUtils.isNotBlank(content)) {
			result.put("content", content);
		}
		return result;
	}

}
