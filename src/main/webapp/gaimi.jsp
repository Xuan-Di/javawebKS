<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/6/11
  Time: 17:04
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
    <link rel="stylesheet" type="text/css" href="css/detailsmusic.css" />
</head>
<body>
<div class="music-lgin">

    <div class="music-lgin-all">
        <!--左手-->
        <div class="music-lgin-left ovhd">
            <div class="music-hand">
                <div class="music-lgin-hara"></div>
                <div class="music-lgin-hars"></div>
            </div>
        </div>

        <!--脑袋-->
        <div class="music-lgin-dh">
            <div class="music-lgin-alls">
                <div class="music-lgin-eyeleft">
                    <div class="music-left-eyeball yeball-l"></div>
                </div>
                <div class="music-lgin-eyeright">
                    <div class="music-right-eyeball yeball-r"></div>
                </div>
                <div class="music-lgin-cl"></div>
            </div>
            <!--鼻子-->
            <div class="music-nose"></div>
            <!--嘴-->
            <div class="music-mouth music-mouth-ds"></div>
            <!--肩-->
            <div class="music-shoulder-l">
                <div class="music-shoulder"></div>
            </div>
            <div class="music-shoulder-r">
                <div class="music-shoulder"></div>
            </div>
            <!--消息框-->
            <div class="music-news">来了,老弟！</div>
        </div>

        <!--右手-->
        <div class="music-lgin-right ovhd">
            <div class="music-hand">
                <div class="music-lgin-hara"></div>
                <div class="music-lgin-hars"></div>
            </div>
        </div>

    </div>

    <form class="form-horizontal"  id="userInfo2" method="get">
    <!--1-->
    <div class="music-lgin-text">
        <input class="inputname inputs" type="text" name="userName" placeholder="用户名" />
    </div>

    <!--2-->
        <div class="music-lgin-text">
            <input type="text" class="email inputs" name="email" placeholder="邮箱" />
        </div>

    <div class="music-lgin-text">
        <input type="password" class="mima inputs" name="passwd" placeholder="密码" />
    </div>
    <!--3-->
    <div class="music-lgin-text">
        <input class="music-qd inputs" type="button" value="确定" />
    </div>
    </form>
</div>

<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
<script type="text/javascript">
    //眼睛 密码部分
    $(".mima").focus(function() {
        $(".music-lgin-left").addClass("left-dh").removeClass("rmleft-dh");
        $(".music-lgin-right").addClass("right-dh").removeClass("right-rmdh");
        $(".music-hand").addClass("no");
    }).blur(function() {
        $(".music-lgin-left").removeClass("left-dh").addClass("rmleft-dh");
        $(".music-lgin-right").removeClass("right-dh").addClass("right-rmdh");
        $(".music-hand").removeClass("no");

    })
    //点击小人出来
    $(".inputname").focus(function() {
        $(".music-lgin-all").addClass("block");
        $(".music-news").addClass("no")
    })
    //点击小人消失

    //          $(".music-qd").focus(function(){
    //          	$(".music-lgin-all").removeClass("block")
    //          })


    //注册正则 简单判断

    $('.music-qd').click(function(){
        if(($('.inputname').val()=='')){
            $(".music-news").html("请输入名称")
        }else if(($('.email').val()=='')) {
            $(".music-news").html("请输入邮箱")
            $(".music-news").addClass("block")
        }else if(($('.mima').val()=='')){
            $(".music-news").html("请输入密码")
            $(".music-news").addClass("block")
        }else{
           // alert('提交ajax')
            $.ajax({
                url:"${APP_PATH3}/addUserAjax",
                type:"POST",
                //.serialize() 当提交多条表单数据时，我们可以采用当表单进行序列化的方式简化原有的操作
                data:$("#userInfo2").serialize(),
                dataType: "json",
                success: function(result){
                    if(result.code==100){
                        alert("修改成功");
                        window.location.href="success.jsp";
                    }else{
                        // $("#result").html("修改失败");
                        alert("修改失败");
                    }
                }
            });
        }
    })

</script>

</body>
</html>
