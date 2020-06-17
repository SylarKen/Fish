package com.domor.service.basic;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.HistoryDataDao;
import com.domor.dao.production.PondDao;
import com.domor.model.TreeNode;
import com.domor.util.Constant;
import com.domor.util.MapUtils;
import com.domor.util.TreeNodeUtils;
@Service("historyDataService")
public class HistoryDataService {

	@Autowired
	private  HistoryDataDao dao;	
	
	/**
	 * 传感器列表
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryDeviceByPond(
			Map<String, Object> params) {
		return dao.queryDeviceByPond(params);
	}
	
	public Object deptTree(String username) {
		List<Map<String, Object>> deptList = dao.findDeptsByUser(username);
		Set<String> deptCodeSet = getAllDeptCode(deptList);
		List<Map<String, Object>> mapList = null;
		mapList = dao.findDeptsByCode(deptCodeSet.toArray(new String[deptCodeSet.size()]));
		List<Map<String, Object>> mapPondList=dao.findPondsByUser(username);
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
	
	
	
	public Map<String, Object> querySensorID(Map<String, Object> params) {
		return dao.querySensorID(params);
	}
	
	
	
	
	//计算分页数量	
	public int count(Map<String, Object> params) {
		Integer result = dao.count(params);
		return result;
	}
		
		//分页展示
	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}	
		//分页展示
	public List<Map<String,Object>> queryAll(Map<String, Object> params) {
		return dao.queryAll(params);
	}	
	public List<Map<String,Object>> queryAllForCurve(Map<String, Object> params) {
		return dao.queryAllForCurve(params);
	}	
	
	/**
	 * 导出符合条件的会员信息，不分页
	 */
	public HSSFWorkbook export(Map<String, Object> params) {
		List<Map<String, Object>> exportData = new ArrayList<Map<String, Object>>();
		Map<String, Object> head = head(params);
		exportData.add(head);
		List<Map<String, Object>> members = queryAll(params);
		exportData.addAll(members);
		HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("历史数据信息");
        for(int i = 0; i < exportData.size(); i++) {
        	HSSFRow row = sheet.createRow(i);
        	int j = 0;
        	for (String key : head.keySet()) {
        		HSSFCell cell = row.createCell(j);
        		String value = MapUtils.getStringValue(exportData.get(i), key);
        		if (i == 0) {
        			HSSFCellStyle cellstyle = (HSSFCellStyle) wb.createCellStyle();// 设置表头样式  
        			cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 设置居中 
        			HSSFFont headerFont = (HSSFFont) wb.createFont(); //创建字体样式 
        			headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); // 字体加粗 
            		cellstyle.setFont(headerFont);    //为标题样式设置字体样式  
            		cell.setCellStyle(cellstyle);
            		cell.setCellValue(value);
            	} else {
            		cell.setCellValue(value);
            	}
        		j++;
    		}
        }
        
        // 设置单元格宽度
        int index = 0;
        for (String key : head.keySet()) {
        	sheet.setColumnWidth(index, MapUtils.getStringValue(head, key).getBytes().length * 2 * 256);
        	index++;
        }
        
        return wb;
	}
	
	/**
	 * Excel 文档首行
	 */
	private Map<String, Object> head(Map<String, Object> params) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("sensorID", "传感器编码");
		map.put("deviceName", "传感器名称");
		if(Constant.LXBH_CGQ_RYWD.equals(params.get("dataKind").toString())){
			map.put("oxygen", "溶氧度mg/L");
			map.put("temperature", "温度℃");
		}else if(Constant.LXBH_CGQ_PH.equals(params.get("dataKind").toString())){
			map.put("PH", "PH值");
		}
		map.put("time", "采集时间");
		return map;
	}
}
