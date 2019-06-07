<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/6/6
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <!-- 引入jquery  -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!--  引入bootstrap样式  -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        .btnn{width: 30px;height: 30px;border-radius: 50%;border: none}
        /* border-radius */
        .ziti{color: #28a4c9}
        .moneyziti{color: teal;font-weight: bold}
        .ziti02{color: darkslategray}
    </style>
</head>
<body>
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-5 ">
            <button  class="glyphicon glyphicon-arrow-left btnn btn-info" onclick="next()"></button>
        </div>
        <div class="col-md-6 ">
            <h1>薪资管理</h1>
        </div>
    </div>
    <!-- 按钮 -->

    <!--显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>

                    <th>#</th>
                    <th>姓名</th>
                    <th>津贴</th>
                    <th>加班天数</th>
                    <th>工作天数</th>
                    <th>津贴操作</th>
                    <th>考勤打卡</th>
                    <th>加班操作</th>
                    <th>薪资总数</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息-->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

    <div class="row">
        <div class="col-md-12 ">
            <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span>
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                津贴发放具体说明
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            1、工资标准。如果在制订工资标准时，已经考虑了对特殊劳动的补偿，就没有必要另设津贴补偿；如果不能全面反映一些岗位和工种的特殊劳动性质和劳动消耗，就需要单独设立补偿津贴。<br>
                            2、劳动特殊性。对劳动的特殊性及对雇员的影响，要进行科学测量，作为确定不同等级津贴标准的依据。
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingTwo">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                加班福利具体说明
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                        <div class="panel-body">
                            1、工作日加班按正常工作日工资150％计算加班补贴。<br>
                            2、周末加班按正常工作日工资200％计算加班补贴。<br>
                            3、国家法定节假日加班按正常工作日工资的300％计算加班补贴。
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                考勤打卡具体说明
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                        <div class="panel-body">
                            考勤方式：公司实行上下班指纹打卡制度，全体员工自觉遵守。<br>
                            打卡次数：一日二次，即早上班、晚下班各一次补签情况：<br>
                            因公外出（含出差）未打卡，应于次日填写《漏打卡补卡申请单》，注明外出日期、事由等，并要求有本部门主管证明签字。无故未打卡或只打一次卡均视为旷工。
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 ">
            工资总额说明：工资=津贴+100*加班次数+200*考勤打卡次数
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;

    //1.页面加载完成以后，直接去发送一个ajsx请求，要到分页数据
    $(function(){
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/xinzi",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                //1、在页面解析jason数据并且显示员工数据
                build_emps_table(result);
                //2、解析显示分页信息
                build_page_info(result);
                //3、解析显示分页条信息
                bulid_page_nav(result);

            }
        });
    }
    function build_emps_table(result){
        //构建一个新的表格之前需要清空之前的数据
        $("#emps_table tbody").empty();
        var emps= result.extend.pageInfo.list;
        $.each(emps,function(index,item){
            //var moneytotal=item.jintie+500*item.jiaday+200*item.gongday;
            var empIdTd=$("<td></td>").append(item.idl).addClass("ziti");
            var empNameTd=$("<td></td>").append(item.namel).addClass("ziti02");
            var genderTd=$("<td></td>").append(item.jintie).addClass("ziti02");
            var emailTd=$("<td></td>").append(item.jiaday).addClass("ziti02");
            var deptNameTd=$("<td></td>").append(item.gongday).addClass("ziti02");
            var moneyTd=$("<td></td>").append(item.money).addClass("moneyziti");
            var editBtn= $("<button></button>").addClass("btn btn-success  btn-sm edit_btn btnn")
                .append($("<span></span>").addClass("glyphicon  glyphicon-plus"));
            //为编辑按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            editBtn.attr("edit-id",item.idl);
            editBtn.attr("wzx",item.idl);
            var delBtn =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn btnn")
                .append($("<span></span>").addClass("glyphicon glyphicon-minus"));
            //为删除按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            delBtn.attr("delete-btn",item.idl);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            var editBtn2= $("<button></button>").addClass("btn btn-success btn-sm edit_btn2 btnn")
                .append($("<span></span>").addClass("glyphicon glyphicon-plus "));
            //为编辑按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            editBtn2.attr("edit-id2",item.idl);
            editBtn2.attr("wzx2",item.idl);
            var delBtn2 =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn2 btnn")
                .append($("<span></span>").addClass("glyphicon glyphicon-minus"));
            //为删除按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            delBtn2.attr("delete-btn2",item.idl);
            var btnTd2 = $("<td></td>").append(editBtn2).append(" ").append(delBtn2);
            var editBtn3= $("<button></button>").addClass("btn btn-success btn-sm edit_btn3 btnn")
                .append($("<span></span>").addClass("glyphicon glyphicon-plus "));
            //为编辑按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            editBtn3.attr("edit-id3",item.idl);
            editBtn3.attr("wzx3",item.idl);
            var delBtn3 =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn3 btnn")
                .append($("<span></span>").addClass("glyphicon glyphicon-minus"));
            //为删除按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            delBtn3.attr("delete-btn3",item.idl);
            var btnTd3 = $("<td></td>").append(editBtn3).append(" ").append(delBtn3);

            $("<tr></tr>")
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .append(btnTd2)
                .append(btnTd3)
                .append(moneyTd)
                .appendTo("#emps_table tbody");

        });
    }


   // 解析显示分页信息
    function build_page_info(result){
        //清空之前的信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"
            +result.extend.pageInfo.pages+"页，总"+result.extend.pageInfo.total +"条记录")
        totalRecord=result.extend.pageInfo.total;
        currentPage=result.extend.pageInfo.pageNum;
    }


    //解析显示分页条
    function bulid_page_nav(result){
        //清空之前的信息
        $("#page_nav_area").empty();
        //page_nav_area
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi= $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi= $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            //判断是否有前一页
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum-1);
            });
        };

        ul.append(firstPageLi).append(prePageLi);
        var nextPageLi= $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi= $("<li></li>").append($("<a></a>").append("末页"));
        if(result.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //为末页和下一页添加点击跳转事件
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){//index是索引，item是遍历的对象。

            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                //判断是否是当前页，如果是就高亮显示
                numLi.addClass("active");
            };
            numLi.click(function(){
                //调用ajax请求，跳转到指定页面
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    };
        //点击增加津贴，发送ajax
    $(document).on("click",".edit_btn",function () {
        //alert("hahaha");
        var m = $(this).attr("wzx");
        //alert(m);
        $.ajax({
            url:"${APP_PATH}/jintie/"+m,
            type:"PUT",
            success:function (result) {
                alert(result.msg);
                to_page(currentPage);
            }
        });
    });
    //点击增加考勤，发送ajax
    $(document).on("click",".edit_btn2",function () {
        //alert("hahaha");
        var m = $(this).attr("wzx2");
        //alert(m);
        $.ajax({
            url:"${APP_PATH}/kaoqin/"+m,
            type:"GET",
            success:function (result) {
                alert(result.msg);
                to_page(currentPage);
            }
        });
    });
    //点击增加加班天数，发送ajax
    $(document).on("click",".edit_btn3",function () {
        //alert("hahaha");
        var m = $(this).attr("wzx3");
        //alert(m);
        $.ajax({
            url:"${APP_PATH}/jiaban/"+m,
            type:"GET",
            success:function (result) {
                alert(result.msg);
                to_page(currentPage);
            }
        });
    });
    //点击返回主界面
    function next(){
        window.location = "success.jsp";
    }
</script>
</body>
</html>
