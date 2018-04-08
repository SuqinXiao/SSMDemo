package ssm.controller;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import ssm.bean.Emplovee;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import ssm.bean.Msg;
import ssm.service.EmploveeService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class EmploveeController {

    @Resource
    EmploveeService emploveeService;

//    //查询所有员工
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
////        pageNum页码,pageSize每页的大小
//        PageHelper.startPage(pn, 5);
////        startPage后面紧跟的这个查询就是分页查询
//        List<Emplovee> list = emploveeService.getAll();
////        navigatePages连续显示的页数
////        pageInfo封装了查询的结果，把它交给页面就行了
//        PageInfo pageInfo = new PageInfo(list,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//    }

//    查询全部员工
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        // pageNum页码,pageSize每页的大小
        PageHelper.startPage(pn, 5);
        // 查询结果
        List<Emplovee> list = emploveeService.getAll();
        // startPage后面紧跟的这个查询就是分页查询
        PageInfo pageInfo = new PageInfo(list,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

//    create员工
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Validated Emplovee emplovee, BindingResult result){
        if(result.hasErrors()){
            Msg msg = Msg.fail();
            List<FieldError> list = result.getFieldErrors();
            for(FieldError error : list){
                msg.add(error.getField(),error.getDefaultMessage());
            }
            return msg;
        }else{
            emploveeService.saveEmp(emplovee);
            return Msg.success();
        }
    }

//    校验用户名
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        String pattem = "^[a-zA-Z0-9_-]{4,16}$";
        if(!empName.matches(pattem)){
            return Msg.fail().add("message","用户名必须是4-16位");
        }
        boolean b = emploveeService.checkUser(empName);
        if(b){
            return Msg.success().add("message","用户名可用");
        }else{
            return  Msg.fail().add("message","用户名不可用");
        }
    }

//    查询员工(单个)
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Emplovee emplovee = emploveeService.getEmp(id);
        return Msg.success().add("emplovee",emplovee);
    }

//    没做校验
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Emplovee emplovee){
        emploveeService.updateEmp(emplovee);
        return Msg.success();
    }

//    @RequestMapping("/e/{empId}")
//    public void test(Emplovee emplovee){
//        System.out.print(emplovee);
//    }

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpByIds(@PathVariable("ids") String ids){
        if(ids.indexOf(",")>-1){
            String[] id = ids.split(",");
            List list = Arrays.asList(id);
            emploveeService.deleteEmpBatch(list);
        }else{
            emploveeService.deleteEmpById(Integer.parseInt(ids));

        }
        return Msg.success();
    }

}
