//获取浏览器可视区域大小
function pageSize1() {
	return {
		width : document.body.clientWidth,
		height : document.body.clientHeight
	}
}


function pageSize() //函数：获取尺寸  
{  
	var winWidth = 0;  
	var winHeight = 0; 
    // 获取窗口宽度  
    if (window.innerWidth)  
        winWidth = window.innerWidth;  
    else if ((document.body) && (document.body.clientWidth))  
        winWidth = document.body.clientWidth-4;  
    // 获取窗口高度  
    if (window.innerHeight)  
        winHeight = window.innerHeight;  
    else if ((document.body) && (document.body.clientHeight))  
        winHeight = document.body.clientHeight-7;     
    // 通过深入Document内部对body进行检测，获取窗口大小  
    if (document.documentElement  && document.documentElement.clientHeight && document.documentElement.clientWidth)  
    {  
        winHeight = document.documentElement.clientHeight;  
        winWidth = document.documentElement.clientWidth;  
    }  
 

    return {
		width : winWidth,
		height :winHeight
	}
    
} 


//数字转汉字
function transfer(input) {
	input = input+"";
	var danwei = Array("", "十", "百", "千", "万", "十", "百", "千", "亿");
	var l = input.length;
	var a = new Array(l);
	var b = new Array(l);
	var result = "";
	for (var i = 0; i < l; i++) {
		a[i] = input.substr(i, 1);
		b[i] = getchinese(a[i]);
		result += b[i] + danwei[l - i - 1];
	}
	return result;
}

function getchinese(input) {
	if (input == "0")
		return "零";
	else if (input == "1")
		return "一";
	else if (input == "2")
		return "二";
	else if (input == "3")
		return "三";
	else if (input == "4")
		return "四";
	else if (input == "5")
		return "五";
	else if (input == "6")
		return "六";
	else if (input == "7")
		return "七";
	else if (input == "8")
		return "八";
	else if (input == "9")
		return "九";
}
 

// 自定义下拉框插件
$.fn.loadForComb = function(param, callbackFun) {
	var $this = $(this);
	var url = $(this).attr("comb-url");
	var title = $(this).attr("comb-title");
	var defaultValue = $(this).attr("comb-default-value") ? $(this).attr(
			"comb-default-value") : "";
	var defaultDisplay = $(this).attr("comb-default-display");

	var childId = $(this).attr("comb-child");
	var keyName = $(this).attr("comb-key");
	var valueName = $(this).attr("comb-value");

	if (childId) {
		$this.change(function() {
			$("#" + childId).attr("comb-default-value", "");
			$("#" + childId).loadForComb($(this).val());

		});
	}

	if (param) {
		url = url + "?id=" + encodeURI(encodeURI(param));
	}

	$.get(url, {
		_ : new Date().getTime()
	}, function(data) {
		$this.empty();
		$("#" + childId).empty();
		if (title)
			$this.append("<option value=''>" + title + "</option>");

		var hasSelected = false;
		if (data != undefined && data != null && data.json != undefined) {

			for ( var i = 0; i < data.json.length; i++) {
				var tempData = data.json[i];
				if (defaultValue == tempData[keyName]) {
					$this.append("<option selected = selected' value='"
							+ tempData[keyName] + "'>" + tempData[valueName]
							+ "</option>");
					hasSelected = true;
				} else
					$this.append("<option value='" + tempData[keyName] + "'>"
							+ tempData[valueName] + "</option>");
			}

			if (childId) {
				if (!hasSelected) {
					if (defaultValue == "") {
						$("#" + childId).attr("comb-default-value", "");
					}
				}

				$("#" + childId).loadForComb($this.val());
			}
		}

		if (!hasSelected) {
			if (defaultValue == "")
				$this.children().eq(0).attr("selected", true);
			else
				$this.children().eq(0).after(
						"<option selected = selected' value='" + defaultValue
								+ "'>" + defaultDisplay + "</option>");
		}

		callbackFun();
	});
}

$.fn.combRefresh = function() {
	if ($(this).hasClass("comb-state")) {
		$(this).removeClass("comb-state");
	}
	$(this).click();
}

// 将form表单中的参数值转换为json对象
function getFormJson(formId) {
	var o = {};
	var a = $("#" + formId).serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
}

function myparser(s){  
    if (!s) return new Date();  
    var ss = (s.split('-'));  
    var y = parseInt(ss[0],10);  
    var m = parseInt(ss[1],10);  
    var d = parseInt(ss[2],10);  
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
        return new Date(y,m-1,d);  
    } else {  
        return new Date();  
    }  
}  

/**
 * 日期格式化
 */
