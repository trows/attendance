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
    <span class="title">hello  </span><span class="name">${account.user_name}主管</span><a class="moveRight" href="/loginOut.htm">退出登录</a>
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
                        <th>请假人</th>
                        <th>请假时间</th>
                        <th>请假天数</th>
                        <th>审核状态</th>
                    </tr>
                </c:if>
                <c:forEach items="${vacateList}" var="vacate">
                    <tr onclick="getVacateModal(this)" data="${vacate.postilReason}" vacate_id="${vacate.id}"
                        reason="${vacate.reason}" class="point">
                        <th>${vacate.user_name}</th>
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
            <%--<button type="button" class="btn btn-info" onclick="vacate()">请假</button>--%>
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
            <button type="button" class="btn btn-info" onclick="notice()">发布通告</button>
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
                                <h3>发布通告</h3>
                                <p>请编写通告详细内容</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-power-off" onclick="$('#myModal').modal('hide')"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form">
                                <div class="form-group">
                                    通告标题：<input type="text" id="notice_title" placeholder="标题"
                                                         class="form-username form-control">
                                </div>
                                <div class="form-group">
                                    通告内容：<textarea type="text" id="notice_content" placeholder="内容"
                                                   class="form-password form-control"></textarea>
                                </div>

                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-success" onclick="subNotice('all')">发给所有人</button>
                                    </div>
                                    <div class="btn-group " role="group">
                                        <button type="button" class="btn btn-danger" onclick="subNotice('department')">发给部门</button>
                                    </div>
                                </div>
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
                                <h3>请假申请</h3>
                                <h4 id="p_name"></h4>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-power-off" onclick="$('#vacateModal').modal('hide')"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" method="post" class="login-form">
                                <div class="form-group">
                                    请假理由：
                                   <textarea type="text" placeholder="理由..." id="reason"
                                             class="form-password form-control" disabled="disabled"></textarea>
                                </div>
                                <div class="form-group">
                                    批示说明：
                                   <textarea type="text" placeholder="说明..." id="postilReason"
                                             class="form-password form-control"></textarea>
                                </div>
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-success" onclick="vote(1)">同意</button>
                                    </div>
                                    <div class="btn-group " role="group">
                                        <button type="button" class="btn btn-danger" onclick="vote(0)">否决</button>
                                    </div>
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
<script src="/js/site.charge_page.js"></script>
</body>
</html>