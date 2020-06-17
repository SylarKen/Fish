package com.domor.controller.basic;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.domor.service.basic.IndexService;
import com.domor.util.AuthFilter;
import com.domor.util.MapUtils;
import com.domor.util.ParamUtils;

@Controller
@RequestMapping("index1")
public class IndexController {

	@Autowired
	private IndexService indexService;

	@AuthFilter
	@ResponseBody
	@RequestMapping("/getDeviceValue")
	public Object getDeviceValue(HttpServletRequest request) {
		Map<String, Object> rtn = new HashMap<String, Object>();
		rtn.put("ok", false);
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		List<Map<String,Object>> list = indexService.getDeviceValue(params);
		if(list == null || list.size() == 0){
			return rtn;
		}
		rtn.put("ok", true);
		rtn.put("list", list);
		return rtn;
	}

	@AuthFilter
	@ResponseBody
	@RequestMapping("/changeDeviceStatus")
	public Object changeDeviceStatus(HttpServletRequest request) {
		Map<String, Object> rtn = new HashMap<String, Object>();

		rtn.put("ok", true);
		return rtn;
	}



	@AuthFilter
	@ResponseBody
	@RequestMapping("/getWeatherInfo")
	public JSONObject getWeatherInfo(HttpServletRequest request) throws Exception {
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		String xianId = MapUtils.getStringValue(params, "xianId");
		String xian = MapUtils.getStringValue(params, "xianName");
		//获取市
		Map<String, Object> shiM = indexService.getAreaParent(xianId);
		String shiId = MapUtils.getStringValue(shiM, "id");
		String shi = MapUtils.getStringValue(shiM, "areaname");
		//获取省
		Map<String, Object> shengM = indexService.getAreaParent(shiId);
		String sheng = MapUtils.getStringValue(shengM, "areaname");

		sheng = sheng==null || "".equals(sheng)?"山东":sheng;
		shi = shi==null || "".equals(shi)?"济宁":shi;
		xian = xian==null || "".equals(xian)?"兖州":xian;

		String shengUrl = "http://www.weather.com.cn/data/city3jdata/china.html";
		String shengKey = getAreaKeyCode(shengUrl,sheng);
		String shiUrl = "http://www.weather.com.cn/data/city3jdata/provshi/"+shengKey+".html";
		String shiKey = getAreaKeyCode(shiUrl,shi);
		String xianUrl = "http://www.weather.com.cn/data/city3jdata/station/"+shengKey+shiKey+".html";
		String xianKey = getAreaKeyCode(xianUrl,xian);
		String airUrl = "http://www.weather.com.cn/data/cityinfo/"+shengKey+shiKey+xianKey+".html";
		JSONObject reuslt = getJsonObjectByUrl(airUrl);


		return reuslt;
	}

	@SuppressWarnings("rawtypes")
	private String getAreaKeyCode(String url,String areaName){
		JSONObject areas = getJsonObjectByUrl(url);
		Set set = areas.keySet();
		Iterator it = set.iterator();
		String areaKey = "";
		while (it.hasNext()) {
			String key = (String) it.next();
			String value = areas.getString(key);
			if(value.contains(areaName) || areaName.contains(value)){
				areaKey = key;
				break;
			}
		}
		return "".equals(areaKey)?"01":areaKey;
	}

	private JSONObject getJsonObjectByUrl(String urlAdd){
		JSONObject result = new JSONObject();
		StringBuffer buffer = new StringBuffer();
		try {
			URL url = new URL(urlAdd);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(false);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod("GET");
			httpUrlConn.connect();
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			result = JSONObject.parseObject(buffer.toString());
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
		}

		return result;
	}

}
