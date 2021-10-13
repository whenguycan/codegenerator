package ${jdbcTable.packagePref}.controller;

import ${jdbcTable.packagePref}.bean.${jdbcTable.beanName};
import ${jdbcTable.packagePref}.service.${jdbcTable.beanName}Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonMessage;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

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

    /**
     * 跳转到列表页
     */
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/${jdbcTable.beanName?uncap_first}List")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}List");
        mv.addObject("operate", "edit");
        return mv;
    }

    /**
    * 条件查询
    */
    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/search")
    public Object search(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}, String draw, Integer start, Integer length) {
        int pageNo = start / length + ;
        int pageSize = length;
        PageHelper.startPage(pageNo, pageSize);
        List<${jdbcTable.beanName}> list = ${jdbcTable.beanName?uncap_first}Service.getListSearch(${jdbcTable.beanName?uncap_first});
        PageInfo<${jdbcTable.beanName}> info = new PageInfo<>(list);
        Map${'<'}String, Object> map = new HashMap<>();
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", info.getList());
        return map;
    }

    /**
     * 跳转到新增页
     */
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/toAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}Edit");
        mv.addObject("head", "新增");
        mv.addObject("e", new ${jdbcTable.beanName}());
        return mv;
    }

    /**
     * 跳转到修改页
     */
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/toEdit")
    public ModelAndView toEdit(String id) {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}Edit");
        mv.addObject("head", "修改");
        mv.addObject("e", ${jdbcTable.beanName?uncap_first}Service.getById(id));
        return mv;
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/save")
    public JsonMessage save(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        if(!StringUtils.hasText(${jdbcTable.beanName?uncap_first}.getId())) {
            ${jdbcTable.beanName?uncap_first}.setCreator(CommonUtil.getPersonId());
            ${jdbcTable.beanName?uncap_first}Service.insert(${jdbcTable.beanName?uncap_first});
            return JsonMessage.success("新增成功！");
        }else {
            ${jdbcTable.beanName?uncap_first}.setChanger(CommonUtil.getPersonId());
            ${jdbcTable.beanName?uncap_first}Service.update(${jdbcTable.beanName?uncap_first});
            return JsonMessage.success("修改成功！");
        }
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/del")
    public JsonMessage del(String id) {
        ${jdbcTable.beanName?uncap_first}Service.deleteById(id);
        return JsonMessage.success("删除成功！");
    }

    /**
     * 跳转到查看列表页
     */
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/${jdbcTable.beanName?uncap_first}ViewList")
    public ModelAndView toViewList() {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}List");
        mv.addObject("operate", "view");
        return mv;
    }

    /**
     * 查看
     */
    @RequestMapping("/${jdbcTable.beanName?uncap_first}/toView")
    public ModelAndView toView(String id) {
        ModelAndView mv = new ModelAndView("/${jdbcTable.pathPref}/${jdbcTable.beanName?uncap_first}View");
        mv.addObject("head", "查看");
        mv.addObject("e", ${jdbcTable.beanName?uncap_first}Service.getById(id));
        return mv;
    }
}