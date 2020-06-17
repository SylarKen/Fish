package com.domor.service.business;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.WarnConfDao;
import com.domor.dao.business.MapInfoDao;
import com.domor.model.TreeNode;
import com.domor.util.MapUtils;
import com.domor.util.TreeNodeUtils;
import com.github.pagehelper.PageHelper;

@Service("mapInfoService")
public class MapInfoService {

	@Autowired
	private MapInfoDao mapInfoDao;
	
	@Autowired
	private WarnConfDao warnConfDao;
	
	/**
	 * 根据用户登录名获取用户所管辖的养殖点
	 */
	public List<Map<String, Object>> deptList(String username, boolean isWarn) {
		List<Map<String, Object>> list = mapInfoDao.findDeptsByUser(username);
		if (isWarn) {
			for (Map<String, Object> map : list) {
				String code = MapUtils.getStringValue(map, "code");
				map.put("icon", getDeptIcon(code));
			}
		}
		return list;
	}
	
	/**
	 * 养殖点树
	 */
	public List<TreeNode> deptTree(String username) {
		/*
		 * 目前只是根据用户登录名获取相关联的池塘，然后找寻池塘所属养殖点；
		 * 如果用户是其它角色，养殖点的获取机制可能不一样。
		 */
		List<Map<String, Object>> deptList = mapInfoDao.findDeptsByUser(username);
		Set<String> deptCodeSet = getAllDeptCode(deptList);
		List<Map<String, Object>> mapList = null;
		mapList = mapInfoDao.findDeptsByCode(deptCodeSet.toArray(new String[deptCodeSet.size()]));
		List<TreeNode> treeNodes = convertToTreeNode(mapList);
		return TreeNodeUtils.getFatherNodes(treeNodes, "");
	}
	
	/**
	 * 根据养殖点编码获取采集器数据信息，并拼接成百度地图信息窗体内容（字符串），以键值对的方式返回（key = content）
	 */
	public String infoWindowContent(String code) {
		//1. 根据养殖点编码获取养殖点下的所有采集器Id
		List<String> collectorIds = mapInfoDao.findCollecotrIdsByPoint(code);
		List<Map<String, Object>> records = mapInfoDao.findLastRecords(code);
		
		List<Map<String, Object>> infos = tidy(collectorIds, records);
		
		String content = generateContent(infos);
		return content;
	}
	
	/**
	 * 获取报警记录
	 */
	public List<Map<String, Object>> queryWarn(Map<String, Object> params) {
		// 页码
	    int pageNum = MapUtils.getIntValue(params, "page");
	    // 一页内显示的最大记录数
	    int pageSize = MapUtils.getIntValue(params, "rows");
	    // 设置分页，会在紧临的下一条查询语句中使用分页
	    PageHelper.startPage(pageNum, pageSize);
//	    return mapInfoDao.queryWarn(params);
	    String code = MapUtils.getStringValue(params, "pointCode");
	    return warnConfDao.getWarnInfo(code);
	}
	
	private String generateContent(List<Map<String, Object>> infos) {
		StringBuffer sb = new StringBuffer();
		if (infos != null && infos.size() > 0) {
			sb.append("<table style='width:500px;'>");
			
			// 表头
			sb.append("<tr style='height:25px;'><th style='width:100px;'>采集器编号</th><th style='width:100px;'>采集器名称</th><th style='width:100px;'>采集器状态</th><th style='width:120px;'>采集时间</th><th></th></tr>");
			
			for (Map<String, Object> info : infos) {
				sb.append("<tr style='height:25px;'>");
				sb.append("<td>").append(MapUtils.getStringValue(info, "collectorCode")).append("</td>");//采集器编号
				sb.append("<td>").append(MapUtils.getStringValue(info, "collectorName")).append("</td>");//采集器名称
				if (MapUtils.getIntValue(info, "dataType") == 4) {
					sb.append("<td>").append("异常").append("</td>");//采集器状态
				} else {
					sb.append("<td>").append("正常").append("</td>");//采集器状态
				}
				sb.append("<td>").append(MapUtils.getStringValue(info, "time")).append("</td>");//采集时间
				// TODO 详情
//				sb.append("<td>").append("<a href='#'>详情</a>").append("</td>");//详情
				sb.append("<td>").append("").append("</td>");//详情
				sb.append("</tr>");
			}
			sb.append("</table>");
		}
		return sb.toString();
	}