function dateFormatter(e) {

	if (typeof (e) == "string") {// 如果是string或number(毫秒数)类型
		// 表示通过.Net MVC提供的 return Json(result,
		// JsonRequestBehavior.AllowGet);方式返回的/Date(1332919782070)/日期格式
		if (e.indexOf("Date") > 0) {
			/* json格式时间转js时间格式 */
			var value = e.substr(1, e.length - 2);
			var obj = eval('(' + "{Date: new " + value + "}" + ')');
			var date = obj["Date"];
			if (date.getFullYear() < 1900) {
				return "";
			}			
			return date.format("yyyy-MM-dd");
		}	 
		// 表示其他字符串或数字格式日期
		var date = new Date(e);
		return date.format("yyyy-MM-dd");
	} else if (typeof (e) == "number") {
		var date = new Date(e);
		return date.format("yyyy-MM-dd");
	} else if (e) {// 如果是Date类型
		return e.format("yyyy-MM-dd");
	} else {
		return "";
	}

}

function timeFormatter(e) {
	if (typeof (e) == "string") {// 如果是string或number(毫秒数)类型
		// 表示通过.Net MVC提供的 return Json(result,
		// JsonRequestBehavior.AllowGet);方式返回的/Date(1332919782070)/日期格式
		if (e.indexOf("Date") > 0) {
			/* json格式时间转js时间格式 */
			var value = e.substr(1, e.length - 2);
			var obj = eval('(' + "{Date: new " + value + "}" + ')');
			var date = obj["Date"];
			if (date.getFullYear() < 1900) {
				return "";
			}
			return date.format("yyyy-MM-dd hh:mm:ss");
		}
		// 表示其他字符串格式日期
		var date = new Date(e);
		return date.format("yyyy-MM-dd hh:mm:ss");
	} else if (typeof (e) == "number") { // 表示数字格式日期
		var date = new Date(e);
		return date.format("yyyy-MM-dd hh:mm:ss");
	} else if (e) {// 如果是Date类型
		return e.format("yyyy-MM-dd hh:mm:ss");
	} else {
		return "";
	}

}

/*
 * 把datebox设置成月份选择
 * */
function setDateBox(id){
	$('#'+id).datebox({
        onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
            span.trigger('click'); //触发click事件弹出月份层
            if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                tds = p.find('div.calendar-menu-month-inner td');
                tds.click(function (e) {
                    e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                    var year = /\d{4}/.exec(span.html())[0]//得到年份
                    , month = parseInt($(this).attr('abbr'), 10); //月份，这里不需要+1
                    $('#'+id).datebox('hidePanel')//隐藏日期对象
                    .datebox('setValue', year + '-' + month); //设置日期的值
                });
            }, 0);
            yearIpt.unbind();//解绑年份输入框中任何事件
        },
        parser: function (s) {
       
            if (!s) return new Date();
            var arr = s.split('-');
            return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
        },
        formatter: function (d) { return d.getFullYear() + '-' + ((d.getMonth() + 1)>=10?(d.getMonth() + 1):('0'+(d.getMonth() + 1))); }
    });
   		var p = $('#'+id).datebox('panel'), //日期选择对象
        tds = false, //日期选择对象中月份
        yearIpt = p.find('input.calendar-menu-year'),//年份输入框
        span = p.find('span.calendar-text'); //显示月份层的触发控件
}

/**
 * 截取字符串
 * @param str 需要截取的字符串
 * @param start 开始截取位置
 * @param length 截取字符串长度
 */
function stringFormatter(str, start, length) {
	if(typeof(str) == "string") {
		var sub = str.substr(start, length > str.length - start ? str.length - start : length);
		return length > str.length - start ? sub : sub + "...";
	} 
	return "";
}

/**
 * 格式化数值
 * @param value 需要格式化的数值
 * @param precision 小数点后位数
 */
function numberFormatter(value, precision) {
	if(typeof(value) == "undefined") {
		return "0.00";
	}
	if(typeof(value) == "string") {
		return parseFloat(value).toFixed(precision);
	}
	if(typeof(value) == "number") {
		return value.toFixed(precision);
	}
	return "0.00";
}

Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}

	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}

	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
}

// 动态设置DataGrid控件的大小
function setDataGridSize(datagridId, delHeight, delWidth) {
	$(function() {
		var $datagrid = $("#" + datagridId);
		if (delHeight || delHeight == 0)
			$datagrid.datagrid('resize', {
				height : pageSize().height - delHeight
			});
		if (delWidth || delWidth == 0)
			$datagrid.datagrid('resize', {
				width : pageSize().width - delWidth
			});

		$(window).resize(function() {
			if (delHeight || delHeight == 0)
				$datagrid.datagrid('resize', {
					height : pageSize().height - delHeight
				});
			if (delWidth || delWidth == 0)
				$datagrid.datagrid('resize', {
					width : pageSize().width - delWidth
				});
		});

	});
}

