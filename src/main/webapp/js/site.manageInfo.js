window.onload = function () {
    // $("#myButton").hide();
}

var pubTr;
var pubClass;

// 填充模态框内容
function showModal(tr) {
    pubTr = tr;
    var jsonData = eval("(" + tr.getAttribute('data') + ")");
    var list = $("input");
    list[1].value = jsonData.account_id;
    list[2].value = jsonData.department;
    list[3].value = jsonData.user_name;
    list[4].value = jsonData.sex ? '男' : '女';
    list[5].value = jsonData.email;
    list[6].value = jsonData.cellphone;
    $('#myModal').modal({backdrop: 'static', keyboard: true});
}

// 修改单个用户信息
function edit() {


    var subData = eval("({})");
    // console.log(pubTr.getAttribute('data'));
    // console.log(JSON.stringify(perData));
    var list = $("input");

    var length = list.length;
    for(var i=1;i<length;i++){
        subData[$(list[i]).attr('placeholder')] = $(list[i]).val();
    }

    if(subData.sex == '男'){
        subData.sex = 1;
    }else {
        subData.sex = 0;
    }

    sweetAlert({
        title: '确认提交此次修改？',
        text: '此操作将不可撤销',
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "取消",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "确认修改",
        closeOnConfirm: true
    }, function () {
        // console.log(JSON.stringify(subData));
        $.post("./updateAccount.do",
            {data: JSON.stringify(subData)},
            function (data, status) {
                if (data == 1 && check(data, status)) {

                    var htm = '<th>' + subData.account_id + '</th>' +
                        '<th>' + subData.department + '</th>' +
                        '<th>' + subData.user_name + '</th>';
                    $(pubTr).empty();
                    $(pubTr).attr("data",JSON.stringify(subData));
                    $(pubTr).append(htm);
                    abandon();
                } else {
                    sweetAlert("error", "修改失败", "error");
                }

            }
        );
    });
}

//放弃修改
function abandon() {
    $('#myModal').modal('hide');
}


//搜索方法
function aim() {
    var inputText = $("input:first").val();
    if (inputText.length == 0) {
        setTimeout('sweetAlert("warning", "输入不能为空！", "warning")',100);
        return;
    }

    $.post(
        './getDepartment.do',
        {department: inputText},
        function (data, status) {
            if (check(data, status)) {
                console.log(data);
                if (data == "[]") {
                    sweetAlert('NOT FOUND', '未找到 : ' + inputText + '\n相关的信息', "info");
                } else {
                    createTable(data);
                }
            }
        });
}

function createTable(data) {
    // console.log(data);
    $("#myButton").empty();
    $("#tip").hide(1000);
    var table = $("table:first");
    table.empty();
    var title = '<tr>' +
        '<th class="tableTitle">工号</th>' +
        '<th class="tableTitle">部门</th>' +
        '<th class="tableTitle">姓名</th>' +
        '</tr>';
    table.append(title);
    var list = eval("(" + data + ")");
    var length = list.length;
    for (var i = 0; i < length; i++) {
        // console.log(list[i]);
        var tr = '<tr onclick=showModal(this) data = \'' + JSON.stringify(list[i]) + '\'>' +
            '<th>' + list[i].account_id + '</th>' +
            '<th>' + list[i].department + '</th>' +
            '<th>' + list[i].user_name + '</th>' +
            '</tr>';
        table.append(tr);
    }

}

//键盘事件，按下回车发起搜索
$(document).keydown(function (event) {
    // console.log(event.keyCode)
    if (event.keyCode == 13) {
        aim();
    }
});

//删除单条数据
function delThis() {
    var jsonData = eval("(" + pubTr.getAttribute('data') + ")");
    sweetAlert({
        title: '确认删除账户：' + jsonData.user_name + '?',
        text: "您将删除与此账户相关的所有数据！请谨慎操作",
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "取消",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        closeOnConfirm: true
    }, function () {
        $.post("./delAccount.do",
            {account_id: jsonData.account_id},
            function (data, status) {
                if (data == "1" && check(data, status)) {
                    abandon();
                    $(pubTr).hide(1000);
                    setTimeout('pubTr.remove()', 1000);
                    setTimeout("checkDataArea()",1100);
                } else {
                    sweetAlert("error", "删除失败", "error");
                }

            }
        );
    });
}
//请求返回校验
function check(data, status) {
    if (data == "logout") {
        sweetAlert("logout", "由于长时间未操作，系统已自动退出，请刷新页面重新登陆！", "error");
        return false;
    }

    if (status != "success") {
        sweetAlert("error", "系统出错，请刷新页面重试或联系开发人员", "error");
        return false;
    }

    return true;
}

// 检测table是否存在数据
function checkDataArea() {
    if (document.getElementsByTagName('tr').length < 2) {
        $("#myButton").empty();
        $("table:first").empty();
        $("#tip").show(1000);
    }
}

function resetPassword() {
    var jsonData = eval("(" + pubTr.getAttribute('data') + ")");
    sweetAlert({
        title: '确认重置' + jsonData.user_name + '的密码?',
        text: "密码将会被重置为默认密码，请重新登陆并及时修改密码",
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "取消",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "",
        closeOnConfirm: false
    }, function () {
        $.post("./resetPassword.do",
            {account_id: jsonData.account_id},
            function (data, status) {
                // console.log(data,status);
                if (data == "1" && check(data, status)) {
                    abandon();
                    swal("成功",
                        jsonData.user_name + '的密码已经重置成功！',
                        "success");
                } else {
                    sweetAlert("error", "密码重置失败", "error");
                }

            }
        );
    });
}

function promote(){
    var account_id = $("#account_id").val();
    $.post(
        './promote.do',
        {account_id:account_id},
        function (data) {
            if(data == 1){
                swal('success','账户'+account_id+'已经提升为主管','success')
            }else {
                swal('error','权限提升失败','error');
            }
        }
    )
}