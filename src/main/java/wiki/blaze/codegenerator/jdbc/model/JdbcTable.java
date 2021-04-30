package wiki.blaze.codegenerator.jdbc.model;

import lombok.Data;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author wangcy
 * @Date 2021/4/28 14:21
 */
@Data
public class JdbcTable {

    public String tableName;
    public String beanName;
    public String packagePref;
    public String comments;
    public JdbcColumn pkColumn;
    public List<JdbcColumn> jdbcColumns = new ArrayList<>();

    public JdbcTable(String tableName, String beanName, String packagePref) {
        this.tableName = tableName;
        this.beanName = beanName;
        this.packagePref = packagePref;
        this.comments = "";
    }

    public JdbcTable(String tableName, String beanName, String packagePref, String comments) {
        this.tableName = tableName;
        this.beanName = beanName;
        this.packagePref = packagePref;
        this.comments = comments != null ? comments : "";
    }

    public JdbcTable clone() {
        return clone(null);
    }

    public JdbcTable clone(String[] excludeColumns) {
        JdbcTable jdbcTable = new JdbcTable(this.tableName, this.beanName, this.packagePref, this.comments);
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

}
