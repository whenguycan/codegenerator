
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <span class="iconBtx">*</span>测试字段
                    </div>
                    <div class="col-md-4">
                        <input id="e_requestTime" value="${'$'}${'{'}e.requestTime${'}'}" placeholder="测试字段">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save${jdbcTable.beanName}()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="e_id" value="${'$'}${'{'}e.id${'}'}" hidden />
<script>
    $("${'#'}layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $("#e_requestTime").focus();
    });
    function save${jdbcTable.beanName}() {
        var data = {};
        var setting = {
            requestTime: '请填写测试字段！'
        };
        data.id = $("#e_id").val();
        data.requestTime = $("#e_requestTime").val();
        for(var k in setting) {
            var v = data[k];
            if(v == undefined || v == '') {
                swal({
                    title: setting[k],
                    type: 'warning'
                });
                return;
            }
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/save", data, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#${jdbcTable.beanName?uncap_first}Grid').DataTable().ajax.reload();
            }
        });
    }
</script>