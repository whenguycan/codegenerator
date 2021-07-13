<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${jdbcTable.packagePref}.dao.${jdbcTable.beanName}Dao">

    <sql id="fields">
        <#list jdbcTable.jdbcColumns as column>
            <#if column.dataType == 'DATE' && column.columnName != 'CREATE_TIME' && column.columnName != 'CHANGE_TIME'>
        to_char(t.${column.columnName}, 'yyyy-mm-dd') ${column.columnCamelName}<#if column?is_last><#else>,</#if>
            <#else>
        t.${column.columnName}<#if column?is_last><#else>,</#if>
            </#if>
        </#list>
    </sql>

    <!--查询单个-->
    <select id="getById" parameterType="string" resultType="${jdbcTable.packagePref}.bean.${jdbcTable.beanName}">
        select
        <include refid="fields"></include>
        from ${jdbcTable.tableName} t
        where t.${jdbcTable.pkColumn.columnName} = ${'#'}${'{'}${jdbcTable.pkColumn.columnCamelName}${'}'}
    </select>

    <!--通过实体作为筛选条件查询-->
    <select id="getListSearch"
            resultType="${jdbcTable.packagePref}.bean.${jdbcTable.beanName}"
            parameterType="${jdbcTable.packagePref}.bean.${jdbcTable.beanName}">
        select
        <include refid="fields"></include>
        from ${jdbcTable.tableName} t
        <where>
            <if test="requestTime != null and requestTime != ''">
            t.REQUEST_TIME like '${'%'}' || ${'#'}${'{'}requestTime${'}'} || '${'%'}'
            </if>
        </where>
    </select>

    <!--新增所有列-->
    <insert id="insert" parameterType="${jdbcTable.packagePref}.bean.${jdbcTable.beanName}">
        insert into ${jdbcTable.tableName} (
            <#list jdbcTable.jdbcColumns as column>
                <#if column.columnName != 'CHANGER' && column.columnName != 'CHANGE_DEPT' && column.columnName != 'CHANGE_TIME'>
            ${column.columnName}<#if column?is_last><#else>,</#if>
                </#if>
            </#list>
        )
        values (
            <#list jdbcTable.jdbcColumns as column>
                <#if (column.constraintType?exists && column.constraintType == 'P') || column.columnName == 'CREATE_TIME' || column.columnName == 'VALID_FLAG'>
                    <#if column.constraintType?exists && column.constraintType == 'P'>
            func_get_uuid<#if column?is_last><#else>,</#if>
                    <#else>
                        <#if column.columnName == 'CREATE_TIME'>
            sysdate<#if column?is_last><#else>,</#if>
                        </#if>
                        <#if column.columnName == 'VALID_FLAG'>
            '1'<#if column?is_last><#else>,</#if>
                        </#if>
                    </#if>
                <#else>
                    <#if column.columnName == 'CHANGER' || column.columnName == 'CHANGE_DEPT' || column.columnName == 'CHANGE_TIME'>
                    <#else>
                        <#if column.dataType == "DATE">
            to_date(${'#'}${'{'}${column.columnCamelName}${'}'}, 'yyyy-mm-dd')<#if column?is_last><#else>,</#if>
                        <#else>
            ${'#'}${'{'}${column.columnCamelName}${'}'}<#if column?is_last><#else>,</#if>
                        </#if>
                    </#if>
                </#if>
            </#list>
        )
    </insert>

    <!--通过主键修改数据-->
    <update id="update">
        update ${jdbcTable.tableName}
        <set>
            <#list jdbcTable.jdbcColumns as column>
                <#if column.constraintType?exists && column.constraintType == 'P'>
                <#else>
                    <#if column.columnName != 'CREATOR' && column.columnName != 'CREATE_DEPT' && column.columnName != 'CREATE_TIME' && column.columnName != 'VALID_FLAG'>
                        <#if column.columnName == 'CHANGE_TIME'>
                ${column.columnName} = sysdate,
                        <#else>
            <if test="${column.columnCamelName} != null and ${column.columnCamelName} != ''">
                            <#if column.dataType == 'DATE'>
                ${column.columnName} = to_date(${'#'}${'{'}${column.columnCamelName}${'}'}, 'yyyy-mm-dd'),
                            <#else>
                ${column.columnName} = ${'#'}${'{'}${column.columnCamelName}${'}'},
                            </#if>
            </if>
                        </#if>
                    </#if>
                </#if>
            </#list>
        </set>
        where ${jdbcTable.pkColumn.columnName} = ${'#'}${'{'}${jdbcTable.pkColumn.columnCamelName}${'}'}
    </update>

    <!--通过主键删除-->
    <delete id="deleteById">
        delete from ${jdbcTable.tableName} where ${jdbcTable.pkColumn.columnName} = ${'#'}${'{'}${jdbcTable.pkColumn.columnCamelName}${'}'}
    </delete>

</mapper>

