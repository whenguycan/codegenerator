package wiki.blaze.codegenerator.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.*;

/**
 * @Author wangcy
 * @Date 2021/4/28 15:48
 */
public class FreemarkerUtils {

    public static void process(String templateName, Map<String, Object> dataModel, File output) {
        dataModel.put("author", "wangcy");
        dataModel.put("date", new Date());
        Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        configuration.setClassLoaderForTemplateLoading(ClassLoader.getSystemClassLoader(), "");
        try {
            Template template = configuration.getTemplate(templateName, "UTF-8");
            Writer writer = new FileWriter(output);
            template.process(dataModel, writer);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }

}
