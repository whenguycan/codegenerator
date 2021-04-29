package wiki.blaze.codegenerator.util;

import java.util.Properties;

/**
 * @Author wangcy
 * @Date 2021/4/28 13:21
 */
public class PropertyUtils {

    public static Properties properties = new Properties();

    static {
        try {
            properties.load(ClassLoader.getSystemResourceAsStream("config.properties"));
        }catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public static String getString(String key) {
        return properties.getProperty(key);
    }

    public static int getInt(String key) {
        return Integer.parseInt(properties.getProperty(key));
    }

}
