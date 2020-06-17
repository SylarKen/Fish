package com.domor.controller.production;

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

import com.domor.model.PagerReturns;
import com.domor.model.TreeNode;
import com.domor.service.production.PondService;
import com.domor.util.AuthFilter;
import com.domor.util.LogAddFilter;
import com.domor.util.LogEditFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;
import com.domor.util.TreeNodeUtils;

@Controller
@RequestMapping("pond")
public class PondController {

	@Autowired
	private PondService pondService;
	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/production/pond/pond";
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
		List<Map<String, Object>> list  = pondService.getDepts(params);
		//分页查询
		PagerReturns pager = TreeNodeUtils.getTreeDataDept(list, params);
		return pager;
	}
	
	/**
	 * 新增池塘信息跳转页面
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
		}
		return "webpages/production/pond/pond_add";
	}
	
	/**
	 * 保存池塘信息
	 * @param request
	 * @return
	 */
	@AuthFilter
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/add_save", method = RequestMethod.POST)
	public Object add_save(HttpServletRequest request) {
		Map<String,Object> params = ParamUtils.getParameterMap(request);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		params.put("creator", user.get("username").toString());
		DecimalFormat df = new DecimalFormat(".00");
		String area = params.get("area").toString();
		double ar = Double.parseDouble(area);
		params.put("area", df.format(ar));
		//自动增加编码
		Map<String,Object> codeMap = new HashMap<String,Object>();
		codeMap.put("deptCode", params.get("deptCode").toString());
		List<Map<String,Object>> queryCodes = pondService.queryCodes(codeMap);
		String number = null;
		if(null != queryCodes && queryCodes.size()>0){
			List<String> list = new ArrayList<>();
			for (int i = 0; i < queryCodes.size(); i++) {
				list.add(i, queryCodes.get(i).get("code").toString());		
			}
			Collections.sort(list);
			String num1 = list.get(list.size()-1);
			String num2=num1.substring(num1.length()-3,num1.length());
			int num3 = Integer.parseInt(num2)+1;
			String num4 = ""+num3;
			String num5=num4.substring(num4.length()-2,num4.length());
			number = params.get("deptCode").toString()+num5;
		}else{
			number = params.get("deptCode").toString()+"01";
		}
		params.put("code", number);
		
		//添加用户和池塘的关联
		Map<String,Object> codeMap2 = new HashMap<String,Object>();
		codeMap2.put("pondCode", number);
		codeMap2.put("username", user.get("username").toString());
		try {
			pondService.add_save(params);//添加池塘信息
			pondService.add_saveUserPond(codeMap2);//添加池塘 用户信息
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer("添加时发生异常，异常信息");
			sb.append("\n");
			sb.append(e.getMessage());
			resultMap.put("errorMsg", sb.toString());
		}
		return resultMap;
	}
	
	
	/**
	 * 分页查询池塘信息
	 * @param request
	 * @return
	 */
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/getPonds", method = RequestMethod.POST)
	public Object getPonds(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		String value = null;
		try {
			value = new String(request.getParameter("deptCode").getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		params.put("deptCode", value);
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");	
		params.put("username", user.get("username").toString());
		int total = pondService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> users  = pondService.query(params);
		PagerReturns pager = new PagerReturns(users, total);
		return pager;
	}
	
	/**
	 * 跳转编辑页面
	 * @param request
	 * @param m
	 * @return
	 */
	@AuthFilter
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		System.out.println(params.toString());
		List<Map<String,Object>> findByCode = pondService.findByCode(params);
		System.out.println(findByCode.get(0).toString());
		m.addAttribute("bean", findByCode.get(0));
		return "/webpages/production/pond/pond_edit";
	}
	
	/**
	 * 编辑后保存信息
	 * @param request
	 * @return
	 */
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
			params.put("update", user.get("username").toString());
			Integer rtn = pondService.edit(params);
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
	
	/**
	 * 查看池塘具体信息
	 * @param request
	 * @param m
	 * @return
	 */
	@AuthFilter
	@RequestMapping(value = "/detail",method = RequestMethod.GET)
	public String detail(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String,Object>> findByCode = pondService.findByCode(params);
		m.addAttribute("bean", findByCode.get(0));
		return "/webpages/production/pond/pond_detail";
	}
	
	
}
