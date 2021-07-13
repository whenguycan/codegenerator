package wiki.blaze.codegenerator.jdbc.model;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author wangcy
 * @Date 2021/4/28 14:21
 */
public class JdbcTable {

    public String tableName;
    public String beanName;
    public String packagePref;
    public String pathPref;
    public String comments;
    public JdbcColumn pkColumn;
    public List<JdbcColumn> jdbcColumns = new ArrayList<>();

    public JdbcTable(String tableName, String beanName, String packagePref, String pathPref, String comments) {
        this.tableName = tableName;
        this.beanName = beanName;
        this.packagePref = packagePref;
        this.pathPref = pathPref;
        this.comments = comments != null ? comments : "";
    }

    public JdbcTable clone() {
        return clone(null);
    }

    public JdbcTable clone(String[] excludeColumns) {
        JdbcTable jdbcTable = new JdbcTable(this.tableName, this.beanName, this.packagePref, this.pathPref, this.comments);
        JdbcColumn pk = this.pkColumn;
        jdbcTable.pkColumn = new JdbcColumn(pk.tableName, pk.columnName, pk.dataType, pk.constraintType, pk.comments);
        Set<String> excludes = new HashSet<>();
        if(excludeColumns != null && excludeColumns.length != 0) {
            excludes.addAll(Arrays.stream(excludeColumns).collect(Collectors.toSet()));
        }
        this.jdbcColumns.forEach(jdbcColumn -> {
            if(!excludes.contains(jdbcColumn.columnName)) {
                JdbcColumn c = jdbcColumn;
                jdbcTable.jdbcColumns.add(new JdbcColumn(c.tableName, c.columnName, c.dataType, c.constraintType, c.comments));
            }
        });
        return jdbcTable;
    }

    public void setComments(String comments) {
        this.comments = comments != null ? comments : "";
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getBeanName() {
        return beanName;
    }

    public void setBeanName(String beanName) {
        this.beanName = beanName;
    }

    public String getPackagePref() {
        return packagePref;
    }

    public void setPackagePref(String packagePref) {
        this.packagePref = packagePref;
    }

    public String getComments() {
        return comments;
    }

    public JdbcColumn getPkColumn() {
        return pkColumn;
    }

    public void setPkColumn(JdbcColumn pkColumn) {
        this.pkColumn = pkColumn;
    }

    public List<JdbcColumn> getJdbcColumns() {
        return jdbcColumns;
    }

    public void setJdbcColumns(List<JdbcColumn> jdbcColumns) {
        this.jdbcColumns = jdbcColumns;
    }

    public String getPathPref() {
        return pathPref;
    }

    public void setPathPref(String pathPref) {
        this.pathPref = pathPref;
    }
}
