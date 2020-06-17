package com.domor.controller.basic;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.service.basic.AreaService;

@Controller
@RequestMapping("area")
public class AreaController {
	
	@Autowired
	private AreaService service;
	
	@RequestMapping(value = "/selectAreaDialog", method = RequestMethod.GET)
	public String selectAreaDialog(Model model,String selectValue) {
		model.addAttribute("selectValue", selectValue);
		return "/webpages/basic/area/select_area_dialog";
	}
	
	@ResponseBody
	@RequestMapping("/select_area_tree")
	public Object select_area_tree(HttpServletRequest request, HttpServletResponse response) {
		return service.buildAllTree("",null);
	}
}