// 动态设置TreeGrid控件的大小
function setTreeGridSize(datagridId, delHeight, delWidth) {

	var $datagrid = $("#" + datagridId);
	if (delHeight || delHeight == 0)
		$datagrid.treegrid('resize', {
			height : pageSize().height - delHeight
		});
	if (delWidth || delWidth == 0)
		$datagrid.treegrid('resize', {
			width : pageSize().width - delWidth
		});

	$(window).resize(function() {
		if (delHeight || delHeight == 0)
			$datagrid.treegrid('resize', {
				height : pageSize().height - delHeight
			});
		if (delWidth || delWidth == 0)
			$datagrid.treegrid('resize', {
				width : pageSize().width - delWidth
			});
	});

}

function search_load(dateGridId, params, gridType) {
	if (gridType == "treegrid") {
		// 如果是string类型 表示为查询条件所在的form表单的id 这种情况下
		// 会利用getFormJson(formId)方法将这些参数封装成json对象
		if (typeof (params) == "string")
			$('#' + dateGridId).treegrid('load', getFormJson(params));
		else if (typeof (params) == "undefined" || params=="") // 表示不传递参数
			$('#' + dateGridId).treegrid('load');
		else
			// 表示params本身就是参数的json对象
			$('#' + dateGridId).treegrid('load', params);
	} else {
		// 如果是string类型 表示为查询条件所在的form表单的id 这种情况下
		// 会利用getFormJson(formId)方法将这些参数封装成json对象
		if (typeof (params) == "string")
			$('#' + dateGridId).datagrid('load', getFormJson(params));
		else if (typeof (params) == "undefined") // 表示不传递参数
			$('#' + dateGridId).datagrid('load');
		else
			// 表示params本身就是参数的json对象
			$('#' + dateGridId).datagrid('load', params);
	}

}

function submitForm(formId, dialogId, gridId, gridFormId,subBtn,gridType) {
	var form = $("#" + formId);
	var action = form.attr("action");
	if (form.form("validate")) {
		$(subBtn).linkbutton("disable");
		$.post(action, getFormJson(formId), function(data) {
			data = eval( "(" + data + ")" );
            if(data.errorMsg){
            	$.messager.alert("温馨提示", data.errorMsg);
            }else{
				$.messager.alert("温馨提示", "保存成功！");
				if (dialogId) {
					$('#' + dialogId).dialog('close');
				}
				search_load(gridId, gridFormId, gridType);
			}
		});
		$(subBtn).linkbutton("enable");
	}
}
function submitForm2(formId, dialogId, subBtn) {
	var form = $("#" + formId);
	var action = form.attr("action");
	console.log(getFormJson(formId))
	if (form.form("validate")) {
		$(subBtn).linkbutton("disable");
		$.post(action, getFormJson(formId), function(data) {
			data = eval( "(" + data + ")" );
			if(data.errorMsg){
				$.messager.alert("温馨提示", data.errorMsg);
			}else{
				$.messager.alert("温馨提示", "保存成功！");
				if (dialogId) {
					$('#' + dialogId).dialog('close');
				}
				$('#main_center_tabs').tabs('close','项目详细信息');
				$('#flow_table').datagrid('reload');
			}
			$(subBtn).linkbutton("enable");
		});
	}else{
		$.messager.alert("温馨提示", "必填字段不能为空");
	}
}

/**
 * 异步提交表单
 * @param formId 需要提交的表单ID
 * @param $dialog easyui dialog jQuery对象
 * @param gridId 需要重载数据的easyui datagrid ID
 * @param gridFormId easyui datagrid 重载时的过滤参数的表单ID
 * @param gridType grid 类型：treegrid or 其它
 */
function ajaxSubmitForm(formId, $dialog, gridId, gridFormId, gridType, subBtn) {
	var form = $("#" + formId);
	var action = form.attr("action");
	if (form.form("validate")) {
		if(subBtn) {
			$(subBtn).linkbutton("disable");
		}
		$.post(action, getFormJson(formId), function(data) {
			data = jQuery.parseJSON(data);
			if (data > 0 || data.status) {
				$.messager.alert("温馨提示", "保存成功！");
				if ($dialog.length > 0) {
					$dialog.dialog('close');
				}
				search_load(gridId, gridFormId, gridType);
			} else
				$.messager.alert("温馨提示", "保存失败！");
		});
		if(subBtn) {
			$(subBtn).linkbutton("enable");
		}
	} else {
		$.messager.alert("温馨提示", "表单验证未通过！");
	}
}

