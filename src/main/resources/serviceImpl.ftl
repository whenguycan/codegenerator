package ${jdbcTable.packagePref}.service.impl;

import ${jdbcTable.packagePref}.bean.${jdbcTable.beanName};
import ${jdbcTable.packagePref}.dao.${jdbcTable.beanName}Dao;
import ${jdbcTable.packagePref}.service.${jdbcTable.beanName}Service;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * ${jdbcTable.comments} 服务实现类
 *
 * @author ${author}
 * @date ${date?string("yyyy-MM-dd HH:mm:ss")}
 */
@Service
public class ${jdbcTable.beanName}ServiceImpl implements ${jdbcTable.beanName}Service {

    @Resource
    private ${jdbcTable.beanName}Dao ${jdbcTable.beanName?uncap_first}Dao;

    /**通过ID查询单条数据*/
    @Override
    public ${jdbcTable.beanName} getById(String id) {
        return this.${jdbcTable.beanName?uncap_first}Dao.getById(id);
    }

    /**通过实体作为筛选条件查询*/
    @Override
    public List <${jdbcTable.beanName}> getListSearch(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        return this.${jdbcTable.beanName?uncap_first}Dao.getListSearch(${jdbcTable.beanName?uncap_first});
    }

    /**新增数据*/
    @Override
    public int insert(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        return this.${jdbcTable.beanName?uncap_first}Dao.insert(${jdbcTable.beanName?uncap_first});
    }

    /**修改数据*/
    @Override
    public int update(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first}) {
        return this.${jdbcTable.beanName?uncap_first}Dao.update(${jdbcTable.beanName?uncap_first});
    }

    /**通过主键删除数据*/
    @Override
    public boolean deleteById(String id) {
        return this.${jdbcTable.beanName?uncap_first}Dao.deleteById(id) > 0;
    }

}