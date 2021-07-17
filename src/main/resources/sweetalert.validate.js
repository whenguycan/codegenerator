/*简易验证插件，基于sweetalert.js*/

/**
 * sweetalert简易必填验证
 * @param data 所有数据
 * @param setting 配置参数
 * @returns {boolean}
 */
function swalRequired(data, setting) {
    for(var k in setting) {
        if(data[k] == '' || data[k] == undefined || data[k].length == 0 || data[k] == null) {
            swal({
                title: setting[k],
                type: 'warning'
            });
            return false;
        }
    }
    return true;
};

/**
 * sweetalert简易电话号格式验证
 * @param field 字段值
 * @param msg 验证不通过信息
 * @returns {boolean}
 */
function swalValidateMobile(field, msg) {
    var reg = /^1[3456789]\d{9}$/;
    if(!reg.test(field)) {
        swal({
            title: msg,
            type: 'warning'
        });
        return false;
    }
    return true;
}

/**
 * sweetalert验证身份证号
 * @param field 字段值
 * @param msg 验证不通过信息
 * @param strong 开启强校验（true时开启，默认不开启）
 * @returns {boolean}
 */
function swalValidateIdCard(field, msg, strong) {
    var reg = /^\d{17}[\dX]$/;
    if(!reg.test(field)) {
        swal();
        return false;
    }
    if(strong == true) {
        var weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
        var mods = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"];
        var sum = 0;
        for(var i=0,len=weights.length; i<len; i++) {
            var c = field.charAt(i);
            sum += weights[i] * parseInt(c);
        }
        var rst = mods[sum % 11];
        if(rst != field.charAt(17)) {
            swal({
                title: msg,
                type: 'warning'
            });
            return false;
        }
    }
    return true;
}