	private List<Map<String, Object>> tidy(List<String> ids,
			List<Map<String, Object>> records) {
		List<String> removeIds = new ArrayList<String>();
		List<Map<String, Object>> infos = new ArrayList<Map<String, Object>>();
		//获取告警记录
		for (String id : ids) {
			for (Map<String, Object> record : records) {
				if (id.equals(MapUtils.getStringValue(record, "collectorID"))
						&& MapUtils.getIntValue(record, "dataType") == 4) {//如果是告警记录
					infos.add(record);
					removeIds.add(MapUtils.getStringValue(record, "collectorID"));
				}
			}
		}
		//去除告警采集器ID
		ids.removeAll(removeIds);
		//随意加一条记录
		for (String id : ids) {
			for (Map<String, Object> record : records) {
				if (id.equals(MapUtils.getStringValue(record, "collectorID"))) {
					infos.add(record);
					break;
				}
			}
		}
		return infos;
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
	 * 将养殖点转成TreeNode
	 */
	private List<TreeNode> convertToTreeNode(List<Map<String, Object>> mapList) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		if (mapList == null) {
			return treeNodes;
		}
		for (Map<String, Object> map : mapList) {
			TreeNode treeNode = new TreeNode(MapUtils.getStringValue(map, "code"),
					MapUtils.getStringValue(map, "name"),
					MapUtils.getStringValue(map, "pcode"));
			treeNodes.add(treeNode);
		}
		return treeNodes;
	}
	
	/**
	 * 获取养殖点状态（1：正常；2：告警）
	 */
	private String getDeptIcon(String code) {
//		List<Map<String, Object>> list = mapInfoDao.getDeviceInfosByDeptCode(code);
//		String result = "image/bmap/icon-green.png";
//		for (Map<String, Object> map : list) {
//			int dataType = MapUtils.getIntValue(map, "dataType");
//			if (dataType == 4) {
//				result = "image/bmap/icon-red.png";
//				break;
//			}
//			if (dataType == 1) {
//				double oxygen = MapUtils.getDoubleValue(map, "oxygen");
//				double maxValue = MapUtils.getDoubleValue(map, "maxValue");
//				double minValue = MapUtils.getDoubleValue(map, "minValue");
//				if (oxygen < minValue || oxygen > maxValue) {
//					result = "image/bmap/icon-red.png";
//					break;
//				}
//			}
//		}
		Map<String, Object> icons = new HashMap<String, Object>();
		icons.put("green", "image/bmap/icon-green.png");
		icons.put("blue", "image/bmap/icon-blue.png");
		icons.put("orange", "image/bmap/icon-orange.png");
		icons.put("yellow", "image/bmap/icon-yellow.png");
		icons.put("red", "image/bmap/icon-red.png");
		
		List<Map<String, Object>> warnInfos = warnConfDao.getWarnInfo(code);
		String color = "green";
		for (Map<String, Object> map : warnInfos) {
			int blueMin = MapUtils.getIntValue(map, "blueMin");
			int blueMax = MapUtils.getIntValue(map, "blueMax");
			int orangeMin = MapUtils.getIntValue(map, "orangeMin");
			int orangeMax = MapUtils.getIntValue(map, "orangeMax");
			int yellowMin = MapUtils.getIntValue(map, "yellowMin");
			int yellowMax = MapUtils.getIntValue(map, "yellowMax");
			int redMin = MapUtils.getIntValue(map, "redMin");
			int redMax = MapUtils.getIntValue(map, "redMax");
			int num = MapUtils.getIntValue(map, "num");
			if (num >= blueMin && num < blueMax && getColorOrder(color) < getColorOrder("blue")) {
				color = "blue";
			}
			if (num >= orangeMin && num < orangeMax && getColorOrder(color) < getColorOrder("orange")) {
				color = "orange";
			}
			if (num >= yellowMin && num < yellowMax && getColorOrder(color) < getColorOrder("yellow")) {
				color = "yellow";
			}
			if (num >= redMin && num < redMax && getColorOrder(color) < getColorOrder("red")) {
				color = "red";
			}
			if ("red".equals(color)) {
				break;
			}
		}
		
		return MapUtils.getStringValue(icons, color);
	}
	
	private int getColorOrder(String color) {
		int order = 0;
		switch (color) {
		case "blue":
			order = 1;
			break;
		case "orange":
			order = 2;
			break;
		case "yellow":
			order = 3;
			break;
		case "red":
			order = 4;
			break;
		default:
			break;
		}
		return order;
	}
	
//	public static void main(String[] args) {
//		List<Map<String, Object>> deptList = new ArrayList<Map<String, Object>>();
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("code", "00101");
//		deptList.add(map);
//		Map<String, Object> map2 = new HashMap<String, Object>();
//		map2.put("code", "00201");
//		deptList.add(map2);
//		
//		MapInfoService service = new MapInfoService();
//		System.out.println(JSON.toJSONString(service.getAllDeptCode(deptList)));
//	}
}
