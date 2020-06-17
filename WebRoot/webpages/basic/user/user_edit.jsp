<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>绩效考核系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="编辑用户">
</head>
<body>
<form id="user_edit_form" method="post" action='${basePath}user/update'>
	<table style="padding:40px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">登录账号：</td>
			<td>
				<input id="user_edit_username" class="easyui-textbox" name="username" value="${user.username}"
					data-options="required:true,editable:false" style="width:210px;" validType="username">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">姓&nbsp;&nbsp;名：</td>
			<td>
				<input id="user_edit_realname" class="easyui-textbox" name="realname" value="${user.realname}"
					data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">性&nbsp;&nbsp;别：</td>
			<td>
				男&nbsp;<input id="user_edit_sex_man" type="radio" name="sex" value="0" checked>
				女&nbsp;<input id="user_edit_sex_woman" type="radio" name="sex" value="1">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">手&nbsp;&nbsp;机：</td>
			<td>
				<input id="user_edit_phone" class="easyui-textbox" name="phone" value="${user.phone}"
					data-options="" style="width:210px;" validType="mobile">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">角&nbsp;&nbsp;色：</td>
			<td>
				<input id="user_edit_role" name="role" style="width:210px;" value="${user.role}">
				<input type="hidden" id="user_edit_role_name" name="roleName" value="${user.roleName}">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">所在区划：</td>
			<td>
				<input id="user_edit_areaId" type="hidden" name="area"  value="${user.area}"  style="width:200px;">
				<input id="user_edit_areaName"  name="areaName"  value="${user.areaName}" />
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">部门名称：</td>
			<td>
				<input id="user_edit_dept" name="dept" value="${user.dept}" style="width:210px;">
				<input type="hidden" id="user_edit_deptName" name="deptName" value="${user.deptName}">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">管理池塘：</td>
			<td>
				<input id="user_edit_pondCode" type="hidden" name="pondCode"  value="${user.pondCode}">
				<input id="user_edit_pondName"  name="pondName"  value="${user.pondName}"/>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">是否可用：</td>
			<td>
				<input id="user_edit_delete_flag" name="delete_flag" value="${user.delete_flag}" style="width:210px;">
			</td>
		</tr>
		
	</table>
</form>
<script type="text/javascript">
$(function() {

	$('#user_edit_dept').combobox({
		url: '${basePath}dept/getDeptForComb?hasBlank=0&area='+$("#user_edit_areaId").val(),
		valueField: 'code',
		textField: 'name', 
		editable: false,
		required:true,
		onSelect: function(node){			
			$('#user_edit_deptName').val(node.name);
		}
	});

	$('#user_edit_areaName').textbox({
		editable: false,
		width:200,
		buttonText:'查询',    
	    iconAlign:'right',
	    required:true,
	    icons:[{
			iconCls:'icon-clear',
			handler: function(e){
				$(e.data.target).textbox('clear').textbox('textbox').focus();
				$("#user_edit_areaName").textbox('setValue','${user.areaName}');
				$("#user_edit_areaId").val('${user.area}');
			}
		}],
	    onClickButton:function(){
	    	  showSelectAreaDialog($("#user_edit_areaId").val(),function(row){
	    		$("#user_edit_areaId").val(row.id);
				$("#user_edit_areaName").textbox('setValue',row.text);		
				
				$('#user_edit_dept').combobox({
					url: '${basePath}dept/getDeptForComb?hasBlank=0&area='+row.id,
					valueField: 'code',
					textField: 'name', 
					editable: false,
					required:true,
					onSelect: function(node){			
						$('#user_edit_deptName').val(node.name);
					}
				});
	        }); 
	    },
	    onChange:function(newValue, oldValue){
			
	    }
	})
	
	
	$('#user_edit_role').combobox({
		valueField: 'id',
		textField: 'text', 
		required: true,
		editable: false,
		url: '${basePath}role/dataForCombo',
		onSelect: function(item) {
			$('#user_edit_role_name').val(item.text);
		}
	});

	$('#user_edit_delete_flag').combobox({
		data: [{value: 0,text: '可用'	}, {value: 1,text: '不可用'}],
		valueField: 'value',
		textField: 'text', 
		editable: false,
		panelHeight: 'auto'
	});
	$('#user_edit_delete_flag').combobox('select', $('#user_edit_delete_flag').val());
	
	$('#user_edit_wxuse').combobox('select', $('#user_edit_wxuse').val());
	
	
	$('#user_edit_pondName').textbox({
    	editable: false,
    	width:210,
    	buttonText:'查询',    
        iconAlign:'right',
        required:true,
        icons:[{
			iconCls:'icon-clear',
			handler: function(e){
				$(e.data.target).textbox('clear').textbox('textbox').focus();
			}
		}],
        onClickButton:function(){
        	//选择池塘
        	showPondTreeDialog(0,"",function(rows){
        		var pondCode = "";
        		var pondName = "";
        		console.log(rows);
        		for(var i=0;i<rows.length;i++){
        			if(rows[i].code.length==7){
        				pondCode = pondCode==""?rows[i].code:pondCode+","+rows[i].code;
            			pondName = pondName==""?rows[i].name:pondName+","+rows[i].name;
        			}
        		}
        		
        		$('#user_edit_pondName').textbox("setValue",pondName);
        		$('#user_edit_pondCode').val(pondCode);
        	},$('#user_edit_dept').combobox("getValue"));	
        },
        onChange:function(newValue, oldValue){
      	 
      }
    })
});

</script>
</body>
</html>
