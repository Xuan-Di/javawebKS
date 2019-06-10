package com.atguigu.crud.controller;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.Xinzi;
import com.atguigu.crud.bean.Zpb;

import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;

/**
 * 员工操作控制层
 * @author asus
 *
 */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;


	/**
	 * 员工删除二合一
	 *
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids) {
		//批量删除
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
			//单个删除
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}

		return Msg.success();
	}



	/**
	 * 员工更新方法
	 *
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		//System.out.println("请求体中的值："+request.getParameter("id"));
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}

	/**
	 * 根据id查询员工
	 *
	 * @param id
	 * @return
	 */

	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 检查用户名是否可用
	 *
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName") String empName) {
		//先判断是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "前端验证用户名不合法");
		}
		//确定是合法的表达式再去数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if (b) {

			return Msg.success();

		} else {

			return Msg.fail().add("va_msg", "后端验证用户名有重名！！");
		}

	}

	/**
	 * 员工保存
	 * 1.支持JSR303校验
	 * 2.导入Hibernate-Validator
	 *
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			//校验失败应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}

	/**
	 * 员工查询
	 * 导入jackson包
	 *
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		//在查询前使用pageHelper;传入页码以及每页查询几条记录
		PageHelper.startPage(pn, 5);
		//startPage之后紧跟分页查询
		List<Employee> emps = employeeService.getAll();
		//只需要将pageInfo包装，交给页面就行了
		//查完以后使用pageInfo包装数据记录;可以传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}

    /**
     * 招聘查询全部人员
     * @param pn
     * @return
     */

	@RequestMapping("/zpemps")
	@ResponseBody
	public Msg getEmpsWithJsonzp(@RequestParam(value = "pn", defaultValue = "1") Integer pn,@RequestParam("paixu") Integer paixu) {

		//在查询前使用pageHelper;传入页码以及每页查询几条记录
		PageHelper.startPage(pn, 5);
		//startPage之后紧跟分页查询
		List<Zpb> zpemps = employeeService.getzpAll();
		if(paixu==1) {
			Collections.sort(zpemps, new Comparator<Zpb>() {
				@Override
				public int compare(Zpb o1, Zpb o2) {
					return o2.getWorkingage() - o1.getWorkingage();
				}
			});
		}
		if(paixu==2){
			Collections.sort(zpemps, new Comparator<Zpb>() {
				@Override
				public int compare(Zpb o1, Zpb o2) {
					return o1.getWorkingage() - o2.getWorkingage();
				}
			});
		}
			//只需要将pageInfo包装，交给页面就行了
			//查完以后使用pageInfo包装数据记录;可以传入连续显示的页数
			PageInfo page = new PageInfo(zpemps, 5);


			return Msg.success().add("pageInfo", page);

	}

    /**
     * 查询薪资全部人员
     * @param pn
     * @return
     */
	@RequestMapping("/xinzi")
	@ResponseBody
	public Msg getEmpsWithJsonxinzi(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		//在查询前使用pageHelper;传入页码以及每页查询几条记录
		PageHelper.startPage(pn, 5);
		//startPage之后紧跟分页查询
		List<Xinzi> xinzis = employeeService.getxinziAll();
		//只需要将pageInfo包装，交给页面就行了
		//查完以后使用pageInfo包装数据记录;可以传入连续显示的页数
		PageInfo page = new PageInfo(xinzis, 5);
		return Msg.success().add("pageInfo", page);
	}

    /**
     * 增加津贴
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/jintie/{id}", method = RequestMethod.PUT)
    public Msg updatejt(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.updatejt(id);
        return Msg.success();
    }

    /**
     * 减少津贴
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/jsjt/{id}", method = RequestMethod.PUT)
    public Msg jsjt(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.jsjt(id);
        return Msg.success();
    }


    /**
     * 增加考勤
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/kaoqin/{id}", method = RequestMethod.GET)
    public Msg updatekq(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.updatekq(id);
        return Msg.success();
    }

    /**
     * 减少考勤
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/jskq/{id}", method = RequestMethod.PUT)
    public Msg jskq(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.jskq(id);
        return Msg.success();
    }

    /**
     * 增加加班
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/jiaban/{id}", method = RequestMethod.GET)
    public Msg updatejb(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.updatejb(id);
        return Msg.success();
    }

    /**
     * 减少加班
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/jsjb/{id}", method = RequestMethod.PUT)
    public Msg jsjb(@PathVariable("id") Integer id) {
        System.out.println(id);
        employeeService.jsjb(id);
        return Msg.success();
    }

    /**
     * 更新招聘
     * @param id
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "/zply/{id}", method = RequestMethod.PUT)
	public Msg updatezp(@PathVariable("id") Integer id) {
		System.out.println(id);
		employeeService.updatezp(id);
		return Msg.success();
	}

    /**
     * 删除招聘人员
     * @param id
     * @return
     */
	@RequestMapping(value = "/empzp/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deletezp(@PathVariable("id") Integer id) {
		System.out.println(id);
		employeeService.deleteempzp(id);
		return Msg.success();
	}

}
