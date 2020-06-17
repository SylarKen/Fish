package com.domor.controller.basic;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.service.basic.RoleService;

@Controller
@RequestMapping("role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;

	@ResponseBody
	@RequestMapping("/dataForCombo")
	public Object dataForCombo(HttpServletRequest request) {
		return roleService.dataForCombo();
	}
}
