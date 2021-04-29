package ${jdbcTable.packagePref}.bean;

import com.goisan.system.bean.BaseBean;

/**
 * ${jdbcTable.comments} 实体
 *
 * @author ${author}
 * @since ${date?string("yyyy-MM-dd HH:mm:ss")}
 */
public class ${jdbcTable.beanName} extends BaseBean {

<#list jdbcTable.jdbcColumns as column>
    /*${column.comments}*/
    private String ${column.columnCamelName};
</#list>

<#list jdbcTable.jdbcColumns as column>
    public String get${column.columnCamelName?cap_first} {
        return ${column.columnCamelName};
    }
    public void set${column.columnCamelName?cap_first}(String ${column.columnCamelName}) {
        this.${column.columnCamelName} = ${column.columnCamelName};
    }
</#list>

}
