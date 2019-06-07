package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import java.util.List;

import com.atguigu.crud.bean.Xinzi;
import com.atguigu.crud.bean.Zpb;

import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);
    
    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    List<Zpb> selectByExampleWithDeptzp(Zpb zpb);

    void deleteEmpZp(Integer id);

    void updatezp(Integer id);

    List<Xinzi> queryxinzi(Xinzi xinzi);

    void updatejt(Integer id);

    void updatekq(Integer id);

    void updatejb(Integer id);
}