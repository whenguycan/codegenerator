
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="modal-dialog" style="width:700px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${'$'}${'{'}head${'}'}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        测试字段
                    </div>
                    <div class="col-md-4">
                        <input id="e_requestTime" readonly="readonly" value="${'$'}${'{'}e.requestTime${'}'}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        创建时间
                    </div>
                    <div class="col-md-4">
                        <input id="e_createTime" readonly="readonly" value="${'$'}${'{'}e.createTime${'}'}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        修改时间
                    </div>
                    <div class="col-md-4">
                        <input id="e_changeTime" readonly="readonly" value="${'$'}${'{'}e.changeTime${'}'}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#e_createTime").val(formatDate($("#e_createTime").val()));
        $("#e_changeTime").val(formatDate($("#e_changeTime").val()));
    })

    function formatDate(data){
        var datetime = new Date(data);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
        var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
        var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
        var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    }
</script>