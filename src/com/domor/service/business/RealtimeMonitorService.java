package com.domor.service.business;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.business.RealtimeMonitorDao;
import com.domor.model.TreeNode;
import com.domor.util.MapUtils;
import com.domor.util.TreeNodeUtils;

@Service("realtimeMonitorService")
public class RealtimeMonitorService {
	
	@Autowired
	private RealtimeMonitorDao realtimeMonitorDao;

	public int count(Map<String, Object> params) {
		return realtimeMonitorDao.count(params);
	}

	public List<Map<String, Object>> query(Map<String, Object> params) {
		return realtimeMonitorDao.query(params);
	}

	public List<Map<String, Object>> queryNewChart(Map<String, Object> params) {
		return realtimeMonitorDao.queryNewChart(params);
	}

	public List<Map<String, Object>> queryPond(Map<String, Object> params) {
		return realtimeMonitorDao.queryPond(params);
	}

	public List<Map<String, Object>> queryDevice(Map<String, Object> params) {
		return realtimeMonitorDao.queryDevice(params);
	}

	public List<Map<String, Object>> queryLngLat(Map<String, Object> params) {
		return realtimeMonitorDao.queryLngLat(params);
	}

	public List<Map<String, Object>> queryCollector(Map<String, Object> params) {
		return realtimeMonitorDao.queryCollector(params);
	}

	public List<Map<String, Object>> query_PHCurve(Map<String, Object> params) {
		return realtimeMonitorDao.query_PHCurve(params);
	}

	public List<Map<String, Object>> query_TOCurve(Map<String, Object> params) {
		return realtimeMonitorDao.query_TOCurve(params);
	}

	public List<Map<String, Object>> queryDeviceByCode(
			Map<String, Object> params) {
		return realtimeMonitorDao.queryDeviceByCode(params);
	}

	public int countDeviceByCode(Map<String, Object> params) {
		return realtimeMonitorDao.countDeviceByCode(params);
	}

	public List<Map<String, Object>> queryLngLatOnly(Map<String, Object> params) {
		return realtimeMonitorDao.queryLngLatOnly(params);
	}

	public List<Map<String, Object>> queryLngLatByUsername(
			Map<String, Object> params) {
		return realtimeMonitorDao.queryLngLatByUsername(params);
	}

	public List<Map<String, Object>> queryDeviceByLntLat(
			Map<String, Object> params) {
		return realtimeMonitorDao.queryDeviceByLntLat(params);
	}

	public int countDeviceByLntLat(Map<String, Object> params) {
		return realtimeMonitorDao.countDeviceByLntLat(params);
	}

	public Object deptTree(String username) {
		List<Map<String, Object>> deptList = realtimeMonitorDao.findDeptsByUser(username);
		Set<String> deptCodeSet = getAllDeptCode(deptList);
		List<Map<String, Object>> mapList = null;
		mapList = realtimeMonitorDao.findDeptsByCode(deptCodeSet.toArray(new String[deptCodeSet.size()]));
		List<Map<String, Object>> mapPondList=realtimeMonitorDao.findPondsByUser(username);
		mapList.addAll(mapPondList);
		List<TreeNode> treeNodes = convertToTreeNode(mapList);
		return TreeNodeUtils.getFatherNodes(treeNodes, "");
	}
	
	/**
	 * 获取养殖点列表中的所有养殖点代码及其养殖公司代码
	 */
	private Set<String> getAllDeptCode(List<Map<String, Object>> deptList) {
		Set<String> deptCodeSet = new HashSet<String>();
		for (Map<String, Object> dept : deptList) {
			String deptCode = MapUtils.getStringValue(dept, "code");
			deptCodeSet.add(deptCode);
			int subLength = 2;
			while (deptCode.length() - subLength >= 1) {
				deptCodeSet.add(deptCode.substring(0, deptCode.length() - subLength));
				subLength += 2;
			}
		}
		return deptCodeSet;
	}
	
	/**
	 * 将池塘转成TreeNode
	 */
	private List<TreeNode> convertToTreeNode(List<Map<String, Object>> mapList) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		if (mapList == null) {
			return treeNodes;
		}
		for (Map<String, Object> map : mapList) {
			if(((String) map.get("code")).length()<7){
			TreeNode treeNode = new TreeNode(MapUtils.getStringValue(map, "code"),
					MapUtils.getStringValue(map, "name"),
					MapUtils.getStringValue(map, "pcode"));
			treeNodes.add(treeNode);
			}else{
				TreeNode treeNode = new TreeNode(MapUtils.getStringValue(map, "code"),
						MapUtils.getStringValue(map, "name"),
						MapUtils.getStringValue(map, "deptCode"));
				treeNodes.add(treeNode);	
			}
		}
		return treeNodes;
	}

	public List<Map<String, Object>> queryDeviceByPond(
			Map<String, Object> params) {
		return realtimeMonitorDao.queryDeviceByPond(params);
	}

}
