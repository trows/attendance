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
    <title>我的主页</title>
    <link rel="stylesheet" href="./assert/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assert/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="./assert/sweetAlert/sweetalert.css">
    <link rel="stylesheet" href="css/site.base.css">
    <link rel="stylesheet" href="css/site.employees_page.css">
</head>
<body>
<div class="headWall">
    <div class="un"></div>
    <div class="myHeadImg">
        <img src="./images/1.jpg">
    </div>
    <span class="title">hello  </span><span class="name">${account.user_name}</span>
    <div class="tip"> 点击下方按钮进行打卡操作！</div>

    <div class="punch" onclick="punch()">punch</div>
</div>
<div class="row adjust">
    <div class="col-lg-1"></div>
    <div class="col-lg-5">
        <span class="title md">Information!</span>
        <br><br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">姓名</span>
            <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">${account.user_name}</p>
        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">性别</span>
            <c:choose>
                <c:when test="${account.sex==1}">
                    <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">男</p>
                </c:when>
                <c:when test="${account.sex==0}">
                    <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">女</p>
                </c:when>
            </c:choose>

        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">部门</span>
            <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">${account.department}</p>
        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">账号</span>
            <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">${account.account_id}</p>
        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">原始密码</span>
            <input type="password" class="form-control noBorder inputFont" aria-describedby="basic-addon1"
                   value="########" id="origin">
        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">修改密码</span>
            <input type="password" class="form-control noBorder inputFont" aria-describedby="basic-addon1"
                   value="########" id="change">
        </div>
        <br>
        <div class="length">
        <button class="btn btn-danger center" onclick="submitChange()">提交修改</button>
        </div>
    </div>
    <div class="col-lg-5">
        <span class="title md"> attendance!</span>
        <br><br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">上月核发工资</span>
            <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">￥${salary.count_wage}</p>
        </div>
        <br>
        <div class="input-group length">
            <span class="input-group-addon noBorder inputFont">本月全勤天数</span>
            <p class="form-control noBorder inputFont" aria-describedby="basic-addon1">${punch.month_time}天</p>
        </div>
        <br>
        <br>
        <button type="button" class="btn btn-info" onclick="vacate()">请假</button>
    </div>
    <div class="col-lg-1">
    </div>
</div>
<script src="assert/js/jquery-2.2.3.min.js"></script>
<script src="./assert/sweetAlert/sweetalert.min.js"></script>
<script src="/js/site.employees_page.js"></script>
</body>
</html>