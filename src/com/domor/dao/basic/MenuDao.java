package com.domor.dao.basic;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.domor.model.Menu;

public interface MenuDao {

	int insert(Menu menu);
	
	int update(Menu menu);
	
	int delete(int menuId);
	
	/**
	 * 批量删除菜单（逻辑删除）
	 * @param menuIds 菜单 IDs
	 * @return 影响行数
	 */
	int deleteBatch(List<Integer> menuIds);
	
	Menu findById(int menuId);
	
	Integer count(Map<String, Object> params);
	
	List<Menu> query(Map<String, Object> params);
	
	/**
	 * 批量删除权限（逻辑删除）
	 * @param menuIds 菜单 IDs
	 * @return 影响行数
	 */
	int deleteRightsBatch(List<Integer> menuIds);

	/**
	 * 根据角色 ID 获取菜单 ID
	 * @param roleId 角色 ID
	 * @return 菜单 IDs
	 */
	List<Integer> getMenuIdsByRoleId(int roleId);

	/**
	 * 查询所有符合条件的菜单 ID ，不分页
	 * @param params 查询条件
	 * @return 菜单 IDs
	 */
	List<Integer> queryIds(Map<String, Object> params);
	
	/**
	 * 查询上级菜单 IDs 
	 * @param menuIds 菜单 IDs
	 * @return 上级菜单 IDs ，不包含0
	 */
	List<Integer> queryParentIds(Map<String, Object> params);
	
	/**
	 * 添加权限
	 * @param roleId 角色 ID
	 * @param menuIds 菜单 IDs
	 * @return 影响行数
	 */
	int addRights(int roleId, Collection<Integer> menuIds);

	/**
	 * 根据角色 ID 删除权限
	 * @param roleId 角色 ID
	 */
	void delRightsByRoleId(Integer roleId);

	void setLeaf(int isLeaf, int menuId);
}
