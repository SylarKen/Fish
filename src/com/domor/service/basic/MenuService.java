package com.domor.service.basic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.domor.dao.basic.MenuDao;
import com.domor.model.Menu;
import com.domor.model.TreeNode;
import com.domor.util.ObjectUtils;
import com.domor.util.TreeNodeUtils;

@Service("menuService")
public class MenuService {

	@Autowired
	private MenuDao menuDao;
	
	@Transactional
	public int insert(Menu menu) {
		//插入后，更新父节点的isLeaf=0
		Integer parentId = menu.getParentId();
		if(parentId !=null && parentId > 0) {
			menuDao.setLeaf(0, parentId);
		}
		return menuDao.insert(menu);
	}
	
	@Transactional
	public int update(Menu menu) {
		int rtn = menuDao.update(menu);
		if(rtn > 0){
			//此时要更新该节点的是否叶子（因为有时又脏数据，点击保存直接自动纠正）
			setIsLeaf(menu.getMenuId());
			//如果换了父亲，要更新新旧父亲的isLeaf
			if(!menu.getParentId().equals(menu.getOldParentId())){
				setIsLeaf(menu.getParentId());
				setIsLeaf(menu.getOldParentId());
			}
		}
		return rtn;
	}
	
	//重置节点的isLeaf字段,返回是否叶子
	public int setIsLeaf(Integer id) {
		if(id == null){
			return -1;
		}
		Map<String, Object> paramsQ = new HashMap<String, Object>();
		paramsQ.put("parentId", id);
		int count = menuDao.count(paramsQ);
		if(count > 0 ) {
			menuDao.setLeaf(0, id);
			return 1;
		} else {
			menuDao.setLeaf(1, id);
			return 0;
		}
	}
	
	@Transactional
	public int delete(int menuId) {
		Menu menuSelf = menuDao.findById(menuId);
		int parentId = menuSelf.getParentId();
		if(parentId > 0) {
			Map<String, Object> paramsQ = new HashMap<String, Object>();
			paramsQ.put("parentId", parentId);
			int count = menuDao.count(paramsQ);
			if(count == 1 ) {//此时还没有删除self，如果此时父节点只有self一个，那么就要更新父节点的isLeaf=1
				menuDao.setLeaf(1,parentId);
			} 
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delete_flag", 0);
		List<Menu> menus = query(params);
		List<Menu> children = getChildrenMenus(menuId, menus);
		List<Integer> menuIds = new ArrayList<Integer>();
		menuIds.add(menuId);
		for(Menu menu : children) {
			menuIds.add(menu.getMenuId());
		}
		menuDao.deleteRightsBatch(menuIds);
		return menuDao.deleteBatch(menuIds);
	}
	
	public Menu findById(int menuId) {
		return menuDao.findById(menuId);
	}
	
	public List<Menu> query(Map<String, Object> params) {
		if(ObjectUtils.isNull(params)) {
			params = new HashMap<String, Object>();
		}
		return menuDao.query(params);
	}
	
	/**
	 * 构建 TreeGrid 所需要数据格式
	 * @param params 查询参数
	 * @return TreeGrid data
	 */
	public List<Menu> buildTreeGrid(Map<String, Object> params) {
		return getFatherMenus(query(params));
	}
	
	/**
	 * 构建 Tree 所需要数据格式
	 * @param menuType 菜单类型
	 * @param roleId 角色 ID
	 * @return Tree data
	 */
	public List<TreeNode> buildTree(int menuType, int roleId) {
		return buildTree(menuType, roleId, 0);
	}
	
	public List<TreeNode> buildTree(int menuType, int roleId, int delete_flag) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(menuType > 0) {
			params.put("menuType", menuType);
		}
		params.put("delete_flag", delete_flag);
		List<Menu> menus = query(params);
		return TreeNodeUtils.getFatherNodes(convert2TreeNodes(menus, roleId));
	}
	
	private List<TreeNode> convert2TreeNodes(List<Menu> menus, int roleId) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		for(Menu menu : menus) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(String.valueOf(menu.getMenuId()));
			treeNode.setParentId(String.valueOf(menu.getParentId()));
			treeNode.setText(menu.getMenuName());
			treeNode.setLevel(menu.getMenuLevel());
			if(roleId > 0) {
				List<Integer> menuIds = menuDao.getMenuIdsByRoleId(roleId);
				if(menuIds.contains(menu.getMenuId()) && menu.getIsLeaf() == 1) {
					treeNode.setChecked(true);
				}
			}
			treeNodes.add(treeNode);
		}
		return treeNodes;
	}
	
	private List<Menu> getFatherMenus(List<Menu> menus) {
		List<Menu> resultMenus = new ArrayList<Menu>();
		for(Menu menu : menus) {
			if(menu.getParentId() == 0) {
				menu.setChildren(getChildrenMenus(menu.getMenuId(), menus));
				//menu.setState("open");
				resultMenus.add(menu);
			}
		}
		return resultMenus;
	}
	
	private List<Menu> getChildrenMenus(int parentId, List<Menu> menus) {
		List<Menu> resultMenus = new ArrayList<Menu>();
		for(Menu menu : menus) {
			if(menu.getParentId() == 0) {
				continue;
			}
			if(parentId == menu.getParentId()) {
				menu.setChildren(getChildrenMenus(menu.getMenuId(), menus));
				resultMenus.add(menu);
			}
		}
		return resultMenus;
	}

	/**
	 * 更新角色权限
	 * @param roleId 角色 ID
	 * @param menuIds 菜单 IDs
	 */
	@Transactional
	public void updateRights(Integer roleId, String menuIds) {
		menuDao.delRightsByRoleId(roleId);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delete_flag", 0);
		params.put("isLeaf", 1);
		params.put("menuIds", str2List(menuIds));
		List<Integer> leafIds = menuDao.queryIds(params);
		menuDao.addRights(roleId, leafIds);
		
		Set<Integer> parentIds = new HashSet<Integer>();
		queryParentIds(parentIds, leafIds);
		if(ObjectUtils.notEmpty(parentIds)) {
			menuDao.addRights(roleId, parentIds);
		}
	}
	
	private void queryParentIds(Set<Integer> parentIds, List<Integer> menuIds) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delete_flag", 0);
		params.put("menuIds", menuIds);
		
		for(int i = 0; i < 10; i++) {
			List<Integer> subParentIds = menuDao.queryParentIds(params);
			if(ObjectUtils.notEmpty(subParentIds)) {
				parentIds.addAll(subParentIds);
				params.put("menuIds", subParentIds);
			} else {
				break;
			}
		}
	}
	
	private List<Integer> str2List(String str) {
		List<Integer> result = new ArrayList<Integer>();
		for(String s : str.split(",")) {
			result.add(Integer.valueOf(s));
		}
		return result;
	}
}
