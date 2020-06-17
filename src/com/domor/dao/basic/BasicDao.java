package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.Menu;
import com.domor.model.Role;
import com.domor.model.SearchDomain;
import com.domor.model.User;

public interface BasicDao {
	// 获取用户列表
	Integer getUsers_total(SearchDomain params);

	List<Map<Object, Object>> getUsers(SearchDomain params);

	Integer user_add_save(User user);

	List<Map<Object, Object>> getUser(String username);

	Integer user_edit_save(User user);

	Integer user_del(String username);

	List<Map<Object, Object>> getAreaListForComb(String fatherId);

	// 添加角色
	Integer role_add(Role role);

	// 编辑角色
	Integer role_edit_save(Role role);

	// 删除角色
	Integer role_del(Integer roleId);

	// 根据角色ID获取角色
	Role getRoleById(Integer roleId);

	// 根据角色名称获取角色
	List<Map<Object, Object>> getRole(String roleName);

	Menu getMenu(Integer menuId);

	List<Map<Object, Object>> getAllMenus();

	List<Integer> getMenuIdsByRoleId(Integer roleId);

	// 根据角色ID删除权限
	Integer delRightByRoleId(Integer roleId);

	// 判断角色是否有权限
	Integer isExistRight(Integer roleId, Integer menuId);

	// 添加权限
	Integer addRight(Integer roleId, Integer menuId);

	/**
	 * 检验菜单是否有子菜单
	 * @param menuId 需要判断的菜单ID
	 * @return 是否有子菜单
	 */
	boolean hasChildren(Integer menuId);

	// 获取科室列表
	List<Map<Object, Object>> getDeptList(Integer delete_flag);

	// 获取角色列表
	List<Map<Object, Object>> getRoleList(Integer delete_flag);

	List<Map<Object, Object>> getNationList();

	List<Map<Object, Object>> getIndustryList();

	List<Map<Object, Object>> getUnitTypeList();

	List<Map<Object, Object>> getStockList(int companyId);

	List<Map<Object, Object>> getCustomerList();

	List<Map<Object, Object>> getKnifeTypeList();

	List<Map<Object, Object>> getLineTypeList();

	List<Map<Object, Object>> getPackageList();

	List<Map<Object, Object>> getPromotionTypeNameList();

	Integer getRoleListCount();

	List<Map<Object, Object>> getPagedRoleList(Map<String, Object> paramsMap);

	List<Map<Object, Object>> getArea(int parentid);

	List<Map<Object, Object>> getCommunity(int regionCode);

}