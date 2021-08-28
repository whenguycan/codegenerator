
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
<#list jdbcTable.jdbcColumns as column>
    <#if column?is_first>
                            <div class="col-md-1 tar">
                                ${column.comments}：
                            </div>
                            <div class="col-md-2">
                                <input id="s_${column.columnCamelName}" type="text" class="form-control" />
                            </div>
    </#if>
</#list>
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
            <#list jdbcTable.jdbcColumns as column>
                <#if column?is_first>
        $("#s_${column.columnCamelName}").val("");
                </#if>
            </#list>
        search();
    }

    function search() {
        ${jdbcTable.beanName?uncap_first}Table = $("#${jdbcTable.beanName?uncap_first}Grid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/${jdbcTable.beanName?uncap_first}/search',
                "data": {
                        <#list jdbcTable.jdbcColumns as column>
                            <#if column?is_first>
                    ${column.columnCamelName}: $("#s_${column.columnCamelName}").val()
                            </#if>
                        </#list>
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                    <#list jdbcTable.jdbcColumns as column>
                {"width": "10%", "data": "${column.columnCamelName}", "title": "${column.comments}"},
                    </#list>
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        var html = "";
                        <c:choose>
                            <c:when test="${'$'}${'{'}operate == 'edit'${'}'}">
                                html += "<a id='edit${jdbcTable.beanName}' class='icon-edit' title='修改'></a>";
                                html += "<a id='del${jdbcTable.beanName}' class='icon-trash' title='删除'></a>";
                            </c:when>
                            <c:when test="${'$'}${'{'}operate == 'view'${'}'}">
                                html += "<a id='view${jdbcTable.beanName}' class='icon-search' title='查看'></a>";
                            </c:when>
                        </c:choose>
                        return html;
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>