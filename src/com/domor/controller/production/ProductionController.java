package com.domor.controller.production;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.service.production.ProductionService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("production")
public class ProductionController {	

	@Autowired
	private ProductionService productionService;

	@AuthFilter
	@ResponseBody
	@RequestMapping("/getUserPondTree")
	public Object getUserPondTree(HttpServletRequest request) {
		return productionService.getTreeNodeList(request);
	}
	
	@AuthFilter
	@RequestMapping("/pondTreeDialog")
	public String pondTreeDialog(HttpServletRequest request, Model m) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		m.addAttribute("checkedPonds", MapUtils.getStringValue(params, "checkedPonds"));
		m.addAttribute("isSingleCheck", MapUtils.getIntValue(params, "isSingleCheck"));
		m.addAttribute("deptCode", MapUtils.getStringValue(params, "deptCode"));
		return "/webpages/production/dialog/pond_tree_dialog";
	}
}
