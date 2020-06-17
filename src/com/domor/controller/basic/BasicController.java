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
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.model.PagerReturns;
import com.domor.model.Role;
import com.domor.service.BasicService;
import com.domor.service.basic.RoleService;
import com.domor.util.AuthFilter;

@Controller
@RequestMapping("basic")
public class BasicController {

	@Autowired
	private BasicService basicService;

	@Autowired
	private RoleService roleService;

	@AuthFilter
	@RequestMapping("/role")
	public String role() {
		return "/webpages/basic/role";
	}

	@AuthFilter
	@RequestMapping("/getRoleList")
	@ResponseBody
	public Object getRoleList(int hasBlank) {
		List<Map<Object, Object>> reuslt = basicService.getRoleList(0);
		if (hasBlank == 1) {
			Map<Object, Object> blankOption = new HashMap<Object, Object>();
			blankOption.put("roleId", "");
			blankOption.put("roleName", "-选择角色-");
			reuslt.add(0, blankOption);
		}
		return reuslt;
	}

	@AuthFilter
	@ResponseBody
	@RequestMapping("/getPagedRoleList")
	public Object getPagedRoleList(HttpServletRequest request) {
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.parseInt(request.getParameter("rows"));
		int currPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int skipCount = (currPage - 1) * pageSize;
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("rows", pageSize);
		paramsMap.put("skipCount", skipCount);
		Integer count = basicService.getRoleListCount();
		List<Map<Object, Object>> reuslt = basicService.getPagedRoleList(paramsMap);
		PagerReturns pager = new PagerReturns();
		pager.setTotal(count);
		pager.setRows(reuslt);
		return pager;
	}

	@AuthFilter
	@RequestMapping("/right")
	public String right() {
		return "/webpages/basic/role/right";
	}

	@AuthFilter
	@ResponseBody
	@RequestMapping("/role_add")
	@SuppressWarnings("unchecked")
	public Object role_add(HttpServletRequest request, Role role) {
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		role.setCreator(String.valueOf(user.get("username")));
		role.setCreateTime(new Date());
		return basicService.role_add(role);
	}

	@AuthFilter
	@RequestMapping("/role_edit")
	public String role_edit(Model model, Integer roleId) {
		Role role = roleService.findById(roleId);
		model.addAttribute("role", role);
		return "/webpages/basic/role/role_edit";
	}

	@AuthFilter
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/role_edit_save")
	public Object role_edit_save(HttpServletRequest request, Role role) {
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		role.setEditor(String.valueOf(user.get("username")));
		role.setEditTime(new Date());
		role.setDelete_flag(role.getDelete_flag());
		return basicService.role_edit_save(role);
	}

	@AuthFilter
	@RequestMapping("/role_del")
	@ResponseBody
	public Object role_del(Integer roleId) {
		return basicService.role_del(roleId);
	}

	@AuthFilter
	@RequestMapping("/isExistRole")
	@ResponseBody
	public Object isExistRole(String roleName) {
		List<Map<Object, Object>> roles = basicService.getRole(roleName);
		return roles.size() > 0;
	}

	@AuthFilter
	@ResponseBody
	@RequestMapping("/getMenusByRoleId")
	public Object getMenusByRoleId(Integer roleId) {
		return basicService.buildTree(roleId);
	}

//	@AuthFilter
//	@ResponseBody
//	@RequestMapping("/updateRoleRight")
//	public Object updateRoleRight(Integer roleId, String menuIds) {
//		String msg = "ok";
//		try {
//			Role role = basicService.getRole(roleId);
//			if (role == null) {
//				throw new Exception("Role does not exist");
//			}
//			basicService.updateRoleRight(roleId, menuIds);
//		} catch (Exception e) {
//			msg = "error";
//		}
//		return msg;
//	}

	@AuthFilter
	@RequestMapping("/getArea")
	@ResponseBody
	public Object getArea(int parentid) {
		List<Map<Object, Object>> area = basicService.getArea(parentid);
		return area;
	}

	@AuthFilter
	@RequestMapping("/getCommunity")
	@ResponseBody
	public Object getCommunity(int regionCode) {
		List<Map<Object, Object>> community = basicService.getCommunity(regionCode);
		return community;
	}
}
