/**
 * Created by Throws_exception on 2016/5/24.
 */
var vacate_id = '';

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

function notice() {
    $('#myModal').modal('show');
}

function getVacateModal(element) {
    var reason = $(element).attr('data');
    vacate_id = $(element).attr('vacate_id');
    var text = '申请人：'+$.trim($(element).find('th').eq(0).text())+'/'+
            '时间：'+$.trim($(element).find('th').eq(1).text())+'/'+
            '天数：'+$.trim($(element).find('th').eq(2).text());
    $("#p_name").text(text);
    $('#reason').val($(element).attr('reason'));
    $('#postilReason').val(reason);
    $('#vacateModal').modal('show');
}

function vote(flag) {
    var reason = $.trim($('#postilReason').val());
    if(reason.length == 0){
        swal('error','批示不能为空','error');
        return;
    }

    $.post(
        './postil.do',
        {
            postilReason:reason,
            id:vacate_id,
            postil:flag
        },
        function (data) {
          if(data == 1){
              swal('success','批复成功','success');
              setTimeout('window.location.reload();', 1500);
          }else {
              if(data == 400){
                  swal('warning','不能重复批复','warning')
              }else {
                  swal('error','批复失败','error');
              }

          }
        }
    )

}

function subNotice(range) {
    var title = $.trim($("#notice_title").val());
    var content = $.trim($("#notice_content").val());

    if(title.length == 0 || content.length == 0){
        swal('error','请首先完成通告编写','error');
        return;
    }

    $.post(
        './postNotice.do',
        {
            title:title,
            content:content,
            range:range
        },
        function (data) {
            if(data == 1){
                swal('success','通告发布成功','success');
            }else {
                swal('error','发布失败！','error');
            }
        }
    );

}

function showMyNotice(element) {
    
    $('#my_title').text($(element).find('th:first').text());
    $('#my_content').text($(element).attr('data'));
    
    $('#noticeModal').modal('show')
}