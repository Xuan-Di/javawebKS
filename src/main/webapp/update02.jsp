<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>修改密码界面</title>
    <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
    <meta name="author" content="Vincent Garreau" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" media="screen" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/zhuce.css"/>
    <link rel="stylesheet"href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
</head>
<body>
<div id="particles-js">
    <div class="login">
        <div class="login-top">
            修改密码
        </div>

        <form  action="UpdateServlet" method="post" onsubmit="return validator()">
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-10">
                    <input type="text"class="form-control" placeholder="用户名"  name="username"  id="username">
                </div><br/><br/>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-10">
                    <div class="input-group">
                        <input type="email"class="form-control" placeholder="电子邮件" name="uemail" id="uemail">
                        <!--   <span class="input-group-btn"><button class="btn btn-primary" class="getVerification">获取验证码</button> </span>-->
                        <input type="button" value="获取验证码"  onclick="register()" style=" background-color: #0595e9;border: 1px solid blue;border-radius: 2px;margin: 3px 0px 3px 180px"/>
                    </div>
                </div><br/><br/>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-10">
                    <input type="text"class="form-control" placeholder="请输入验证码" name="test" id="test">

                </div><br/><br/>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-10">
                    <input type="password" class="form-control" placeholder="设置密码" name="upasswd" id="upasswd">
                </div><br/><br/>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-10">
                    <input type="password" class="form-control" placeholder="确认密码">
                </div><br/><br/>
            </div>

            <div class="submit">
                <!--  <span class="notice">点击"注册"代表您同意遵守
                      <a href="#">用户协议</a>
                      和
                      <a href="#">隐私条款</a>
                  </span>
                  -->
                <button class="s_hover" data-form="submit" >完成</button>
            </div>

        </form>
        <!--  <script type="text/javascript">
             $("form .getVerification").on("click",function(){
                     $.ajax({
                         url:"EmailServlet1",
                         type:"post"
                 });
             });
         </script>-->
    </div>
    <div class="sk-rotating-plane"></div>
</div>

<div style="text-align:center;">
</div>
<!-- scripts -->
<script src="js/particles.min.js"></script>
<script src="js/app.js"></script>
<script type="text/javascript">
    function register()
    {
        var $uemail = $("#uemail").val();
        $.ajax({
            url:"EmailServlet2",
            请求方式:"post",
            data:"uemail="+$uemail,
            success:function(result,testStatus)
            {

            },
            error:function(xhr,errorText,errorType){
                alert("系统异常");
            }
        });
    }
    function hasClass(elem, cls) {
        cls = cls || '';
        if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
        return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
    }

    function addClass(ele, cls) {
        if (!hasClass(ele, cls)) {
            ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
        }
    }

    function removeClass(ele, cls) {
        if (hasClass(ele, cls)) {
            var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
            while (newClass.indexOf(' ' + cls + ' ') >= 0) {
                newClass = newClass.replace(' ' + cls + ' ', ' ');
            }
            ele.className = newClass.replace(/^\s+|\s+$/g, '');
        }
    }
    /**
     document.querySelector(".s_hover").onclick = function(){
        addClass(document.querySelector(".login"), "active")
        setTimeout(function(){
            addClass(document.querySelector(".sk-rotating-plane"), "active")
            document.querySelector(".login").style.display = "none"
        },800)
        setTimeout(function(){
            removeClass(document.querySelector(".login"), "active")
            removeClass(document.querySelector(".sk-rotating-plane"), "active")
            document.querySelector(".login").style.display = "block"
            alert("修改成功")

        },5000)
    }*/

    function validator()
    {	console.log("ffff");
        var $test = $("#test").val();
        window.flag = "";
        $.ajax({
            url:"Match",
            请求方式:"post",
            data:"test="+$test,
            success:function(result,testStatus)
            {
                if(result=="true"){
                    alert("验证码匹配成功！");
                    window.flag = true;

                }else{
                    alert("验证码错误！");
                    window.flag=false;
                }
            },
            error:function(xhr,errorText,errorType){
                alert("系统异常");
            },
            async: false
        });

        return window.flag;
    }

</script>
</body>
</html>