function actionButtonCtr(gridId, gridType) {

	var toolbar;
	if (gridType == "treegrid")
		toolbar = $('#' + gridId).treegrid('options').toolbar;
	else
		toolbar = $('#' + gridId).datagrid('options').toolbar;

	$.getJSON(webContext + 'system/getActionsByUser', {}, function(data) {
		for ( var i = 0; i < toolbar.length; i++) {
			var tool = toolbar[i];
			var hasAction = false;
			for ( var j = 0; j < data.length; j++) {
				var action = data[j];
				if (action.menuUrl == tool.url && action.menuType == 2) {
					hasAction = true;
					break;
				}
			}

			if (!hasAction) {
			  if(tool.text) 
		         $('#'+gridId).datagrid("removeToolbarItem",tool.text);
			}
		}
 
	});
}


$.extend($.fn.datagrid.methods, {  
  addToolbarItem: function(jq, items){  
      return jq.each(function(){  
          var toolbar = $(this).parent().prev("div.datagrid-toolbar");
          for(var i = 0;i<items.length;i++){
              var item = items[i];
              if(item === "-"){
                  toolbar.append('<div class="datagrid-btn-separator"></div>');
              }else{
                  var btn=$("<a href=\"javascript:void(0)\"></a>");
                  btn[0].onclick=eval(item.handler||function(){});
                  btn.css("float","left").appendTo(toolbar).linkbutton($.extend({},item,{plain:true}));
              }
          }
          toolbar = null;
      });  
  },
  removeToolbarItem: function(jq, param){  
      return jq.each(function(){  
          var btns = $(this).parent().prev("div.datagrid-toolbar").find("a");
          var cbtn = null;
          if(typeof param == "number"){
              cbtn = btns.eq(param);
          }else if(typeof param == "string"){
              var text = null;                
              btns.each(function(){
                  text = $(this).data().linkbutton.options.text;
                  console.log(text)
                  if(text == param){
                      cbtn = $(this);
                      text = null;
                      return;
                  }
              });
          } 
          if(cbtn){
          	
              var prev = cbtn.prev()[0];
              var next = cbtn.next()[0];
              if(prev && next && prev.nodeName == "DIV" && prev.nodeName == next.nodeName){
                  $(prev).remove();
              }else if(next && next.nodeName == "DIV"){
                  $(next).remove();
              }else if(prev && prev.nodeName == "DIV"){
                  $(prev).remove();
              }
              cbtn.remove();    
              cbtn= null;
          }                        
      });  
  }                 
});

$.extend($.fn.validatebox.defaults.rules, {
	CHS : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5]+$/.test(value);
		},
		message : '请输入汉字'
	},
	ZIP : {
		validator : function(value, param) {
			return /^[1-9]\d{5}$/.test(value);
		},
		message : '邮政编码不存在'
	},
	QQ : {
		validator : function(value, param) {
			return /^[1-9]\d{4,10}$/.test(value);
		},
		message : 'QQ号码不正确'
	},
	mobile : {
		validator : function(value, param) {
			return /^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$/.test(value) ||  /^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value);
		},
		message : '联系方式格式不正确'
	},
	phone: {
		validator:function(value, param) {
			return /^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value);
		},
		message: '电话号码不正确'
	},
	loginName : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message : '登录名称只允许汉字、英文字母、数字及下划线。'
	},
	safepass : {
		validator : function(value, param) {
			return safePassword(value);
		},
		message : '密码由字母和数字组成，至少6位'
	},
	equalTo : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '两次输入不一至'
	},
	number : {
		validator : function(value, param) {
			return /^\d+$/.test(value);
		},
		message : '请输入数字'
	},
	intOrFloat: {// 验证整数或小数
	    validator: function (value) {
	        return /^\d+(\.\d+)?$/i.test(value);
	    },
	    message: '请输入整数或小数'
	},
	idcard : {
		validator : function(value, param) {
			return idCard(value);
		},
		message : '请输入正确的身份证号码'
	},
	strNumber: {
		validator : function(value, param) {
			return /^[-]*[\d,]*$/.test(value) || /^[-]*[\d，]*$/.test(value);
		},
		message : '请输入正确数值字符串，以逗号分隔'
	}
});

/* 密码由字母和数字组成，至少6位 */
var safePassword = function(value) {
	return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/.test(value));
}

