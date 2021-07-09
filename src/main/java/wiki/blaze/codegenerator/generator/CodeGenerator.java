package wiki.blaze.codegenerator.generator;

import wiki.blaze.codegenerator.jdbc.JdbcDriver;
import wiki.blaze.codegenerator.jdbc.model.JdbcTable;
import wiki.blaze.codegenerator.util.DateUtils;
import wiki.blaze.codegenerator.util.FreemarkerUtils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * 简单代码生成，web项目使用
 * @Author wangcy
 * @Date 2021/4/28 13:33
 */
public class CodeGenerator {

    public static void main(String[] args) {
        CodeGenerator.newInstance()
                .init("T_ZW_SIMULATOR", "Simulator", "com.goisan.logistics.simulator")
                .generate();
    }

    public static final String driverName = "oracle.jdbc.driver.OracleDriver";
    public static final String url = "jdbc:oracle:thin:@192.168.2.252:1521:orcl";
//    public static final String username = "slszyzz_200507";
//    public static final String password = "slszyzz_200507";
    public static final String username = "goisan_hunger";
    public static final String password = "hunger";

    String OUTPUT_DIR = "C:\\_git_repo\\code_generate";

    String TABLE_NAME = "";
    String BEAN_NAME = "";
    String PACKAGE_PREF = "";

    private CodeGenerator() {
    }

    public static CodeGenerator newInstance() {
        return new CodeGenerator();
    }

    public CodeGenerator init(String tableName, String beanName, String packagePref) {
        this.TABLE_NAME = tableName;
        this.BEAN_NAME = beanName;
        this.PACKAGE_PREF = packagePref;
        OUTPUT_DIR = "C:\\_git_repo\\code_generate\\" + beanName + DateUtils.getTimestamp();
        new File(OUTPUT_DIR).mkdirs();
        return this;
    }

    File getBeanDir() {
        File file = new File(OUTPUT_DIR, "bean");
        file.mkdirs();
        return file;
    }

    File getDaoDir() {
        File file = new File(OUTPUT_DIR, "dao");
        file.mkdirs();
        return file;
    }

    File getServiceDir() {
        File file = new File(OUTPUT_DIR, "service");
        file.mkdirs();
        return file;
    }

    File getServiceImplDir() {
        File file = new File(OUTPUT_DIR, "service\\impl");
        file.mkdirs();
        return file;
    }

    File getControllerDir() {
        File file = new File(OUTPUT_DIR, "controller");
        file.mkdirs();
        return file;
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
            generateController(jdbcTable);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("---->generate end path: " + OUTPUT_DIR);
    }

    void generateBean(JdbcTable jdbcTable) {
        System.out.println("-->generate bean");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(getBeanDir(), String.format("%s.java", jdbcTable.beanName));
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
        File output = new File(getDaoDir(), String.format("%sDao.java", jdbcTable.beanName));
        FreemarkerUtils.process("dao.ftl", dataModel, output);
    }

    void generateService(JdbcTable jdbcTable) {
        System.out.println("-->generate service");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(getServiceDir(), String.format("%sService.java", jdbcTable.beanName));
        FreemarkerUtils.process("service.ftl", dataModel, output);
    }

    void generateServiceImpl(JdbcTable jdbcTable) {
        System.out.println("-->generate serviceImpl");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(getServiceImplDir(), String.format("%sServiceImpl.java", jdbcTable.beanName));
        FreemarkerUtils.process("serviceImpl.ftl", dataModel, output);
    }

    void generateController(JdbcTable jdbcTable) {
        System.out.println("-->generate controller");
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        File output = new File(getControllerDir(), String.format("%sController.java", jdbcTable.beanName));
        FreemarkerUtils.process("controller.ftl", dataModel, output);
    }

}
