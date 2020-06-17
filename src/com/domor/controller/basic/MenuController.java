package com.domor.controller.basic;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.domor.model.Menu;
import com.domor.service.basic.MenuService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("menu")
public class MenuController {
	
	private Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public ModelAndView insertGet(HttpServletRequest request) {
		int parentId = ParamUtils.getIntParameter(request, "parentId");
		logger.debug("添加菜单，上级菜单ID为：{}", parentId);
		Menu parent = new Menu();
		if(parentId > 0) {
			parent = menuService.findById(parentId);
		}
		return new ModelAndView("/webpages/basic/menu/menu_add", "parent", parent);
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insertPost(HttpServletRequest request, Menu menu) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		menu.setCreator(MapUtils.getStringValue(user, "username"));
		menu.setCreateTime(new Date());
		return menuService.insert(menu);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public Object updateGet(HttpServletRequest request) {
		int menuId = ParamUtils.getIntParameter(request, "menuId");
		Menu menu = menuService.findById(menuId);
		ModelAndView mv = new ModelAndView("/webpages/basic/menu/menu_edit");
		mv.addObject("menu", menu);
		mv.addObject("parent", menuService.findById(menu.getParentId()));
		return mv;
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Object updatePost(HttpServletRequest request, Menu menu) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		menu.setEditor(MapUtils.getStringValue(user, "username"));
		menu.setEditTime(new Date());
		return menuService.update(menu);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(HttpServletRequest request) {
		int menuId = ParamUtils.getIntParameter(request, "menuId");
		return menuService.delete(menuId);
	}
	
	@AuthFilter
	@RequestMapping("/index")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("/webpages/basic/menu/menu");
	}
	
	@ResponseBody
	@RequestMapping("/query")
	public Object query(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		return menuService.buildTreeGrid(params);
	}
	
	@ResponseBody
	@RequestMapping("/tree")
	public Object tree(HttpServletRequest request) {
		int menuType = ParamUtils.getIntParameter(request, "menuType");
		int roleId = ParamUtils.getIntParameter(request, "roleId");
		int delete_flag = ParamUtils.getIntParameter(request, "delete_flag", 0);
		return menuService.buildTree(menuType, roleId, delete_flag);
	}
	
	@AuthFilter
	@ResponseBody
	@RequestMapping("/updateRights")
	public Object updateRights(Integer roleId, String menuIds) {
		String msg = "ok";
		try {
			menuService.updateRights(roleId, menuIds);
		} catch (Exception e) {
			logger.error("修改角色权限时出现错误，错误信息：{}", e.getMessage());
			msg = "error";
		}
		return msg;
	}
}
