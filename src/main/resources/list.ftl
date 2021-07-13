
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                测试字段：
                            </div>
                            <div class="col-md-2">
                                <input id="s_requestTime" type="text" class="form-control" />
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <${'c'}${':'}if test="${'$'}${'{'}operate == 'edit'${'}'}">
                            <button type="button" class="btn btn-default btn-clean" onclick="add${jdbcTable.beanName}()">新增</button>
                            <br>
                        </${'c'}${':'}if>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="${jdbcTable.beanName?uncap_first}Grid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50${'%'};min-height: 10${'%'};"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<${'c'}${':'}choose>
    <${'c'}${':'}when test="${'$'}${'{'}operate == 'edit'${'}'}">
        <%@include file="operate.jsp"%>
    </${'c'}${':'}when>
    <${'c'}${':'}when test="${'$'}${'{'}operate == 'view'${'}'}">
        <%@include file="operateView.jsp"%>
    </${'c'}${':'}when>
</${'c'}${':'}choose>
<script>
    var ${jdbcTable.beanName?uncap_first}Table;
    $(document).ready(function () {
        search();
        ${jdbcTable.beanName?uncap_first}Table.on('click', 'tr a', function () {
            var data = ${jdbcTable.beanName?uncap_first}Table.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "edit${jdbcTable.beanName}") {
                $("#dialog").load("<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/edit${jdbcTable.beanName}?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "view${jdbcTable.beanName}") {
                $("#dialog").load("<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/view${jdbcTable.beanName}?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "del${jdbcTable.beanName}") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "" + name + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/del?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#${jdbcTable.beanName?uncap_first}Grid').DataTable().ajax.reload();
                        }else{
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        }
                    })
                });
            }
        });
    })

    function formatDate(data){
        if(data = null || data == undefined || data == '') {
            return '--';
        }
        var datetime = new Date();
        datetime.setDate(data);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
        var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
        var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
        var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    }

    function add${jdbcTable.beanName}() {
        $("#dialog").load("<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/add${jdbcTable.beanName}");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#s_requestTime").val("");
        search();
    }

    function search() {
        ${jdbcTable.beanName?uncap_first}Table = $("#${jdbcTable.beanName?uncap_first}Grid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/search',
                "data": {
                    requestTime: $("#s_requestTime").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "requestTime", "title": "测试字段"},
                {
                    "width": "10%",
                    "data": "createTime",
                    "title": "创建时间",
                    "render": function(data, type, row) {
                        return formatDate(data);
                    }
                },
                {
                    "width": "10%",
                    "data": "changeTime",
                    "title": "修改时间",
                    "render": function(data, type, row) {
                        return formatDate(data);
                    }
                },
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return getOperate();
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>