var idCard = function(value) {
	if (value.length == 18 && 18 != value.length)
		return false;
	var number = value.toLowerCase();
	var d = 0;
	var sum = 0;
	var v = '10x98765432';
	var w = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
	var a = '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
	/*
	var d, sum = 0, v = '10x98765432', w = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7,
			9, 10, 5, 8, 4, 2 ], a = '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
	*/
	var re = number.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/);
	if (re == null || a.indexOf(re[1]) < 0)
		return false;
	if (re[2].length == 9) {
		number = number.substr(0, 6) + '19' + number.substr(6);
		d = [ '19' + re[4], re[5], re[6] ].join('-');
	} else
		d = [ re[9], re[10], re[11] ].join('-');
	if (!isDateTime.call(d, 'yyyy-MM-dd'))
		return false;
	for ( var i = 0; i < 17; i++)
		sum += number.charAt(i) * w[i];
	return (re[2].length == 9 || number.charAt(17) == v.charAt(sum % 11));
}

var isDateTime = function(format, reObj) {
	format = format || 'yyyy-MM-dd';
	var input = this, o = {}, d = new Date();
	var f1 = format.split(/[^a-z]+/gi), f2 = input.split(/\D+/g), f3 = format
			.split(/[a-z]+/gi), f4 = input.split(/\d+/g);
	var len = f1.length, len1 = f3.length;
	if (len != f2.length || len1 != f4.length)
		return false;
	for ( var i = 0; i < len1; i++)
		if (f3[i] != f4[i])
			return false;
	for ( var i = 0; i < len; i++)
		o[f1[i]] = f2[i];
	o.yyyy = s(o.yyyy, o.yy, d.getFullYear(), 9999, 4);
	o.MM = s(o.MM, o.M, d.getMonth() + 1, 12);
	o.dd = s(o.dd, o.d, d.getDate(), 31);
	o.hh = s(o.hh, o.h, d.getHours(), 24);
	o.mm = s(o.mm, o.m, d.getMinutes());
	o.ss = s(o.ss, o.s, d.getSeconds());
	o.ms = s(o.ms, o.ms, d.getMilliseconds(), 999, 3);
	if (o.yyyy + o.MM + o.dd + o.hh + o.mm + o.ss + o.ms < 0)
		return false;
	if (o.yyyy < 100)
		o.yyyy += (o.yyyy > 30 ? 1900 : 2000);
	d = new Date(o.yyyy, o.MM - 1, o.dd, o.hh, o.mm, o.ss, o.ms);
	var reVal = d.getFullYear() == o.yyyy && d.getMonth() + 1 == o.MM
			&& d.getDate() == o.dd && d.getHours() == o.hh
			&& d.getMinutes() == o.mm && d.getSeconds() == o.ss
			&& d.getMilliseconds() == o.ms;
	return reVal && reObj ? d : reVal;
	function s(s1, s2, s3, s4, s5) {
		s4 = s4 || 60, s5 = s5 || 2;
		var reVal = s3;
		if (s1 != undefined && s1 != '' || !isNaN(s1))
			reVal = s1 * 1;
		if (s2 != undefined && s2 != '' && !isNaN(s2))
			reVal = s2 * 1;
		return (reVal == s1 && s1.length != s5 || reVal > s4) ? -10000 : reVal;
	}
};

/**
 * 扩展树表格级联勾选方法：
 * @param {Object} container
 * @param {Object} options
 * @return {TypeName}
 */
$.extend($.fn.treegrid.methods, {
	/**
	 * 级联选择
	 * @param {Object} target
	 * @param {Object} param param包括两个参数: id:勾选的节点ID deepCascade:是否深度级联
	 * @return {TypeName}
	 */
	cascadeCheck : function(target, param) {
		var opts = $.data(target[0], "treegrid").options;
		if (opts.singleSelect) {
			return;
		}
		var idField = opts.idField;// 这里的idField其实就是API里方法的id参数
		var status = false;// 用来标记当前节点的状态，true:勾选，false:未勾选
		var selectNodes = $(target).treegrid('getSelections');// 获取当前选中项
		for ( var i = 0; i < selectNodes.length; i++) {
			if (selectNodes[i][idField] == param.id)
				status = true;
		}
		// 级联选择父节点
		selectParent(target[0], param.id, idField, status);
		selectChildren(target[0], param.id, idField, param.deepCascade, status);
		/**
		 * 级联选择父节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName}
		 */
		function selectParent(target, id, idField, status) {
			var parent = $(target).treegrid('getParent', id);
			if (parent) {
				var parentId = parent[idField];
				if (status)
					$(target).treegrid('select', parentId);
				else
					$(target).treegrid('unselect', parentId);
				selectParent(target, parentId, idField, status);
			}
		}
		/**
		 * 级联选择子节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} deepCascade 是否深度级联
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName}
		 */
		function selectChildren(target, id, idField, deepCascade, status) {
			// 深度级联时先展开节点
			if (!status && deepCascade)
				$(target).treegrid('expand', id);
			// 根据ID获取下层孩子节点
			var children = $(target).treegrid('getChildren', id);
			for ( var i = 0; i < children.length; i++) {
				var childId = children[i][idField];
				if (status)
					$(target).treegrid('select', childId);
				else
					$(target).treegrid('unselect', childId);
				selectChildren(target, childId, idField, deepCascade, status);// 递归选择子节点
			}
		}
	}
});

