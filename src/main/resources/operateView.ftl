
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
function getOperate() {
    var html = "";
    html += "<a id='view${jdbcTable.beanName}' class='icon-search' title='修改'></a>&nbsp;&nbsp;&nbsp;";
    return html;
}
</script>