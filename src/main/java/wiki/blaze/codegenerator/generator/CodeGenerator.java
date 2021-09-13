package wiki.blaze.codegenerator.generator;

import wiki.blaze.codegenerator.jdbc.JdbcDriver;
import wiki.blaze.codegenerator.jdbc.model.JdbcTable;
import wiki.blaze.codegenerator.util.DateUtils;
import wiki.blaze.codegenerator.util.FreemarkerUtils;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 简单代码生成，Gmini系列 web项目使用
 * TODO Excel导入模块生成
 * @Author wangcy
 * @Date 2021/4/28 13:33
 */
public class CodeGenerator {

    public static String driverName = "";
    public static String url = "";
    public static String username = "";
    public static String password = "";

    String outputDir = "";

    String tableName = "";
    String beanName = "";
    String topPackageName = "";
    String topBusinessName = "";
    String packageName = "";
    String pathName = "";

    private boolean init = false;

    private CodeGenerator() {
    }

    public static CodeGenerator newInstance() {
        return new CodeGenerator();
    }

    public CodeGenerator tableName(String tableName) {
        this.tableName = tableName;
        return this;
    }

    public CodeGenerator beanName(String beanName) {
        this.beanName = beanName;
        return this;
    }

    public CodeGenerator packageName(String packageName) {
        this.packageName = packageName;
        return this;
    }

    public CodeGenerator pathName(String pathName) {
        this.pathName = pathName;
        return this;
    }

    public CodeGenerator topPackageName(String topPackageName) {
        this.topPackageName = topPackageName;
        return this;
    }

    public CodeGenerator topBusinessName(String topBusinessName) {
        this.topBusinessName = topBusinessName;
        return this;
    }

    public CodeGenerator setDatasource(String driverName, String url, String username, String password) {
        CodeGenerator.driverName = driverName;
        CodeGenerator.url = url;
        CodeGenerator.username = username;
        CodeGenerator.password = password;
        return this;
    }

    public CodeGenerator init() {
        outputDir = "H:\\_code_generate\\" + beanName + DateUtils.getTimestamp();
        new File(outputDir).mkdirs();
        init = true;
        return this;
    }

    final String excludeColumns = "CREATOR,CREATE_DEPT,CREATE_TIME,CHANGER,CHANGE_DEPT,CHANGE_TIME,VALID_FLAG";
    final String excludeColumnsAndID = "ID,CREATOR,CREATE_DEPT,CREATE_TIME,CHANGER,CHANGE_DEPT,CHANGE_TIME,VALID_FLAG";
    public void generate() {
        if(!init) {
            throw new RuntimeException("call init first");
        }
        System.out.println("---->generate start");
        try {
            String packagePref = topPackageName + "." + packageName;
            String pathPref = topBusinessName + "/" + pathName;
            JdbcTable jdbcTable = JdbcDriver.getSchemas(new JdbcTable(tableName, beanName, packagePref, pathPref, ""));
            generateBean(jdbcTable.clone(excludeColumns.split(",")));
            generateMapper(jdbcTable);
            generateDao(jdbcTable);
            generateService(jdbcTable);
            generateServiceImpl(jdbcTable);
            generateController(jdbcTable);
            generateJspEdit(jdbcTable.clone(excludeColumnsAndID.split(",")));
            generateJspList(jdbcTable.clone(excludeColumnsAndID.split(",")));
            generateJspView(jdbcTable.clone(excludeColumnsAndID.split(",")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("---->generate end path: " + outputDir);
        try {
            // 打开资源管理器文件夹
            Desktop.getDesktop().open(new File(outputDir));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    void generateBean(JdbcTable jdbcTable) {
        System.out.println("-->generate bean");
        generate(jdbcTable, "%s.java", "bean.ftl");
    }

    void generateMapper(JdbcTable jdbcTable) {
        System.out.println("-->generate mapper");
        generate(jdbcTable, "%sDao.xml", "mapper.ftl");
    }

    void generateDao(JdbcTable jdbcTable) {
        System.out.println("-->generate dao");
        generate(jdbcTable, "%sDao.java", "dao.ftl");
    }

    void generateService(JdbcTable jdbcTable) {
        System.out.println("-->generate service");
        generate(jdbcTable, "%sService.java", "service.ftl");
    }

    void generateServiceImpl(JdbcTable jdbcTable) {
        System.out.println("-->generate serviceImpl");
        generate(jdbcTable, "%sServiceImpl.java", "serviceImpl.ftl");
    }

    void generateController(JdbcTable jdbcTable) {
        System.out.println("-->generate controller");
        generate(jdbcTable, "%sController.java", "controller.ftl");
    }

    void generateJspEdit(JdbcTable jdbcTable) {
        System.out.println("-->generate edit");
        generate(jdbcTable, "%sEdit.jsp", "edit.ftl", true);
    }

    void generateJspList(JdbcTable jdbcTable) {
        System.out.println("-->generate list");
        generate(jdbcTable, "%sList.jsp", "list.ftl", true);
    }

    void generateJspView(JdbcTable jdbcTable) {
        System.out.println("-->generate view");
        generate(jdbcTable, "%sView.jsp", "view.ftl", true);
    }

    private void generate(JdbcTable jdbcTable, String targetNameFormatter, String templateName) {
        generate(jdbcTable, targetNameFormatter, templateName, false);
    }

    private void generate(JdbcTable jdbcTable, String targetNameFormatter, String templateName, boolean uncapFirst) {
        Map<String, Object> dataModel = new HashMap<>();
        dataModel.put("jdbcTable", jdbcTable);
        String beanName = jdbcTable.beanName;
        if(uncapFirst) {
            beanName = jdbcTable.beanName.substring(0, 1).toLowerCase() + jdbcTable.beanName.substring(1);
        }
        File output = new File(outputDir, String.format(targetNameFormatter, beanName));
        FreemarkerUtils.process(templateName, dataModel, output);
    }

}
