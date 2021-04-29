package ${jdbcTable.packagePref}.service;

import ${jdbcTable.packagePref}.bean.${jdbcTable.beanName};

import java.util.List;

/**
 * ${jdbcTable.comments} 服务接口
 *
 * @author ${author}
 * @since ${date?string("yyyy-MM-dd HH:mm:ss")}
 */
public interface ${jdbcTable.beanName}Service {

    /*通过ID查询单条数据*/
    ${jdbcTable.beanName} queryById(String id);

    /*通过实体作为筛选条件查询*/
    List<${jdbcTable.beanName}> queryAll(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /*新增数据*/
    ${jdbcTable.beanName} insert(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /*修改数据*/
    int update(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /*通过主键删除数据*/
    boolean deleteById(String id);

}
