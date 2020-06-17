package com.domor.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.domor.dao.basic.BasicDao;
import com.domor.model.Menu;
import com.domor.model.Role;
import com.domor.model.SearchDomain;
import com.domor.model.User;

@Service("basicService")
public class BasicService {

	@Autowired
	private BasicDao basicDao;

	public Integer getUsers_total(SearchDomain params) {
		return basicDao.getUsers_total(params);
	}

	public List<Map<Object, Object>> getUsers(SearchDomain params) {
		return basicDao.getUsers(params);
	}

	public Integer user_add_save(User user) {
		return basicDao.user_add_save(user);
	}

	public List<Map<Object, Object>> getUser(String username) {
		return basicDao.getUser(username);
	}

	public Integer user_edit_save(User user) {
		return basicDao.user_edit_save(user);
	}

	public Integer user_del(String username) {
		return basicDao.user_del(username);
	}

	public List<Map<Object, Object>> getDeptList(Integer delete_flag) {
		return basicDao.getDeptList(delete_flag);
	}

	public List<Map<Object, Object>> getRoleList(Integer delete_flag) {
		return basicDao.getRoleList(delete_flag);
	}

	public List<Map<Object, Object>> getNationList() {
		return basicDao.getNationList();
	}

	public List<Map<Object, Object>> getIndustryList() {
		return basicDao.getIndustryList();
	}

	public List<Map<Object, Object>> getUnitTypeList() {
		return basicDao.getUnitTypeList();
	}

	public List<Map<Object, Object>> getStockList(int companyId) {
		return basicDao.getStockList(companyId);
	}

	public Integer role_add(Role role) {
		return basicDao.role_add(role);
	}

	public Integer role_edit_save(Role role) {
		return basicDao.role_edit_save(role);
	}

	public Integer role_del(Integer roleId) {
		return basicDao.role_del(roleId);
	}

	public Role getRole(Integer roleId) {
		return basicDao.getRoleById(roleId);
	}

	public List<Map<Object, Object>> getRole(String roleName) {
		return basicDao.getRole(roleName);
	}

	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> buildTree(Integer roleId) {
		// 获取所有可用菜单
		List<Map<Object, Object>> allMenus = basicDao.getAllMenus();
		// 角色已有权限
		List<Integer> menuIds = basicDao.getMenuIdsByRoleId(roleId);
		// System.out.println("menuIds: " + JSON.toJSONString(menuIds));

		List<Map<Object, Object>> rootNodes = new ArrayList<Map<Object, Object>>();
		for (Map<Object, Object> menu : allMenus) {
			Integer menuLevel = (Integer) menu.get("menuLevel");
			Integer menuType = (Integer) menu.get("menuType");
			if (menuLevel.equals(1) && menuType.equals(1)) {
				rootNodes.add(menu2treeNode(menu, menuIds));
			}
		}

		// System.out.println("rootNodes: " + JSON.toJSONString(rootNodes));

		for (Map<Object, Object> rootNode : rootNodes) {
			Integer rootNodeId = (Integer) rootNode.get("id");
			List<Map<Object, Object>> secondNodes = new ArrayList<Map<Object, Object>>();
			for (Map<Object, Object> menu : allMenus) {
				Integer menuLevel = (Integer) menu.get("menuLevel");
				Integer menuType = (Integer) menu.get("menuType");
				if (menuLevel.equals(2) && menuType.equals(1)) {
					Integer parentId = (Integer) menu.get("parentId");
					if (parentId.equals(rootNodeId)) {
						secondNodes.add(menu2treeNode(menu, menuIds));
					}
				}
			}
			// System.out.println("rootNodes: " +
			// JSON.toJSONString(secondNodes));
			rootNode.put("children", secondNodes);
		}

		for (Map<Object, Object> rootNode : rootNodes) {
			List<Map<Object, Object>> secondNodes = null;
			if (rootNode.get("children") != null) {
				secondNodes = (List<Map<Object, Object>>) rootNode.get("children");
			} else {
				continue;
			}
			for (Map<Object, Object> secondNode : secondNodes) {
				int secondNodeId = (Integer) secondNode.get("id");
				List<Map<Object, Object>> thirdNodes = new ArrayList<Map<Object, Object>>();
				for (Map<Object, Object> menu : allMenus) {
					Integer menuLevel = (Integer) menu.get("menuLevel");
					Integer menuType = (Integer) menu.get("menuType");
					if (menuLevel.equals(3) && menuType.equals(1)) {
						Integer parentId = (Integer) menu.get("parentId");
						// System.out.println("parentId: " + parentId +
						// ", secondNodeId: " + secondNodeId +
						// ", parentId equals secondNodeId:" +
						// (parentId.equals(secondNodeId)));
						if (parentId.equals(secondNodeId)) {
							thirdNodes.add(menu2treeNode(menu, menuIds));
						}
					}
				}
				secondNode.put("children", thirdNodes);
				if (thirdNodes.size() > 0) {
					secondNode.put("state", "closed");
				}
			}
		}

		// level 4
		for (Map<Object, Object> rootNode : rootNodes) {
			// level 2
			List<Map<Object, Object>> secondNodes = null;
			if (rootNode.get("children") != null) {
				secondNodes = (List<Map<Object, Object>>) rootNode.get("children");
			} else {
				continue;
			}
			// level 3
			List<Map<Object, Object>> thirdNodes = null;
			for (Map<Object, Object> secondNode : secondNodes) {
				if (secondNode.get("children") != null) {
					thirdNodes = (List<Map<Object, Object>>) secondNode.get("children");
					for (Map<Object, Object> thirdNode : thirdNodes) {
						// System.out.println("third node name: " +
						// thirdNode.get("text"));
						Integer thirdNodeId = (Integer) thirdNode.get("id");
						List<Map<Object, Object>> forthNodes = new ArrayList<Map<Object, Object>>();
						for (Map<Object, Object> menu : allMenus) {
							Integer menuLevel = (Integer) menu.get("menuLevel");
							Integer menuType = (Integer) menu.get("menuType");

							if (menuLevel.equals(4) && menuType.equals(2)) {
								// System.out.println("forth node name :" +
								// menu.get("menuName"));
								Integer parentId = (Integer) menu.get("parentId");
								if (parentId.equals(thirdNodeId)) {
									forthNodes.add(menu2treeNode(menu, menuIds));
								}
							}
						}
						thirdNode.put("children", forthNodes);
						if (forthNodes.size() > 0) {
							thirdNode.put("state", "closed");
						}
					}
				} else {
					continue;
				}
			}
		}

		// System.out.println(JSON.toJSONString(rootNodes));

		return rootNodes;
	}

