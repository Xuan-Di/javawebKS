<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/6/4
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH5",request.getContextPath());
    %>
    <!-- 引入jquery  -->
    <script type="text/javascript" src="${APP_PATH5}/static/js/jquery-1.12.4.min.js"></script>
    <!--  引入bootstrap样式  -->
    <link href="${APP_PATH5}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH5}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        .btnn{width: 30px;height: 30px;border-radius: 50%;border: none}
        /* border-radius */
        .ziti{color: #28a4c9}
        .ziti03{color: teal}
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
            <h1>招聘管理</h1>
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
                    <th>年龄</th>
                    <th>名字</th>
                    <th>性别</th>
                    <th>工作经验(年)</th>
                    <th>分数</th>
                    <th>操作</th>
                    <th>状态</th>
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
    <!--进度条信息-->
    <div class="row">
        <div class="col-md-12" id="page_info_jindu">

    </div>
</div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    $(function(){
        to_page(1);
    });
    function to_page(pn){
        $.ajax({
            url:"${APP_PATH5}/zpemps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //console.log(result);
                //1、在页面解析jason数据并且显示员工数据
                build_emps_table(result);
                //2、解析显示分页信息
                build_page_info(result);
                //3、解析显示分页条信息
                bulid_page_nav(result);
                //4、显示进度条信息
                build_page_jindu(result);
            }
        });
    }
    function build_page_jindu(result) {
        var emps = result.extend.pageInfo.list;
        var statutotal=0;
        $.each(emps, function (index, item) {
            $("#page_info_jindu").empty();

            //alert(statutotal);
            if(item.statu=="已录用"){
                statutotal=statutotal+20;
            }
            //alert(statutotal);
            //$("#page_info_jindu").append();
        // <div class="progress">
        //         <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
        //         </div>
        //         </div>
            if(statutotal==0){
                var statuTD=$("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role","progressbar").attr("aria-valuenow","0")
                    .attr("aria-valuemin","0").attr("aria-valuemax","100").attr("style","width: 0%")).append("0%"+"录取");
            }else if(statutotal==20){
            var statuTD=$("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role","progressbar").attr("aria-valuenow","20")
                .attr("aria-valuemin","0").attr("aria-valuemax","100").attr("style","width: 20%")).append("20%"+"录取");
            }else if(statutotal==40){
                var statuTD=$("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role","progressbar").attr("aria-valuenow","40")
                    .attr("aria-valuemin","0").attr("aria-valuemax","100").attr("style","width: 40%")).append("40%"+"录取");
            }else if(statutotal==60) {
                var statuTD = $("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role", "progressbar").attr("aria-valuenow", "60")
                    .attr("aria-valuemin", "0").attr("aria-valuemax", "100").attr("style", "width: 60%")).append("60%"+"录取");
            }else if(statutotal==80){
                var statuTD = $("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role", "progressbar").attr("aria-valuenow", "80")
                    .attr("aria-valuemin", "0").attr("aria-valuemax", "100").attr("style", "width: 80%")).append("80%"+"录取");
            }else{
                var statuTD = $("<div></div>").addClass("progress").append($("<div></div>").addClass("progress-bar progress-bar-success").attr("role", "progressbar").attr("aria-valuenow", "100")
                    .attr("aria-valuemin", "0").attr("aria-valuemax", "100").attr("style", "width: 100%")).append("100%"+"录取");
            }
           // var statuTD=statutotal;
            $("<div></div>").append(statuTD).appendTo("#page_info_jindu");
         });

    }
    function build_emps_table(result) {
        //构建一个新的表格之前需要清空之前的数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.zpempid).addClass("ziti");
            var empageTd = $("<td></td>").append(item.zpempage).addClass("ziti03");
            var empNameTd=$("<td></td>").append(item.zpempname).addClass("ziti03");
            var genderTd = $("<td></td>").append(item.zpgender == 'M' ? "男" : "女").addClass("ziti03");
            var workingageTd = $("<td></td>").append(item.workingage).addClass("ziti03");
            var editBtn = $("<button></button>").addClass("btn btn-success btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("录用");
            //为编辑按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            editBtn.attr("edit-id", item.zpempid);
            editBtn.attr("wzx", item.zpempid);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义属性，来表示当前员工. 值就是员工id
            delBtn.attr("delete-btn", item.zpempid);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            var statuTd=$("<td></td>").append(item.statu).addClass("ziti03");;
            var score=$("<td></td>").append(item.zpempage*3+item.workingage*4).addClass("ziti03");
            $("<tr></tr>")
                .append(empIdTd)
                .append(empageTd)
                .append(empNameTd)
                .append(genderTd)
                .append(workingageTd)
                .append(score)
                .append(btnTd)
                .append(statuTd)
                .appendTo("#emps_table tbody");

        });
    }
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
    $(document).on("click",".delete_btn",function () {
    //alert("hahah");
        var empName =$(this).parents("tr").find("td:eq(2)").text();

        if(confirm("确认删除【"+empName+"】吗？")){
            deleteEmp($(this).attr("delete-btn"));
        }
    });
    function deleteEmp(deleteid){
        $.ajax({
            url:"${APP_PATH5}/empzp/"+deleteid,
            type:"DELETE",
            //date:"empId="+deleteid,
            success:function(result){
                alert(result.msg);
                to_page(currentPage);
            }
        });
    }
    $(document).on("click",".edit_btn",function () {
    //alert("hhhhh");
        if(confirm("确认录用吗？")){
    var m=$(this).attr("wzx");
    //alert(m);
    $.ajax({
        url:"${APP_PATH5}/zply/"+m,
        type:"PUT",
        success:function (result) {
            alert(result.msg);
            to_page(currentPage);
        }
    });
        }
    });
    //返回主界面
    function next(){
        window.location = "success.jsp";
    }
</script>
</body>
</html>
