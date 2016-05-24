/**
 * Created by Throws_exception on 2016/5/20.
 */


function checkInput() {
    var input = $('input');
    for (var i = 0; i < input.length; i++) {
        if ($(input[i]).val().length == 0) return errorTip($(input[i]).prev().text());
    }
    var sex = $("#sex");
    if ($(sex).val() != '男' && $(sex).val() != '女')return errorTip('性别');
    if (isNaN($("#age").val())) return errorTip('年龄');
    if (isNaN($("#cellphone").val())) return errorTip('手机');
    if (isNaN($("#base_wage").val())) return errorTip('基本工资');
    // console.log($("#submit").attr('data')+'++++++=');
    if ($("#submit").attr('data').length == 0) return errorTip('职位');
    return true;
}

$("#submit").bind('click', function submit() {
    var account = eval('({})');
    if (checkInput()) {
        $("input").each(function () {
            console.log($(this).attr('id')+'+++++id');
            console.log( $(this).val()+'++++++++val');
            account[$(this).attr('id')] = $(this).val();
        });
        account['level'] = $("#submit").attr('data');
        account['sex'] = account['sex'] == '男'?1:0;
        console.log(account);
        $.post(
            './createAccount.do',
            {account:JSON.stringify(account)},
            function (data) {
                if(data == 1){
                    swal('success','账户添加成功！','success');
                    setTimeout('location.reload()',1500);
                }else {
                    swal('error','账户添加失败','error');
                }
            }
        );

    }
});

function setLevel(element) {
    // console.log($(element).text());
    $(element).text() == '部门员工' ? $("#submit").attr('data', 1) : $("#submit").attr('data', 2);
}

function errorTip(value) {
    swal('error', value + '填写出错！', 'error');
    return false;
}


