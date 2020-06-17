package com.domor.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author ：Sylar
 * @date ：Created in 2020/6/6 13:00
 * @description：
 * @modified By：
 * @version: $
 */
public class Stream {
    public  static List<Object>  GetColumn(List<Map<String,Object>>list, String column){
        List<Object>  resultList=new ArrayList<>();
        for(Map<String,Object> o :list){
            resultList.add(o.get(column));
        }
        return resultList;
    }
}
