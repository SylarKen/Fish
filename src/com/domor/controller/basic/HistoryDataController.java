package com.domor.controller.basic;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domor.model.PagerReturns;
import com.domor.model.TreeNode;
import com.domor.service.basic.HistoryDataService;
import com.domor.service.production.PondService;
import com.domor.util.AuthFilter;
import com.domor.util.Constant;
import com.domor.util.DateUtils;
import com.domor.util.LogAddFilter;
import com.domor.util.LogEditFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;
import com.domor.util.TreeNodeUtils;

import org.apache.commons.lang.StringUtils;
@Controller
@RequestMapping("historyData")
public class HistoryDataController {

	@Autowired
	private HistoryDataService historyDataService;
	@AuthFilter
	@RequestMapping("/index")
	public String index() {
		return "/webpages/basic/historyData/historyData";
	}
	
	/**
	 * 传感器列表
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryDeviceByPond")
	public Object queryDeviceByPond(HttpServletRequest request) {
	Map<String, Object> params = ParamUtils.getParameterMap(request);
	List<Map<String, Object>> data  = historyDataService.queryDeviceByPond(params);
	return data;
	}
	
	
	/**
	 * 养殖点树
	 */
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/pondTree")
	public Object pondTree(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
		String username = MapUtils.getStringValue(user, "username");
		return historyDataService.deptTree(username);
	}
	
	

	
	
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/querySensorID")
	public Object querySensorID(HttpServletRequest request) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	    String sensorID = request.getParameter("sensorID");
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("sensorID", sensorID);
	    Map<String, Object> querySensorID = null;
	    try{
	    	 querySensorID = historyDataService.querySensorID(params);
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
	    resultMap.put("dataKind", querySensorID.get("dataKind").toString());
		return resultMap;
	}
	
	
	/**
	 * 分页查询溶氧度温度信息
	 * @param request
	 * @return
	 */
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/oxygenTemperature", method = RequestMethod.POST)
	public Object getOxygenTemperature(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = historyDataService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> oxygen = null;
		try {
			oxygen  = historyDataService.query(params);
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    PagerReturns pager = new PagerReturns(oxygen, total);
		return pager;
	}
	
	/**
	 * 分页查询PH传感器信息
	 * @param request
	 * @return
	 */
	
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/PHSensor", method = RequestMethod.POST)
	public Object getPHSensor(HttpServletRequest request) {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		int total = historyDataService.count(params);
		ParamUtils.addSkipCount(params, total);
		List<Map<String, Object>> oxygen = null;
		try {
			oxygen  = historyDataService.query(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    PagerReturns pager = new PagerReturns(oxygen, total);
		return pager;
	}
	
	//oxygen_line
	
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/oxygen_line", method = RequestMethod.POST)
	public Object getOxygenTemperatureLine(HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> oxygenTemperature = null;
		try {
			oxygenTemperature  = historyDataService.queryAll(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Double> oxygen = new ArrayList<>(); 
		List<Double> temperature = new ArrayList<>();
		List<String> date = new ArrayList<>();
		for (Map<String, Object> map : oxygenTemperature) {
			String oxygenFromMap = "0";
			try {
				oxygenFromMap = map.get("oxygen").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String temperatureFromMap = "0";
			try {
				temperatureFromMap = map.get("temperature").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String timeFromMap = "0000-00-00 00:00:00";
			try {
				timeFromMap = map.get("time").toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(null==oxygenFromMap || "".equals(oxygenFromMap)){
				oxygenFromMap = "0";
			}
			if(null==temperatureFromMap || "".equals(temperatureFromMap)){
				temperatureFromMap = "0";
			}
			if(null==timeFromMap || "".equals(timeFromMap)){
				timeFromMap = "0000-00-00 00:00:00";
			}
			oxygen.add(Double.parseDouble(oxygenFromMap));
			temperature.add(Double.parseDouble(temperatureFromMap));
			date.add(timeFromMap);
		}
		
		//resultMap.put("oxygenTemperature", oxygenTemperature);
		resultMap.put("oxygen", oxygen);
		resultMap.put("temperature", temperature);
		resultMap.put("date", date);
		return resultMap;
	}
	
	
	//oxygen_lineForCurve
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/oxygen_lineForCurve", method = RequestMethod.POST)
	public Object getOxygenTemperatureLineForCurve(HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> oxygenTemperature = null;
		try {
			oxygenTemperature  = historyDataService.queryAllForCurve(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Double> oxygen = new ArrayList<>(); 
		List<Double> temperature = new ArrayList<>();
		List<String> date = new ArrayList<>();
		for (Map<String, Object> map : oxygenTemperature) {
			String oxygenFromMap = "0";
			try {
				oxygenFromMap = map.get("oxygen").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String temperatureFromMap = "0";
			try {
				temperatureFromMap = map.get("temperature").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String timeFromMap = "0000-00-00 00:00:00";
			try {
				timeFromMap = map.get("time").toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(null==oxygenFromMap || "".equals(oxygenFromMap)){
				oxygenFromMap = "0";
			}
			if(null==temperatureFromMap || "".equals(temperatureFromMap)){
				temperatureFromMap = "0";
			}
			if(null==timeFromMap || "".equals(timeFromMap)){
				timeFromMap = "0000-00-00 00:00:00";
			}
			oxygen.add(Double.parseDouble(oxygenFromMap));
			temperature.add(Double.parseDouble(temperatureFromMap));
			date.add(timeFromMap);
		}
		
		//resultMap.put("oxygenTemperature", oxygenTemperature);
		resultMap.put("oxygen", oxygen);
		resultMap.put("temperature", temperature);
		resultMap.put("date", date);
		return resultMap;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//PH_line
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/PH_line", method = RequestMethod.POST)
	public Object getPHLine(HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> oxygenTemperature = null;
		try {
			oxygenTemperature  = historyDataService.queryAll(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Double> PHS = new ArrayList<>(); 
		List<String> date = new ArrayList<>();
		for (Map<String, Object> map : oxygenTemperature) {
			String PHFromMap = "0";
			try {
				PHFromMap = map.get("PH").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String timeFromMap = "0000-00-00 00:00:00";
			try {
				timeFromMap = map.get("time").toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(null==PHFromMap || "".equals(PHFromMap)){
				PHFromMap = "0";
			}
			if(null==timeFromMap || "".equals(timeFromMap)){
				timeFromMap = "0000-00-00 00:00:00";
			}
			PHS.add(Double.parseDouble(PHFromMap));
			date.add(map.get("time").toString());
			date.add(timeFromMap);
		}
		resultMap.put("oxygenTemperature", oxygenTemperature);
		resultMap.put("PH", PHS);
		resultMap.put("date", date);
		return resultMap;
	}
	//PH_lineForCurve
	@AuthFilter
	@ResponseBody
	@RequestMapping(value = "/PH_lineForCurve", method = RequestMethod.POST)
	public Object getPHLineForCurve(HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String, Object>> oxygenTemperature = null;
		try {
			oxygenTemperature  = historyDataService.queryAllForCurve(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Double> PHS = new ArrayList<>(); 
		List<String> date = new ArrayList<>();
		for (Map<String, Object> map : oxygenTemperature) {
			String PHFromMap = "0";
			try {
				PHFromMap = map.get("PH").toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String timeFromMap = "0000-00-00 00:00:00";
			try {
				timeFromMap = map.get("time").toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(null==PHFromMap || "".equals(PHFromMap)){
				PHFromMap = "0";
			}
			if(null==timeFromMap || "".equals(timeFromMap)){
				timeFromMap = "0000-00-00 00:00:00";
			}
			PHS.add(Double.parseDouble(PHFromMap));
			date.add(map.get("time").toString());
			date.add(timeFromMap);
		}
		resultMap.put("oxygenTemperature", oxygenTemperature);
		resultMap.put("PH", PHS);
		resultMap.put("date", date);
		return resultMap;
	}
	@ResponseBody
	@RequestMapping(value="exportExcel")
	@AuthFilter
	public void export(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		System.out.println(params.toString());
		HSSFWorkbook wb = historyDataService.export(params);//重点在此处
		response.setContentType("application/vnd.ms-excel");
		final String userAgent = request.getHeader("USER-AGENT");
		String filename = null;//设置下载时客户端Excel的名称   
		if(Constant.LXBH_CGQ_RYWD.equals(params.get("dataKind").toString())){
			filename = "溶氧度温度历史数据信息表.xls";
		}else if(Constant.LXBH_CGQ_PH.equals(params.get("dataKind").toString())){
			filename = "PH值历史数据信息表.xls";
		}
		String finalFileName = null;
		try {
            if(StringUtils.contains(userAgent, "MSIE")){//IE浏览器
                finalFileName = URLEncoder.encode(filename,"UTF8");
            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
                finalFileName = new String(filename.getBytes(), "ISO8859-1");
            }else{
                finalFileName = URLEncoder.encode(filename,"UTF8");//其他浏览器
            }
        } catch (Exception e) {
        	finalFileName = "member.xls";
        }
		//这里设置文件名，并让浏览器弹出下载提示框，而不是直接在浏览器中打开
		response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}
	
	
	
	
	
}
