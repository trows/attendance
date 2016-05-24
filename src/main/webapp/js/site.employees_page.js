/**
 * Created by Throws_exception on 2016/5/24.
 */
function submitChange() {
    var origin = $("#origin").val();
    var change = $("#change").val();
    if(origin == change){
        swal('error','修改后的密码不能与原密码相同','error');
        return;
    }
    $.post(
        './changePassword.do',
        {
            origin:origin,
            change:change
        },
        function (data, status) {
            if(data == 1){
                sweetAlert('success','密码修改成功！','success');
            }else {
                sweetAlert('error','密码修改失败！','error');
            }
        }
    )
}

function punch() {
    var date = new Date();
    var hour = date.getHours();
    var min = date.getMinutes();
    if(hour >=7 && hour<=8){
        if(hour == 8 && min>0){
            noTime();
            return;
        }else {
            postPunch(1);
            return
        }
    }

    if(hour>=18 && hour<=21){
        if(hour == 21 && min>0){
            noTime();
            return;
        }else {
            postPunch(2);
            return
        }
    }
}

function noTime() {
    swal("error","现在不是打卡时间",'error');
}

function postPunch(flag) {
    $.post(
        './punch.do',
        {
            flag:flag
        },
        function (data) {
            if(data == 1){
                swal('success','您已成功打卡','success');
            }else {
                if(data == 0){
                    swal('warning','您已打过卡','warning');
                }
            }
        }
    )
}