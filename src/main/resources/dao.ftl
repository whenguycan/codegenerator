package ${jdbcTable.packagePref}.dao;

import ${jdbcTable.packagePref}.bean.${jdbcTable.beanName};
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * ${jdbcTable.comments} 数据库访问层
 *
 * @author ${author}
 * @since ${date?string("yyyy-MM-dd HH:mm:ss")}
 */
@Mapper
public interface ${jdbcTable.beanName}Dao {

    /**通过ID查询单条数据*/
    public ${jdbcTable.beanName} queryById(String id);

    /**通过实体作为筛选条件查询*/
    public List<${jdbcTable.beanName}> queryAll(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /**新增数据*/
    public int insert(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /**修改数据*/
    public int update(${jdbcTable.beanName} ${jdbcTable.beanName?uncap_first});

    /**通过主键删除数据*/
    public int deleteById(String id);

}