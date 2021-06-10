package wiki.blaze.codegenerator.jdbc.model;

/**
 * @Author wangcy
 * @Date 2021/4/28 14:21
 */
public class JdbcColumn {

    public String tableName;
    public String columnName;
    public String columnCamelName;
    public String dataType;
    public String constraintType;
    public String comments;

    public JdbcColumn(String tableName, String columnName, String dataType, String constraintType, String comments) {
        this.tableName = tableName;
        this.columnName = columnName;
        this.columnCamelName = getCamelName();
        this.dataType = dataType;
        this.constraintType = constraintType;
        this.comments = comments != null ? comments : "";
    }

    String getCamelName() {
        String colName = this.columnName.toLowerCase();
        StringBuilder sb = new StringBuilder();
        boolean preIs_ = false;
        for(int i=0,len=colName.length(); i<len; i++) {
            char c = colName.charAt(i);
            if(c == '_') {
                preIs_ = true;
            }else {
                sb.append(preIs_ ? String.valueOf(c).toUpperCase() : c);
                preIs_ = false;
            }
        }
        return sb.toString();
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

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnCamelName() {
        return columnCamelName;
    }

    public void setColumnCamelName(String columnCamelName) {
        this.columnCamelName = columnCamelName;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getConstraintType() {
        return constraintType;
    }

    public void setConstraintType(String constraintType) {
        this.constraintType = constraintType;
    }

    public String getComments() {
        return comments;
    }
}
