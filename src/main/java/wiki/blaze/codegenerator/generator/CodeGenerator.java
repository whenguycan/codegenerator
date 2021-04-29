package wiki.blaze.codegenerator.generator;

import wiki.blaze.codegenerator.jdbc.JdbcDriver;
import wiki.blaze.codegenerator.jdbc.model.JdbcTable;
import wiki.blaze.codegenerator.util.FreemarkerUtils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * 简单代码生成，项目使用
 * @Author wangcy
 * @Date 2021/4/28 13:33
 */
public class CodeGenerator {

    static final String OUTPUT_DIR = "C:\\_git_repo\\codegenerate";

    static final String TABLE_NAME = "T_XG_VISITOR";
    static final String BEAN_NAME = "Visitor";
    static final String PACKAGE_PREF = "com.goisan.studentwork.visitor";

    private CodeGenerator() {}

    public static CodeGenerator newInstance() {
        return new CodeGenerator();
    }

    final String excludeColumns = "CREATOR,CREATE_DEPT,CREATE_TIME,CHANGER,CHANGE_DEPT,CHANGE_TIME,VALID_FLAG";
    public void generate() {
        System.out.println("---->generate start");
        try {
            JdbcTable jdbcTable = JdbcDriver.getSchemas(new JdbcTable(TABLE_NAME, BEAN_NAME, PACKAGE_PREF));
            generateBean(jdbcTable.clone(excludeColumns.split(",")));
            generateMapper(jdbcTable);
            generateDao(jdbcTable);
            generateService(jdbcTable);
            generateServiceImpl(jdbcTable);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("---->generate end path: " + OUTPUT_DIR);
    }

    void generateBean(JdbcTable jdbcTable) {
        System.out.println("-->generate bean");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(OUTPUT_DIR, String.format("%s.java", jdbcTable.beanName));
        FreemarkerUtils.process("bean.ftl", dataModel, output);
    }

    void generateMapper(JdbcTable jdbcTable) {
        System.out.println("-->generate mapper");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(OUTPUT_DIR, String.format("%sDao.xml", jdbcTable.beanName));
        FreemarkerUtils.process("mapper.ftl", dataModel, output);
    }

    void generateDao(JdbcTable jdbcTable) {
        System.out.println("-->generate dao");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(OUTPUT_DIR, String.format("%sDao.java", jdbcTable.beanName));
        FreemarkerUtils.process("dao.ftl", dataModel, output);
    }

    void generateService(JdbcTable jdbcTable) {
        System.out.println("-->generate service");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(OUTPUT_DIR, String.format("%sService.java", jdbcTable.beanName));
        FreemarkerUtils.process("service.ftl", dataModel, output);
    }

    void generateServiceImpl(JdbcTable jdbcTable) {
        System.out.println("-->generate serviceImpl");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(OUTPUT_DIR, String.format("%sServiceImpl.java", jdbcTable.beanName));
        FreemarkerUtils.process("serviceImpl.ftl", dataModel, output);
    }

}
