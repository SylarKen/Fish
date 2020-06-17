package com.domor.controller.basic;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.DataDictionary;
import com.domor.model.PagerReturns;
import com.domor.service.basic.DataDictionaryService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("dataDictionary")
public class DataDictionaryController {

	@Autowired
	private DataDictionaryService dataDictionaryService;

	@AuthFilter
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(HttpServletRequest request) {
		return "/webpages/basic/dataDictionary/dataDictionary";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertGet(HttpServletRequest request) {
		return "/webpages/basic/dataDictionary/dataDictionary_add";
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insertPost(HttpServletRequest request, DataDictionary dataDictionary) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		dataDictionary.setCreator(MapUtils.getStringValue(user, "username"));
		dataDictionary.setCreateTime(new Date());
		return dataDictionaryService.insert(dataDictionary);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView updateGet(HttpServletRequest request) {
		int id = ParamUtils.getIntParameter(request, "id");
		DataDictionary dataDictionary = dataDictionaryService.findById(id);
		return new ModelAndView("/webpages/basic/dataDictionary/dataDictionary_edit", "dataDictionary", dataDictionary);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Object updatePost(HttpServletRequest request, DataDictionary dataDictionary) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		dataDictionary.setEditor(MapUtils.getStringValue(user, "username"));
		dataDictionary.setEditTime(new Date());
		return dataDictionaryService.update(dataDictionary);
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Object delete(HttpServletRequest request) {
		return 0;
	}
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
//		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = dataDictionaryService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<DataDictionary> dataDictionarys  = dataDictionaryService.query(params);
		PagerReturns pager = new PagerReturns(dataDictionarys, total);
		return pager;
	}
	
//	@AuthFilter
//	@RequestMapping("/dataDictionary")
//	public String packageIndex() {
//		return "/webpages/basic/dataDictionary/dataDictionary";
//	}
//
//	@LogAddFilter
//	@AuthFilter
//	@ResponseBody
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/addDataDictionary")
//	public Object save(HttpServletRequest request, DataDictionary dataDic) {
//
//		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
//		int userCompanyId = Integer.parseInt(user.get("companyId").toString());
//		String userRealname = (user.get("realname").toString());
//
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		try {
//			dataDic.setCreator(userRealname);
//			dataDic.setCreateTime(new Date());
//			dataDic.setDelete_flag(0);
//			dataDic.setCompanyId(userCompanyId);
//			dataDictionaryService.save(dataDic);
//		} catch (Exception e) {
//			StringBuffer sb = new StringBuffer("添加数据时发生异常，异常信息");
//			sb.append("您输入有误");
//			sb.append("\n");
//			sb.append(e.getMessage());
//			resultMap.put("errorMsg", sb.toString());
//		}
//		return resultMap;
//	}
//
//	@AuthFilter
//	@ResponseBody
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/right_getDataDictionary")
//	public Object right_getDataDictionary(HttpSession session, SearchDomain params) {
//		Map<Object, Object> user = (Map<Object, Object>) session.getAttribute("user");
////		int userCompanyId = Integer.parseInt(user.get("companyId").toString());
////		params.setKey6(userCompanyId);
//		Integer total = dataDictionaryService.count(params);
//		params.setSkipCount(total);
//		List<Map<Object, Object>> packageindex = dataDictionaryService.query(params);
//
//		PagerReturns pager = new PagerReturns();
//		pager.setTotal(total);
//		pager.setRows(packageindex);
//		return pager;
//	}
//
//	@LogEditFilter
//	@AuthFilter
//	@ResponseBody
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/editDataDic")
//	public Object editBank(HttpSession session, DataDictionary dataDictionary) {
//		Map<Object, Object> user = (Map<Object, Object>) session.getAttribute("user");
//		String userRealname = (user.get("realname").toString());
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		try {
//			dataDictionary.setLastEditor(userRealname);
//			dataDictionary.setLastEditTime(new Date());
//			dataDictionaryService.update(dataDictionary);
//		} catch (Exception e) {
//			StringBuffer sb = new StringBuffer("修改数据时发生异常，异常信息");
//			sb.append("\n");
//			sb.append(e.getMessage());
//			resultMap.put("errorMsg", sb.toString());
//		}
//		return resultMap;
//	}
//
//	@LogDelFilter
//	@AuthFilter
//	@RequestMapping("/deleteDataDictionary")
//	@ResponseBody
//	public Object deleteData(String dataId) {
//		Integer result = dataDictionaryService.delete(dataId);
//		return result;
//	}
//
//	/**
//	 * 根据类型查询数据
//	 */
//	@ResponseBody
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/dataDicForCombo")
//	public Object dataDicForCombo(HttpServletRequest request) {
//		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
//		String companyId = user.get("companyId").toString();
//		int hasBlank = ParamUtils.getIntParameter(request, "hasBlank");
//		String dataDicType = ParamUtils.getStringParameter(request, "type");
//		List<DataDictionary> dataDictionaries = dataDictionaryService.getDataDictionariesByType(dataDicType, companyId);
//
//		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
//		if (hasBlank == 1) {
//			Map<String, Object> blankMap = new HashMap<String, Object>();
//			blankMap.put("id", "0");
//			blankMap.put("text", "--请选择--");
//			blankMap.put("selected", true);
//			result.add(blankMap);
//		}
//		for (DataDictionary dataDic : dataDictionaries) {
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("id", dataDic.getCode());
//			map.put("text", dataDic.getName());
//			result.add(map);
//		}
//
//		return result;
//	}
}
