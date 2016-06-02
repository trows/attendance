<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>编辑学生信息</title>
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/font-awesome.min.css" rel="stylesheet">
    <link href="./assert/sweetAlert/sweetalert.css" rel="stylesheet">
    <link href="css/site.tableBase.css" rel="stylesheet">

</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse" role="navigation">
            <ul class="nav navbar-nav">
                <li class="hidden-sm hidden-md"><a href="manageInfo.html">首页</a></li>
                <li><a href="./attendance_count.htm">考勤统计</a></li>
                <li><a href="./createAccount.html">创建账户</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="./loginOut.htm">退出登录</a></li>

            </ul>
        </div>
    </div>
</div>

<div class="myNav">
    <div class="myTag">
        <i class="block fa fa-user fa-2x"></i>
    </div>
    <div class="navText">
        <span class="navTitle">
            员工考勤统计
        </span>
        <br>
        <span class="navDesc">
            &nbsp;&nbsp;管理员行为请谨慎操作
        </span>
    </div>
</div>
<hr>


<table class="table table-striped table-hover table-responsive">
    <tr>
        <th class="tableTitle">工号</th>
        <th class="tableTitle">部门</th>
        <th class="tableTitle">姓名</th>
        <th class="tableTitle">当月打卡天数</th>
    </tr>
    <c:forEach items="${accountList}" var="account">
        <tr>
            <th>${account.account_id}</th>
            <th>${account.department}</th>
            <th>${account.user_name}</th>
            <th>${account.level}</th>
        </tr>
    </c:forEach>

</table>

<script src="./js/jquery-2.2.3.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./assert/sweetAlert/sweetalert.min.js"></script>
<script src="js/site.manageInfo.js"></script>
</body>
</html>