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
    <link rel="stylesheet" href="./js/site.index.modal.css">
    <link rel="stylesheet" href="css/site.base.css">
    <link rel="stylesheet" href="css/site.employees_page.css">
</head>
<body>
<div class="headWall">
    <div class="un"></div>
    <div class="myHeadImg">
        <img src="./images/1.jpg">
    </div>
    <span class="title">hello  </span><span class="name">${account.user_name}</span><a class="moveRight" href="/loginOut.htm">退出登录</a>
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
        <hr>
        <div id="vacateArea">
            <table class="table">
                <c:if test="${vacateList!=null}">
                    <tr>
                        <th>请假时间</th>
                        <th>请假天数</th>
                        <th>审核状态</th>
                    </tr>
                </c:if>
                <c:forEach items="${vacateList}" var="vacate">
                    <tr onclick="getVacateModal(this)" data="${vacate.postilReason}" class="point">
                        <th>${vacate.start_time}</th>
                        <th>${vacate.day_num}天</th>
                        <c:choose>
                            <c:when test="${vacate.postil == 2}">
                                <th>待审核</th>
                            </c:when>
                            <c:when test="${vacate.postil == 1}">
                                <th>已批准</th>
                            </c:when>
                            <c:when test="${vacate.postil == 0}">
                                <th>不批准</th>
                            </c:when>
                        </c:choose>

                    </tr>
                </c:forEach>

            </table>
            <button type="button" class="btn btn-info" onclick="vacate()">请假</button>
        </div>
        <hr>
        <div id="noticeArea">
            <table class="table">
                <c:if test="${noticeList!=null}">
                    <tr>
                        <th>通知</th>
                        <th>发布者</th>
                        <th>发布时间</th>
                    </tr>
                </c:if>
                <c:forEach items="${noticeList}" var="notice">
                    <tr onclick="showMyNotice(this)" class="point" data="${notice.content}">
                        <th>${notice.title}</th>
                        <th>${notice.user_name}</th>
                        <th>${notice.create_time}</th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="col-lg-1">
    </div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="top-content">
        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>请假申请</h3>
                                <p>请输入您的详细请假信息</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-power-off" onclick="$('#myModal').modal('hide')"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form">
                                <div class="form-group">
                                    请假日期(只限请当月假期)：<input type="date" id="vacate_date" placeholder="日期"
                                                         class="form-username form-control">
                                </div>
                                <div class="form-group">
                                    请假天数：<input type="number" id="vacate_num" placeholder="天数" min="1" max="15"
                                                class="form-password form-control">
                                </div>
                                <div class="form-group">
                                    请假理由：<textarea type="text" id="vacate_reason" placeholder="理由..."
                                                   class="form-password form-control"></textarea>
                                </div>
                                <button type="button" class="btn inBtn" onclick="subVacate()">提交申请</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="vacateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="top-content">
        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>审核理由</h3>
                                <p>假期审核由部门主管下发</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-power-off" onclick="$('#vacateModal').modal('hide')"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form">
                                <div class="form-group">
                                   <textarea type="text" placeholder="理由..." id="reason"
                                             class="form-password form-control" disabled="disabled"></textarea>
                                </div>
                                <%--<button type="button" class="btn inBtn" onclick="subVacate()">提交申请</button>--%>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="top-content">
        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>我的通告</h3>
                                <h4 id="my_title"></h4>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-power-off" onclick="$('#noticeModal').modal('hide')"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form">
                                <p id="my_content">

                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="assert/js/jquery-2.2.3.min.js"></script>
<script src="assert/bootstrap/js/bootstrap.min.js"></script>
<script src="./assert/sweetAlert/sweetalert.min.js"></script>
<script src="/js/site.employees_page.js"></script>
</body>
</html>