$.extend($.fn.datagrid.defaults.editors, {
	combotree_single : {
		init : function(container, options) {
			var box = $('<input />').appendTo(container);
			box.combotree(options);
			return box;
		},
		getValue : function(target) {
			var t = $(target).combotree('tree', target);
			var n = t.tree('getSelected');
			if (n != null)
				return n.text;
			else
				return $(target).combotree('getValue');
		},
		setValue : function(target, value) {
			if (value) {
				if (value.id) {
					$(target).combotree('setValue', value.id);
				} else {
					$(target).combotree('setValue', value);
				}
			}
		},
		resize : function(target, width) {
			var box = $(target);
			box.combotree('resize', width);
		},
		destroy : function(target) {
			$(target).combotree('destroy');
		}
	}
});

// datagrid的自定义editor控件 弹出dialog
$.extend($.fn.datagrid.defaults.editors,{
		mydialog : {
			init : function(container, options) {
				var box = $("<input />").appendTo(container);
				options.editable = false;
				box.textbox(options);

				box.textbox('textbox').click(function() {
					var $dialog = $("<div id='"+options.dialogOptions.id+"'></div>");
					var cancel = {
						text : '取消',
						handler : function() {							
							$dialog.dialog('close')
						}
					};

					// 第一次初始化dialog 将设置dialog的buttons 和 保存dialog的原始高度initHeight和宽度initWidth属性
					if (!options.dialogOptions.isFirst) {
						options.dialogOptions.buttons.push(cancel);
						options.dialogOptions.isFirst = "isFirst";
					}

					// datagrid中其他行的其他列再调用该editor时   修改其cancel对象 对应的弹出dialog对象
						options.dialogOptions.buttons[options.dialogOptions.buttons.length - 1] = cancel;
 
						options.dialogOptions.onClose=function(){
							$dialog.dialog('destroy')
					}
					
					//options.dialogOptions.buttons = 
					$dialog.dialog(options.dialogOptions);
					$dialog.dialog('open');
						 
					});
				return box;
			},
			getValue : function(target) {
				return $(target).textbox('getValue');
			},
			setValue : function(target, value) {
				$(target).textbox('setValue',value);
			},
			resize : function(target, width) {
				var box = $(target);
				box.textbox('resize', width);
			},
			destroy : function(target) {
				$(target).textbox('destroy');
			}
		}
});

/**
 * 扩展树表格级联勾选方法：
 * @param {Object} container
 * @param {Object} options
 * @return {TypeName} 
 */
$.extend($.fn.treegrid.methods,{
	/**
	 * 级联选择
     * @param {Object} target
     * @param {Object} param 
	 *		param包括两个参数:
     *		id:勾选的节点ID
     *		deepCascade:是否深度级联
     * @return {TypeName} 
	 */
	cascadeCheck : function(target,param){
		var opts = $.data(target[0], "treegrid").options;
		if(opts.singleSelect)
			return;
		var idField = opts.idField;//这里的idField其实就是API里方法的id参数
		var status = false;//用来标记当前节点的状态，true:勾选，false:未勾选
		//var selectNodes = $(target).treegrid('getSelections');//获取当前选中项
		
		//for(var i=0;i<selectNodes.length;i++){
		//	if(selectNodes[i][idField]==param.id){
		//		status = true;	
		//		break;
		//	}	    
		//}
		
		
		// $(target).treegrid("select",param.id);
		//var rows = opts.finder.getTr(target,"","allbody",2);
		//console.log(rows)
        //var trIndex = getTrIndex(rows,row[idField]);
        var clickRow = param.checkRow;
		status = !clickRow.hasClass('datagrid-row-checked');
 
        if(status) {
        	clickRow.addClass('hasClicked');
        }
	 
		//级联选择父节点
		//selectParent(target[0],param.id,idField,status);
		selectChildren(target[0],param.id,idField,param.deepCascade,status);
		/**
		 * 级联选择父节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName} 
		 */
		function selectParent(target,id,idField,status){
			var parent = $(target).treegrid('getParent',id);
			if(parent){
				var parentId = parent[idField];
				if(status)
					$(target).treegrid('select',parentId);
				else
					$(target).treegrid('unselect',parentId);
				selectParent(target,parentId,idField,status);
			}
		}
		/**
		 * 级联选择子节点
		 * @param {Object} target
		 * @param {Object} id 节点ID
		 * @param {Object} deepCascade 是否深度级联
		 * @param {Object} status 节点状态，true:勾选，false:未勾选
		 * @return {TypeName} 
		 */
		function selectChildren(target,id,idField,deepCascade,status){
			//深度级联时先展开节点
			if(!status&&deepCascade)
				$(target).treegrid('expand',id);
			//根据ID获取下层孩子节点
			var children = $(target).treegrid('getChildren',id);
			for(var i=0;i<children.length;i++){
				var childId = children[i][idField];
				console.log(status)
				if(status)
					$(target).treegrid('select',childId);
				else
					$(target).treegrid('unselect',childId);
				selectChildren(target,childId,idField,deepCascade,status);//递归选择子节点
			}
		}
	}
});

Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};

