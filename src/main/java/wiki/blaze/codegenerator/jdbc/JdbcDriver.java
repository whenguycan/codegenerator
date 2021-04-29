package wiki.blaze.codegenerator.jdbc;

import wiki.blaze.codegenerator.jdbc.model.JdbcColumn;
import wiki.blaze.codegenerator.jdbc.model.JdbcTable;
import wiki.blaze.codegenerator.util.PropertyUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author wangcy
 * @Date 2021/4/28 13:53
 */
public class JdbcDriver {

    static final String driverName = PropertyUtils.getString("jdbc.driver");
    static final String url = PropertyUtils.getString("jdbc.url");
    static final String username = PropertyUtils.getString("jdbc.username");
    static final String password = PropertyUtils.getString("jdbc.password");

    static {
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url, username, password);
    }

    public static JdbcTable getSchemas(JdbcTable model) throws Exception {
        Connection conn = getConnection();
        JdbcTable jdbcTable = getTableSchemas(model, conn);
        List<JdbcColumn> jdbcColumnList = getColumnSchemas(model, conn);
        for (JdbcColumn jdbcColumn : jdbcColumnList) {
            if("P".equals(jdbcColumn.getConstraintType())) {
                jdbcTable.setPkColumn(jdbcColumn);
                break;
            }
        }
        jdbcTable.jdbcColumns.addAll(jdbcColumnList);
        conn.close();
        return jdbcTable;
    }

    static JdbcTable getTableSchemas(JdbcTable model, Connection conn) throws Exception {
        JdbcTable jdbcTable = null;
        String fmtSql = "select table_name,comments from user_tab_comments where table_name = '%s'";
        String sql = String.format(fmtSql, model.tableName);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        if(rs.next()) {
            jdbcTable = new JdbcTable(
                model.tableName,
                model.beanName,
                model.packagePref,
                rs.getString("comments")
            );
        }
        rs.close();
        stmt.close();
        return jdbcTable;
    }

    static List<JdbcColumn> getColumnSchemas(JdbcTable model, Connection conn) throws Exception {
        List<JdbcColumn> columnList = new ArrayList<>();
        String fmtSql = "select tcols.table_name,tcols.column_name,comm.comments,tcols.data_type,ccons.constraint_type " +
                "from user_tab_columns tcols " +
                "left join user_col_comments comm on tcols.column_name = comm.column_name and tcols.table_name = comm.table_name " +
                "left join (" +
                    "select cons.table_name,cons.constraint_type,ccols.column_name " +
                    "from user_constraints cons " +
                    "left join user_cons_columns ccols " +
                    "on cons.table_name = ccols.table_name and cons.constraint_name = ccols.constraint_name " +
                    "where cons.constraint_type = 'P'" +
                ") ccons " +
                "on tcols.table_name = ccons.table_name and tcols.column_name = ccons.column_name " +
                "where tcols.table_name = '%s'" +
                "order by tcols.column_id";
        String sql = String.format(fmtSql, model.tableName);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
            columnList.add(new JdbcColumn(
                rs.getString("table_name"),
                rs.getString("column_name"),
                rs.getString("data_type"),
                rs.getString("constraint_type"),
                rs.getString("comments"))
            );
        }
        rs.close();
        stmt.close();
        return columnList;
    }

}
