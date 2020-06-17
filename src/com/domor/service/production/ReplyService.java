package com.domor.service.production;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.domor.dao.production.ReplyDao;
import com.domor.util.ParamUtils;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDao dao;

	public Integer getCount(Map<String, Object> params) {
		return dao.getCount(params);
	}

	public List<Map<String, Object>> getData(Map<String, Object> params) {
		return dao.getData(params);
	}

	@Transactional
	public Map<String, Object> add(HttpServletRequest request) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("ok", false);
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		params.put("creator", user.get("username").toString());
		Integer rtn = dao.add(params);
		if(rtn <= 0){
			rtnMap.put("errorMsg", "新增回复失败！");
			return rtnMap;
		}
		params.put("reporStatus", 2);
		rtn = dao.updateReport(params);
		if(rtn <= 0){
			rtnMap.put("errorMsg", "新增回复后更新上报问题状态失败！");
			return rtnMap;
		}
		rtnMap.put("ok", true);
		return rtnMap;
	}
	
	@Transactional
	public Map<String, Object> edit(HttpServletRequest request) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("ok", false);
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		params.put("editor", user.get("username").toString());
		Integer rtn = dao.edit(params);
		if(rtn <= 0){
			rtnMap.put("errorMsg", "修改回复失败！");
			return rtnMap;
		}
		//查看该问题是否已回复
		Integer num = dao.getValidReplyNumByReportId(params);
		if(num == null || num == 0){
			params.put("reporStatus", 1);
			rtn = dao.updateReport(params);
		}
		rtnMap.put("ok", true);
		return rtnMap;
	}

	public Map<String, Object> getById(int id) {
		return dao.getById(id);
	}

	public Map<String, Object> getReportById(int id) {
		return dao.getReportById(id);
	}

	public List<Map<String, Object>> getReplyByReportId(Map<String, Object> params) {
		return dao.getReplyByReportId(params);
	}

}
