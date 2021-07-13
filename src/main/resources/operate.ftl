
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
function getOperate() {
    var html = "";
    html += "<a id='edit${jdbcTable.beanName}' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;";
    html += "<a id='del${jdbcTable.beanName}' class='icon-trash' title='删除'></a>";
    return html;
}
</script>