<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>渔业综合服务平台</title>
    <jsp:include page="/common.jsp"></jsp:include>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="">
</head>
<body>
<form id="collectorNewGate_threshold_form" method="post" action='${basePath}collectorNewGateway/collectorNewGate_threshold'>
    <table style="padding:20px;">
        <tr style="height:40px;">
            <td style="width:120px;text-align:right;">编&nbsp;&nbsp;号：</td>
            <td>
                <input id="collectorNewGateway_threshold_code" class="easyui-textbox" name="collectorCode" value="${collectorNewGateway.collectorCode }" readonly unselectable="on" style="width:210px;">
            </td>
        </tr>
        <tr style="height:40px;">
            <td style="width:120px;text-align:right;">序 列 号：</td>
            <td>
                <input id="collectorNewGateway_threshold_id" class="easyui-textbox" name="collectorId" value="${collectorNewGateway.collectorId }" readonly unselectable="on" style="width:210px;">
            </td>
        </tr>
        <tr style="height:40px;">
            <td style="width:120px;text-align:right;">打 开 值：</td>
            <td>
                <input id="collectorNewGateway_threshold_on" class="easyui-textbox" name="threshold_on" value="${collectorNewGateway.threshold_on }" data-options="required:true" style="width:210px;">
            </td>
        </tr>
        <tr style="height:40px;">
            <td style="width:120px;text-align:right;">关 闭 值：</td>
            <td>
                <input id="collectorNewGateway_threshold_off" class="easyui-textbox" name="threshold_off" value="${collectorNewGateway.threshold_off }" data-options="required:true" style="width:210px;">
            </td>
        </tr>
    </table>
</form>

</body>
<script type="text/javascript">

</script>
</html>
