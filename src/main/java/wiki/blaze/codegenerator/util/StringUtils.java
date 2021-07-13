package wiki.blaze.codegenerator.util;

/**
 * @author wangcy
 * @date 2021/7/12 13:46
 */
public class StringUtils {

    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    public static boolean isAnyEmpty(String... strs) {
        if(strs == null || strs.length == 0) {
            return true;
        }
        for (String str : strs) {
            if(isEmpty(str)) {
                return true;
            }
        }
        return false;
    }

}
