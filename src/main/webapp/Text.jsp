<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/6/2
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH3",request.getContextPath());
    %>
    <!-- 引入jquery  -->
    <script type="text/javascript" src="${APP_PATH3}/static/js/jquery-1.12.4.min.js"></script>
    <!--  引入bootstrap样式  -->
    <link href="${APP_PATH3}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH3}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<h2 style="color: darkslategray;text-align:center;">修改密码</h2><br>
<table>

    <form class="form-horizontal"  id="userInfo2" method="get">
        <div class="form-group">

            <label for="inputPassword3" class="col-sm-2 control-label" style="text-align:right">用户名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="userName" placeholder="UerName">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label" style="text-align:right">邮箱地址</label>
            <div class="col-sm-10">
                <input type="email" name="email" class="form-control" id="inputEmail3" placeholder="Email">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword3" class="col-sm-2 control-label" style="text-align:right">新密码</label>
            <div class="col-sm-10">
                <input type="password" name="passwd" class="form-control" id="inputPassword3" placeholder="Password">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> Remember me
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-success" id="commit">确认更改</button>
            </div>
        </div>
    </form>
   <!-- <form id="userInfo2" method="get">
        姓名:<input type="text" name="userName"><br>
        密码:<input type="text" name="passwd"><br>
        邮箱:<input type="text" name="email"><br>
        <input id="commit" type="button" value="提交">
    </form>-->
</table>

<script>
    $(function () {
        $("#commit").click(function () {
            var email= $("#inputEmail3").val();
            if(email!="1099393970@qq.com"){
                alert("邮箱有误！");
               return false;
            }
            $.ajax({
                url: "${APP_PATH3}/addUserAjax",
                type: "GET",
                //.serialize() 当提交多条表单数据时，我们可以采用当表单进行序列化的方式简化原有的操作
                data: $("#userInfo2").serialize(),
                dataType: "json",
                success: function (result) {
                    if (result.code==100) {
                       // $("#result").html("修改成功");
                        alert("修改成功");
                        window.location="login.jsp";
                    } else {
                       // $("#result").html("修改失败");
                        alert("修改失败");
                    }
                }
            })
        })
    })
</script>


</body>
</html>
