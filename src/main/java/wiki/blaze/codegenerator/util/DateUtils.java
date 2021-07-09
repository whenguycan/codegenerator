package wiki.blaze.codegenerator.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author wangcy
 * @date 2021/7/9 9:10
 */
public class DateUtils {

    public static String getTimestamp() {
        DateFormat df = new SimpleDateFormat("_yyyy_MM_dd_HH_mm_ss");
        return df.format(new Date());
    }

}
