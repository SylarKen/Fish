package com.domor.controller.basic;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.DataDictionary;
import com.domor.model.PagerReturns;
import com.domor.service.basic.DeptService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;
import com.domor.util.TreeNodeUtils;

@Controller
@RequestMapping("dept")
public class DeptController {

	@Autowired
	private DeptService service;

	@AuthFilter
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(HttpServletRequest request,Model model) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String myDeptCode = MapUtils.getStringValue(user, "dept");
		Map<String, Object> myDept = service.findById(myDeptCode);
		model.addAttribute("myDept", myDept);
		return "/webpages/basic/dept/index";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertGet(HttpServletRequest request) {
		String pname = ParamUtils.getStringParameter(request, "pname");
		String pcode = ParamUtils.getStringParameter(request, "pcode");
		String pgrade = ParamUtils.getStringParameter(request, "pgrade");
		request.setAttribute("pname", pname);
		request.setAttribute("pcode", pcode);
		request.setAttribute("pgrade", pgrade);
		return "/webpages/basic/dept/add";
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insertPost(HttpServletRequest request) {
		//Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);	
		//Map<String, Object> dept = service.findById(MapUtils.getStringValue(params, "userDept"));
		String pcode = MapUtils.getStringValue(params, "pcode");
		//int grade = MapUtils.getIntValue(dept, "grade")+1;
		int grade = MapUtils.getIntValue(params, "pgrade")+1;
		String newCode="";
		if(grade==1)
		  newCode = service.getNewCode1();
		else if(grade==2)
		  newCode = service.getNewCode2(pcode);
		params.put("code",newCode);
		params.put("grade", grade);
		params.put("pcode", pcode);
		//params.put("creator", MapUtils.getStringValue(user, "username"));
		return service.insert(params);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView updateGet(HttpServletRequest request, Model model , String code,String pcode) {
		Map<String, Object> dept = service.findById(code);	
		Map<String, Object> pdept = service.findById(pcode);
		model.addAttribute("pdept", pdept);
		return new ModelAndView("/webpages/basic/dept/edit", "dept", dept);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Object updatePost(HttpServletRequest request, DataDictionary dataDictionary) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);		
		params.put("editor", MapUtils.getStringValue(user, "username"));
		return service.update(params);
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Object delete(HttpServletRequest request) {
		return 0;
	}
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		params.put("username", MapUtils.getStringValue(user, "username"));
		//查询出符合条件的所有数据
		List<Map<String, Object>> list  = service.getDepts(params);
		//分页查询
		PagerReturns pager = TreeNodeUtils.getTreeDataDept(list, params);
		return pager;
	}
	
	
	@ResponseBody
	@RequestMapping("/getChildDepts")
	public Object getChildDepts(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		return service.getChildDepts( MapUtils.getStringValue(user, "username"));
	}
	
	
	
	@AuthFilter
	@RequestMapping(value = "/areaSelectDialog", method = RequestMethod.GET)
	public String areaSelectDialog(HttpServletRequest request) {
		return "/webpages/basic/dept/areaSelectDialog";
	}
	
	
	@ResponseBody
	@RequestMapping("/getDeptForComb")
	public Object getDeptForComb(HttpServletRequest request,int hasBlank,String area) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		List<Map<String, Object>> depts = service.getDeptForComb( MapUtils.getStringValue(user, "username"),area);
		if (hasBlank == 1) {
			Map<String, Object> blankOption = new HashMap<String, Object>();
			blankOption.put("code", "");
			blankOption.put("name", "-选择部门-");
			depts.add(0, blankOption);
		}
		return depts;
	}
	
	
	/*@RequestMapping("/getAreaTreeData")
	@ResponseBody
	public Object getAreaTreeData(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");

		Map<String, Object> params = ParamUtils.getParameterMap(request);
	 
		PagerReturns result = service.getAreaTreeData();
		 
		return result;
		
	}*/
 
}
