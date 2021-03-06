/**
 * Created by Throws_exception on 2016/5/24.
 */
function submitChange() {
    var origin = $("#origin").val();
    var change = $("#change").val();
    if (origin == change) {
        swal('error', '修改后的密码不能与原密码相同', 'error');
        return;
    }
    $.post(
        './changePassword.do',
        {
            origin: origin,
            change: change
        },
        function (data, status) {
            if (data == 1) {
                sweetAlert('success', '密码修改成功！', 'success');
            } else {
                sweetAlert('error', '密码修改失败！', 'error');
            }
        }
    )
}

function punch() {
    var date = new Date();
    var hour = date.getHours();
    var min = date.getMinutes();
    if (hour >= 7 && hour <= 8) {
        if (hour == 8 && min > 0) {
            noTime();
            return;
        } else {
            postPunch(1);
            return
        }
    }

    if (hour >= 18 && hour <= 21) {
        if (hour == 21 && min > 0) {
            noTime();
            return;
        } else {
            postPunch(2);
            return
        }
    }
    noTime();
}

function noTime() {
    swal("error", "现在不是打卡时间", 'error');
}

function postPunch(flag) {
    $.post(
        './punch.do',
        {
            flag: flag
        },
        function (data) {
            if (data == 1) {
                swal('success', '您已成功打卡', 'success');
            } else {
                if (data == 0) {
                    swal('warning', '您已打过卡', 'warning');
                }
            }
        }
    )
}

function vacate() {
    $('#myModal').modal('show');
}

function getDaysInOneMonth(year, month){
    month = parseInt(month, 10);
    var d= new Date(year, month, 0);
    return d.getDate();
}

function subVacate() {
    var date = $("#vacate_date").val();
    var num = $("#vacate_num").val();
    var desc = $("#vacate_reason").val();

    var now = new Date();
    var dateStr = date.split('-');
    console.log(now.getUTCFullYear());
    console.log(now.getMonth());

    var monthDate = getDaysInOneMonth(now.getUTCFullYear(),now.getMonth()+1);

    console.log(parseInt(dateStr[0]));
    console.log(parseInt(dateStr[1]));
    console.log(parseInt(dateStr[2])+parseInt(num));
    console.log();

    if (date.length == 0 || isNaN(num) || num.length == 0 || desc.length == 0) {
        swal('error', '请假申请填写有误', 'error');
        return;
    }


    if(parseInt(dateStr[0])!=now.getUTCFullYear() || parseInt(dateStr[1])!=now.getMonth()+1 || (parseInt(dateStr[2])+parseInt(num))>monthDate){
        swal('error','只能申请当月假期','error');
        return;
    }



    if(parseInt(dateStr[2])<now.getDate()){
        swal('error','请假日期必须在当前日期之后','error');
        return;
    }

    $.post(
        './vacate.do',
        {
            start_time: date,
            day_num: num,
            reason: desc
        },
        function (data) {
            if(data == 1){
                swal('success','请假申请提交成功','success');
                $('#myModal').modal('hide');
            }else {
                swal('error','请假申请提交失败','error');
                $('#myModal').modal('hide');
            }
        }
    )
}

function getVacateModal(element) {
    var reason = $(element).attr('data');
    console.log(reason+'reason');
    console.log(reason.length);
    if(reason.length == 0) reason = '请假申请未审核！';
    $('#reason').val(reason);
    $('#vacateModal').modal('show');
}

function showMyNotice(element) {

    $('#my_title').text($(element).find('th:first').text());
    $('#my_content').text($(element).attr('data'));

    $('#noticeModal').modal('show')
}