Array.prototype.indexOfObj = function(idName, idValue) { 
    for (var i = 0; i < this.length; i++) {  
        if (eval('this['+i+'].'+idName) == idValue) return i;  
    }  
    return -1;  
};

Array.prototype.getItem = function(idName, idValue) { 
    for (var i = 0; i < this.length; i++) {  
        if (eval('this['+i+'].'+idName) == idValue) return this[i];  
    }  
    return null;  
};

Array.prototype.removeObj = function(idName, idValue) {  
    var index = this.indexOfObj(idName,idValue);  
    if (index > -1) {  
        this.splice(index, 1);  
    }  
};

Array.prototype.toStringObj = function(idName) { 
	var str='';
    for (var i = 0; i < this.length; i++) {  
        if(str=='')
        	str = eval('this['+i+'].'+idName);
  	    else 
  	    	str += ','+eval('this['+i+'].'+idName);
    }  
    return str;  
};
 

String.prototype.startWith=function(str){     
  var reg=new RegExp("^"+str);     
  return reg.test(this);        
}  

String.prototype.endWith=function(str){     
  var reg=new RegExp(str+"$");     
  return reg.test(this);        
}

$.extend($.fn.datagrid.methods, {  
	  getRowByFieldValue: function(jq, param){
		  var row;
		   jq.each(function(){  
			 var rows = $(this).datagrid("getRows");
			 for(var i=0;i<rows.length;i++){
				 if(rows[i][param.fieldName]==param.fieldValue){
					 row = rows[i];
					 return false;
				 }
			 }
		  });
		  return row;
	  },
	  selectRowByFieldValue:function(jq, param){
		   return jq.each(function(){  
			 var row =   $(this).datagrid("getRowByFieldValue",param);
			 var rowIndex = $(this).datagrid("getRowIndex",row);	
			 $(this).datagrid("checkRow",rowIndex);
			 
		  });	  
	  },
	  unSelectRowByFieldValue:function(jq, param){
		   return jq.each(function(){  
			 var row =   $(this).datagrid("getRowByFieldValue",param);
			 var rowIndex = $(this).datagrid("getRowIndex",row);	
			 $(this).datagrid("uncheckRow",rowIndex);
			 
		  });	  
	  }
});

