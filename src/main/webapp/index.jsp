<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <link href="static/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--create Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="test" class="form-control" name="empName" id="empName_add_input" placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="test" class="form-control" name="email" id="email_add_input" placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="emp_add_btn" >Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<%--update Modal--%>
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">员工更新</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_input"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="test" class="form-control" name="email" id="email_update_input" placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="emp_update_btn" >Update</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="col-md-12">SSM</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10 ">
            <button class="btn btn-primary" id="create">Create</button>
            <button class="btn btn-danger" id="delete">Delete</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <td>
                        <input type="checkbox" id="check_all" />
                    </td>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>operation</td>
                <tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info"></div>
        <div class="col-md-6" id="page_nav"></div>
    </div>
</div>
<script type="text/javascript">
    <%--当前页码--%>
    var number;
    $(function () {
        to_page(1);
    });
    function to_page(pn) {
        $("#check_all").prop("checked",false);
        $.ajax({
            url:"/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }
    //表格数据
    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        var emps = result.map.pageInfo.list;
        number = result.map.pageInfo.pageNum;
        $.each(emps,function (index,item) {
            var checkbox = $("<td><input type='checkbox' class='check_item'/></td>");
            var empId = $("<td></td>").append((number-1)*5+index+1).attr("emp_id",item.empId);
            var empName = $("<td></td>").append(item.empName);
            var gender = $("<td></td>").append(item.gender=="M"?"男":"女");
            var email = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);
            var updateBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm edit-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("Update");
            updateBtn.attr("emp_id",item.empId);
            var deleteBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm delete-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("Delete");
            deleteBtn.attr("emp_id",item.empId);
            var btnTd = $("<td></td>").append(updateBtn).append(" ").append(deleteBtn);
            $("<tr></tr>")
                .append(checkbox)
                .append(empId)
                .append(empName)
                .append(gender)
                .append(email)
                .append(deptName)
                .append(btnTd)
                .appendTo("#emp_table tbody");
        });
    }
    //分页信息
    function build_page_info(result) {
        $("#page_info").empty();
        $("#page_info").append("当前第"+result.map.pageInfo.pageNum+"页，总"+result.map.pageInfo.pages+"页，总"+result.map.pageInfo.total+"条记录")

    }
    //分页条
    function build_page_nav(result) {
        $("#page_nav").empty();
        var nav = $("<nav></nav>");
        var ul = $("<ul></ul>").addClass("pagination");
        //首页
        var startLi = $("<li></li>").append($("<a></a>").attr("href","#").append("Start"));
        //上一页
        var last = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
        if(result.map.pageInfo.hasPreviousPage == false){
            startLi.addClass("disabled");
            last.addClass("disabled");
        }else {
            startLi.click(function () {
                to_page(1);
            });
            last.click(function () {
                to_page(result.map.pageInfo.pageNum-1);
            });
        }
        ul.append(startLi).append(last);
        $.each(result.map.pageInfo.navigatepageNums,function (index,item) {
            var li = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            if(item == result.map.pageInfo.pageNum){
                li.addClass("active");
            }
            li.click(function () {
                to_page(item);
            });
            ul.append(li);
        });
        //下一页
        var next = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
        //末页
        var endLi = $("<li></li>").append($("<a></a>").attr("href","#").append("End"));
        if(result.map.pageInfo.hasNextPage == false){
            next.addClass("disabled");
            endLi.addClass("disabled");
        }else{
            next.click(function () {
                to_page(result.map.pageInfo.pageNum+1);
            });
            endLi.click(function () {
                to_page(result.map.pageInfo.pages);
            });
        }
        ul.append(next).append(endLi);
        nav.append(ul).appendTo("#page_nav");
    }
    //重置表单
    function resetForm(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
    //点击create，弹出模态框
    $("#create").click(function () {
        resetForm("#myModal form");
        //查询部门
        getDepts("#dept_add_select");
        //弹出模态框
        $("#myModal").modal({
            backdrop:"static"
        });
    });
    //查询部门
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"/depts",
            type:"GET",
            success:function (result) {
                // console.log(result);
                $.each(result.map.depts,function () {
                    var option = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    option.appendTo($(ele));
                });
            }
        });
    }
    //保存员工
    $("#emp_save_btn").click(function () {
        //前端校验
        // var empNameValue = $("#empName_add_input").val();
        // var namePattern = /^[a-zA-Z0-9_-]{4,16}$/;
        // var emailValue = $("#email_add_input").val();
        // var emailPattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        // if(!namePattern.test(empNameValue)){
        //     validation("#empName_add_input","error","用户名要求4到16位（字母，数字，下划线，减号）");
        //     return false;
        // }else{
        //     validation("#empName_add_input","success","");
        // }
        // if(!emailPattern.test(emailValue)){
        //     validation("#email_add_input","error","请输入正确的邮箱");
        //     return false;
        // }else{
        //     validation("#email_add_input","success","");
        // }
        if($(this).attr("isSave")=="error"){
            return false;
        }
        $.ajax({
            url:"/emp",
            type:"POST",
            data:$("#myModal form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    $("#myModal").modal("hide");
                    to_page(9999);
                }else{
                    if(undefined != result.map.empName){
                        validation("#empName_add_input","error",result.map.empName);
                    }
                    if(undefined != result.map.email){
                        validation("#email_add_input","error",result.map.email);
                    }
                }
            }
        });
    });
    //校验
    function validation(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error")
        $(ele).next("span").text("");
        if(status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //用户名监听事件
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"/checkUser",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.code == 100){
                    validation("#empName_add_input","success",result.map.message)
                    $("#emp_save_btn").attr("isSave","success");
                }else{
                    validation("#empName_add_input","error",result.map.message)
                    $("#emp_save_btn").attr("isSave","error");
                }
            }
        });
    });
    //给页面加载完之后的更新按钮绑定事件
    $(document).on("click",".edit-btn",function () {
        getDepts("#dept_update_select");
        getEmp($(this).attr("emp_id"));
        $("#emp_update_btn").attr("update_id",$(this).attr("emp_id"));
        $("#updateModal").modal({
            backdrop:"static"
        });
    });
    //查询员工
    function getEmp(id) {
        $.ajax({
            url:"/emp/"+id,
            type:"GET",
            success:function (result) {
                $("#empName_update_input").text(result.map.emplovee.empName);
                $("#email_update_input").val(result.map.emplovee.email);
                $("#updateModal input[name = gender]").val([geresult.map.emplovee.gender]);
                $("#dept_update_select").val([result.map.emplovee.dId]);
            }
        });
    }
    //更新按钮绑定事件
    $("#emp_update_btn").click(function () {
        $.ajax({
            url:"/emp/"+$(this).attr("update_id"),
            type:"PUT",
            data:$("#updateModal form").serialize(),
            success:function (result) {
                $("#updateModal").modal("hide");
                to_page(number);
            }
        });
    });
    //单个删除按钮绑定事件
    $(document).on("click",".delete-btn",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除"+empName+"吗")){
            $.ajax({
                url:"/emp/"+$(this).attr("emp_id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(number);
                }
            });
        }
    });
    //check全选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //五个选中，全选的check也选中
    $(document).on("click",".check_item",function () {
        var isChecked = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",isChecked);
    });
    //批量删除按钮绑定事件
    $("#delete").click(function () {
        var empNames = "";
        var ids = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            ids += $(this).parents("tr").find("td:eq(1)").attr("emp_id")+",";
        });
        ids = ids.substring(0,ids.length-1);
        empNames = empNames.substring(0,empNames.length-1);
        if(confirm("确定删除"+empNames+"吗")){
            $.ajax({
                url:"/emp/"+ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(number);
                }
            });
        }

    });

</script>
</body>
</html>
