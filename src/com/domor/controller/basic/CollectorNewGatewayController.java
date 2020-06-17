package com.domor.controller.basic;

import com.domor.model.PagerReturns;
import com.domor.service.basic.CollectorNewGatewayService;
import com.domor.util.AuthFilter;
import com.domor.util.ParamUtils;
import com.domor.util.Stream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.security.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("collectorNewGateway")
public class CollectorNewGatewayController {

    @Autowired
    private CollectorNewGatewayService service;

    @AuthFilter
    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        return "/webpages/basic/collectorNewGateway/index";
    }

    @ResponseBody
    @RequestMapping("/query")
    public Object query(HttpServletRequest request) {
        Map<String, Object> params = ParamUtils.getParameterMap(request);
        int total = service.count(params);
        ParamUtils.addSkipCount(params, total);
        List<Map<String, Object>> users = service.query(params);
        PagerReturns pager = new PagerReturns(users, total);
        return pager;
    }

    @RequestMapping(value = "/collectorNewGate_add", method = RequestMethod.GET)
    public ModelAndView collector_addGet(HttpServletRequest request) {
        return new ModelAndView("/webpages/basic/collectorNewGateway/add");
    }

    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_add", method = RequestMethod.POST)
    public Object collector_addPost(HttpServletRequest request) {
        Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
        String username = user.get("username").toString();
        Map<String, Object> collector = ParamUtils.getParameterMap(request);
        collector.put("creator", username);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            service.insert(collector);
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("添加采集器信息发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }

    @RequestMapping(value = "/collectorNewGate_edit", method = RequestMethod.GET)
    public Object collector_editGet(HttpServletRequest request) {
        String code = ParamUtils.getStringParameter(request, "code");
        Map<String, Object> collector = service.getByCode(code);
        return new ModelAndView("/webpages/basic/collectorNewGateway/edit", "collectorNewGateway", collector);
    }

    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_edit", method = RequestMethod.POST)
    public Object collector_editPost(HttpServletRequest request) {
        Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
        String username = user.get("username").toString();
        Map<String, Object> collector = ParamUtils.getParameterMap(request);
        collector.put("editor", username);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            service.update(collector);
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("添加采集器信息发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }

    @RequestMapping(value = "/collectorNewGate_threshold", method = RequestMethod.GET)
    public Object collector_thresholdGet(HttpServletRequest request) {
        String code = ParamUtils.getStringParameter(request, "code");
        Map<String, Object> collector = service.getByCode(code);
        return new ModelAndView("/webpages/basic/collectorNewGateway/threshold", "collectorNewGateway", collector);
    }

    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_threshold", method = RequestMethod.POST)
    public Object collector_thresholdPost(HttpServletRequest request) {
        Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
        String username = user.get("username").toString();
        Map<String, Object> collector = ParamUtils.getParameterMap(request);
        collector.put("editor", username);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            service.updatethreshold(collector);
            resultMap.put("threshold_on", collector.get("threshold_on"));
            resultMap.put("threshold_off", collector.get("threshold_off"));
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("定义采集器上限下限发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }

    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_changeAuto", method = RequestMethod.POST)
    public Map<String, Object> collector_changeAutoPost(HttpServletRequest request) {

        String id = ParamUtils.getStringParameter(request, "collectorId");
        Map<String, Object> collector = service.getById(id);
        String pRunMode = collector.get("runMode").toString();

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            if ("0".equals(pRunMode)) {//手动模式切换自动模式
                collector.put("runMode", "a");
                collector.put("db", "0");
            } else {//自动模式切换为手动模式且为关闭状态
                collector.put("runMode", "0");
                collector.put("db", "0");
            }
            service.updateautomatic(collector);
            resultMap.put("ICCID", collector.get("collectorId"));
            resultMap.put("mode", collector.get("runMode"));
            resultMap.put("ok", true);
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("采集器转换为运行模式发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }


    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_manualOpen", method = RequestMethod.POST)
    public Map<String, Object> collector_manualOpenPost(HttpServletRequest request) {

        String id = ParamUtils.getStringParameter(request, "collectorId");
        Map<String, Object> collector = service.getById(id);
        String pRunMode = collector.get("runMode").toString();
        String pSwitch = collector.get("db").toString();

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("ok", false);
        try {
            if ("a".equals(pRunMode)) {
                throw new Exception("采集器当前为自动模式，请将采集器更改为手动模式再继续操作。");
            }
            if ("1".equals(pSwitch)) {//手动模式关闭采集器
                throw new Exception("采集器当前为手动模式开启状态，无需再次开启。");
            } else {//手动模式开启采集器
                collector.put("runMode", "0");
//				collector.put("db", "1");
                System.out.println("采集器序列号:" + id + "手动模式开启成功。");
                resultMap.put("ok", true);
            }
            service.updateautomatic(collector);
            resultMap.put("ICCID", collector.get("collectorId"));
            resultMap.put("o", "on");
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("采集器手动模式开启/关闭发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }

    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_manualClose", method = RequestMethod.POST)
    public Map<String, Object> collector_manualClosePost(HttpServletRequest request) {

        String id = ParamUtils.getStringParameter(request, "collectorId");
        Map<String, Object> collector = service.getById(id);
        String pRunMode = collector.get("runMode").toString();
        String pSwitch = collector.get("db").toString();

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            if ("a".equals(pRunMode)) {
                throw new Exception("采集器当前为自动模式，请将采集器更改为手动模式再继续操作。");
            }
            if ("1".equals(pSwitch)) {//手动模式关闭采集器
                collector.put("runMode", "0");
//				collector.put("db", "0");
                System.out.println("采集器序列号:" + id + "手动模式关闭成功。");
                resultMap.put("ok", true);
            } else {//手动模式开启采集器
                throw new Exception("采集器当前为手动模式关闭状态，无需再次关闭。");
            }
            service.updateautomatic(collector);
            resultMap.put("ICCID", collector.get("collectorId"));
            resultMap.put("o", "off");
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("采集器手动模式开启/关闭发生异常，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }

    @RequestMapping(value = "/selectPointDialog", method = RequestMethod.GET)
    public String selectPointDialog(Model model, String areaCode) {
        model.addAttribute("areaCode", areaCode);
        return "/webpages/basic/collector/select_point_dialog";
    }


    @ResponseBody
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/collectorNewGate_getDataList", method = RequestMethod.POST)
    public Map<String, Object> collectorNewGate_getDataList(HttpServletRequest request) {
        String id = ParamUtils.getStringParameter(request, "collectorId");
        List<Map<String, Object>> records = service.getRecords(id);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            resultMap.put("ok", true);
            final List<Object> timeList = Stream.GetColumn(records, "time_record");
            List<Object> timeList_str = new ArrayList<>();
            for (final Object o : timeList) {
//                timeList_str.add(o.toString());
                timeList_str.add(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(o));
            }
            resultMap.put("xAxis", timeList_str);
            resultMap.put("series_tmp", Stream.GetColumn(records, "temp0"));
            resultMap.put("series_o2", Stream.GetColumn(records, "o2"));
            resultMap.put("series_ph", Stream.GetColumn(records, "ph"));
//			resultMap.put("records", records);
        } catch (Exception e) {
            StringBuffer sb = new StringBuffer("记录获取失败，异常信息");
            sb.append("\n");
            sb.append(e.getMessage());
            resultMap.put("errorMsg", sb.toString());
        }
        return resultMap;
    }
}