$.extend($.fn.datagrid.methods, {
	editCell: function(jq,param){
		return jq.each(function(){
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field){
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
            var ed = $(this).datagrid('getEditor', param);
            if (ed){
                if ($(ed.target).hasClass('textbox-f')){
                    $(ed.target).textbox('textbox').focus();
                } else {
                    $(ed.target).focus();
                }
            }
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	},
    enableCellEditing: function(jq){
        return jq.each(function(){
            var dg = $(this);
            var opts = dg.datagrid('options');
            opts.oldOnClickCell = opts.onClickCell;
            opts.onClickCell = function(index, field){
                if (opts.editIndex != undefined){
                    if (dg.datagrid('validateRow', opts.editIndex)){
                        dg.datagrid('endEdit', opts.editIndex);
                        opts.editIndex = undefined;
                    } else {
                        return;
                    }
                }
                dg.datagrid('selectRow', index).datagrid('editCell', {
                    index: index,
                    field: field
                });
                opts.editIndex = index;
                opts.oldOnClickCell.call(this, index, field);
            }
        });
    },
    disableCellEditing: function(jq){
        return jq.each(function(){
            var dg = $(this);
            var opts = dg.datagrid('options');
            opts.oldOnClickCell = opts.onClickCell;
            opts.onClickCell = function(){};
        });
    }
});

/* datagrid 单元格编辑： Begin */
$.extend($.fn.textbox.methods, {
	addClearBtn: function(jq, iconCls){
		return jq.each(function(){
			var t = $(this);
			var opts = t.textbox('options');
			opts.icons = opts.icons || [];
			
			if(t.textbox('getIcon',0).length>0)
				return;
			
			 
			opts.icons.unshift({
				iconCls: iconCls,
				handler: function(e){
					$(e.data.target).textbox('clear').textbox('textbox').focus();
					$(this).css('visibility','hidden');
				}
			});
			t.textbox();
			if (!t.textbox('getText')){
				t.textbox('getIcon',0).css('visibility','hidden');
			}
			t.textbox('textbox').bind('keyup', function(){
				var icon = t.textbox('getIcon',0);
				if ($(this).val()){
					icon.css('visibility','visible');
				} else {
					icon.css('visibility','hidden');
				}
			});
		});
	}
});

/*$.extend($.fn.datagrid.methods, {
	editCell: function(jq,param){
		return jq.each(function(){
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field){
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
            var ed = $(this).datagrid('getEditor', param);
            if (ed){
                if ($(ed.target).hasClass('textbox-f')){
                    $(ed.target).textbox('textbox').focus();
                } else {
                    $(ed.target).focus();
                }
            }
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	},
    enableCellEditing: function(jq){
        return jq.each(function(){
            var dg = $(this);
            var opts = dg.datagrid('options');
            opts.oldOnClickCell = opts.onClickCell;
            opts.onClickCell = function(index, field){
                if (opts.editIndex != undefined){
                    if (dg.datagrid('validateRow', opts.editIndex)){
                        dg.datagrid('endEdit', opts.editIndex);
                        opts.editIndex = undefined;
                    } else {
                        return;
                    }
                }
                dg.datagrid('selectRow', index).datagrid('editCell', {
                    index: index,
                    field: field
                });
                opts.editIndex = index;
                opts.oldOnClickCell.call(this, index, field);
            }
        });
    }
});*/
/* datagrid 单元格编辑： End */


/**
 * datagrid单元格鼠标放上边之后悬浮提示
 */  
$.extend($.fn.datagrid.methods, {  
	//打开消息提示功能
	doCellTip: function(jq, params){ 
		if(!params){
			params = {};
		}

		function showTip(data, td, e){  
			if ($(td).text() == "")   
				return;  
			data.tooltip.text($(td).text()).css({  
				top: (e.pageY + 10) + 'px',  
				left: (e.pageX + 20) + 'px',  
				'z-index': $.fn.window.defaults.zIndex,  
				display: 'block'  
			});  
		};  
		return jq.each(function(){  
			var grid = $(this);  
			var options = $(this).data('datagrid');  
			if (!options.tooltip) {  
				var panel = grid.datagrid('getPanel').panel('panel');  
				var defaultCls = {  
					'font': 'normal 14px "Microsoft YaHei","Arial","宋体"',
					'border': '1px solid #333',  
					'padding': '2px',  
					'color': '#333',  
					'background': '#f7f5d1',  
					'position': 'absolute',  
					'max-width': '500px',  
					'border-radius' : '4px',  
					'-moz-border-radius' : '4px',  
					'-webkit-border-radius' : '4px',  
					'display': 'none'  
				}  
				var tooltip = $("<div id='celltip'></div>").appendTo('body');  
				tooltip.css($.extend({}, defaultCls, params.cls));  
				options.tooltip = tooltip;  
				panel.find('.datagrid-body').each(function(){  
					var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;  
					$(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {  
						'mouseover': function(e){  
							if (params.delay) {  
								if (options.tipDelayTime)   
									clearTimeout(options.tipDelayTime);  
								var that = this;  
								options.tipDelayTime = setTimeout(function(){  
									showTip(options, that, e);  
								}, params.delay);  
							}  
							else {  
								showTip(options, this, e);  
							}  

						},  
						'mouseout': function(e){  
							if (options.tipDelayTime)   
								clearTimeout(options.tipDelayTime);  
							options.tooltip.css({  
								'display': 'none'  
							});  
						},  
						'mousemove': function(e){  
							var that = this;  
							if (options.tipDelayTime)   
								clearTimeout(options.tipDelayTime);  
							options.tipDelayTime = setTimeout(function(){  
								showTip(options, that, e);  
							}, params.delay);  
						}  
					});  
				});  

			}  

		});  
	},  
	//关闭消息提示功能
	cancelCellTip: function(jq){  
		return jq.each(function(){  
			var data = $(this).data('datagrid');  
			if (data.tooltip) {  
				data.tooltip.remove();  
				data.tooltip = null;  
				var panel = $(this).datagrid('getPanel').panel('panel');  
				panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')  
			}  
			if (data.tipDelayTime) {  
				clearTimeout(data.tipDelayTime);  
				data.tipDelayTime = null;  
			}  
		});  
	}  
});

//是否可用，delete_flag=0表示可用有效
function delete_flag_formatter(delete_flag, row){
	var delete_flag_text = "<font color=green>是</font>";
	if(Number(delete_flag) == 1){
		delete_flag_text = "<font color=red>否</font>"
	}
	return delete_flag_text;
}