	@Transactional
	public void updateRoleRight(Integer roleId, String menuIds) {
		// 删除角色原有权限
		basicDao.delRightByRoleId(roleId);

		String[] ids = menuIds.split(",");
		for (String idStr : ids) {
			Integer menuId = Integer.parseInt(idStr);
			Menu menu = basicDao.getMenu(menuId);
			if (menu.getMenuLevel() == 4) {
				basicDao.addRight(roleId, menuId);
				// 三级菜单已经存在
				if (basicDao.isExistRight(roleId, menu.getParentId()) > 0) {
					continue;
				} else { // 三级菜单不存在
					basicDao.addRight(roleId, menu.getParentId());
					// 三级菜单
					Menu thirdMenu = basicDao.getMenu(menu.getParentId());
					// 二级菜单已存在
					if (basicDao.isExistRight(roleId, thirdMenu.getParentId()) > 0) {
						continue;
					} else {// 二级菜单不存在
						basicDao.addRight(roleId, thirdMenu.getParentId());
						// 二级菜单菜单
						Menu secondMenu = basicDao.getMenu(thirdMenu.getParentId());
						// 根菜单已存在
						if (basicDao.isExistRight(roleId, secondMenu.getParentId()) > 0) {
							continue;
						} else { // 根菜单不存在
							basicDao.addRight(roleId, secondMenu.getParentId());
						}
					}
				}
			}
			if (menu.getMenuLevel() == 3) {
				basicDao.addRight(roleId, menuId);
				// 二级菜单已经存在
				if (basicDao.isExistRight(roleId, menu.getParentId()) > 0) {
					continue;
				} else {
					basicDao.addRight(roleId, menu.getParentId());
					Menu secondMenu = basicDao.getMenu(menu.getParentId());
					// 根菜单已经存在
					if (basicDao.isExistRight(roleId, secondMenu.getParentId()) > 0) {
						continue;
					} else {
						basicDao.addRight(roleId, secondMenu.getParentId());
					}
				}
			}
			if (menu.getMenuLevel() == 2) {
				if (basicDao.isExistRight(roleId, menu.getMenuId()) > 0) {
					continue;
				} else {
					basicDao.addRight(roleId, menu.getMenuId());
				}
				if (basicDao.isExistRight(roleId, menu.getParentId()) > 0) {
					continue;
				} else {
					basicDao.addRight(roleId, menu.getParentId());
				}
			}
			if (menu.getMenuLevel() == 1) {
				if (basicDao.isExistRight(roleId, menu.getMenuId()) > 0) {
					continue;
				} else {
					basicDao.addRight(roleId, menu.getMenuId());
				}
			}
		}
	}

	/**
	 * 
	 * @param menu
	 * @param menuIds 角色对应的权限
	 * @return
	 */
	private Map<Object, Object> menu2treeNode(Map<Object, Object> menu, List<Integer> menuIds) {
		Map<Object, Object> treeNode = new HashMap<Object, Object>();
		treeNode.put("id", menu.get("menuId"));
		treeNode.put("text", menu.get("menuName"));

		if ((Integer) menu.get("menuLevel") == 2 && menuIds.contains((Integer) menu.get("menuId"))) {
			// 如果没有子菜单，设置checked为true
			if (!basicDao.hasChildren((Integer) menu.get("menuId"))) {
				treeNode.put("checked", true);
			}
		}

		if ((Integer) menu.get("menuLevel") == 3 && menuIds.contains((Integer) menu.get("menuId"))) {
			if (!basicDao.hasChildren((Integer) menu.get("menuId"))) {
				treeNode.put("checked", true);
			}
		}
		if ((Integer) menu.get("menuLevel") == 4) {
			if (menuIds.contains((Integer) menu.get("menuId"))) {
				treeNode.put("checked", true);
			}
		}
		return treeNode;
	}

	public Integer getRoleListCount() {
		return basicDao.getRoleListCount();
	}

	public List<Map<Object, Object>> getPagedRoleList(Map<String, Object> paramsMap) {
		return basicDao.getPagedRoleList(paramsMap);
	}

	public List<Map<Object, Object>> getArea(int parentid) {
		return basicDao.getArea(parentid);
	}

	public List<Map<Object, Object>> getCommunity(int regionCode) {
		return basicDao.getCommunity(regionCode);
	}

}
