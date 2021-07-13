package ${jdbcTable.packagePref}.controller;

import ${jdbcTable.packagePref}.bean.${jdbcTable.beanName};
import ${jdbcTable.packagePref}.service.${jdbcTable.beanName}Service;
import com.goisan.system.tools.JsonMessage;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * ${jdbcTable.comments} 控制层
 *
 * @author ${author}
 * @date ${date?string("yyyy-MM-dd HH:mm:ss")}
 */
@Controller
public class ${jdbcTable.beanName}Controller {

    @Resource
    ${jdbcTable.beanName}Service ${jdbcTable.beanName?uncap_first}Service;

    @RequestMapping("/${jdbcTable.beanName?uncap_first}/list${jdbcTable.beanName}")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}/list${jdbcTable.beanName}");
        mv.addObject("operate", "edit");
        return mv;
    }

    @RequestMapping("/${jdbcTable.beanName?uncap_first}/add${jdbcTable.beanName}")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}/edit${jdbcTable.beanName}");
        mv.addObject("head", "新增");
        mv.addObject("e", new ${jdbcTable.beanName}());
        return mv;
    }

    @RequestMapping("/${jdbcTable.beanName?uncap_first}/edit${jdbcTable.beanName}")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}/edit${jdbcTable.beanName}");
        mv.addObject("head", "修改");
        mv.addObject("e", ${jdbcTable.beanName?uncap_first}Service.getById(id));
        return mv;
    }

    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/search")
    public JsonMessage search(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        List<${jdbcTable.beanName}> list = ${jdbcTable.beanName?uncap_first}Service.getListSearch(${jdbcTable.beanName?uncap_first});
        return JsonMessage.success("", list);
    }

    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/save")
    public JsonMessage save(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        if(!StringUtils.hasText(${jdbcTable.beanName?uncap_first}.getId())) {
            ${jdbcTable.beanName?uncap_first}Service.insert(${jdbcTable.beanName?uncap_first});
            return JsonMessage.success("新增成功！");
        }else {
            ${jdbcTable.beanName?uncap_first}Service.update(${jdbcTable.beanName?uncap_first});
            return JsonMessage.success("修改成功！");
        }
    }

    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/del")
    public JsonMessage del(String id) {
        ${jdbcTable.beanName?uncap_first}Service.deleteById(id);
        return JsonMessage.success("删除成功！");
    }

    @RequestMapping("/${jdbcTable.beanName?uncap_first}/list${jdbcTable.beanName}View")
    public ModelAndView toViewList() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}/list${jdbcTable.beanName}");
        mv.addObject("operate", "view");
        return mv;
    }

    @RequestMapping("/${jdbcTable.beanName?uncap_first}/view${jdbcTable.beanName}")
    public ModelAndView toView(String id) {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}/view${jdbcTable.beanName}");
        mv.addObject("head", "查看");
        mv.addObject("e", ${jdbcTable.beanName?uncap_first}Service.getById(id));
        return mv;
    }
}