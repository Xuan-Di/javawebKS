package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.LoginService;


import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * @author wzx
 * @date 2019/6/1 - 19:48
 */
@Controller
public class LoginController {
    @Autowired
    LoginService loginService;

    /**
     * 登录
     */
    @RequestMapping("/queryUser")
    public String queryUser(@RequestParam("uname") String name, @RequestParam("pwd") String pw, HttpServletResponse response, HttpServletRequest request) throws IOException, ServletException {
        System.out.println("111111");
        User user = new User(name, pw);
        int m = loginService.queryUser(user);
        System.out.println(m);
        if (m >= 1) {
            //return "success";
            //request.getRequestDispatcher("/views/success.jsp").forward(request, response);
            response.sendRedirect("success.jsp");
            return null;
        }
        response.sendRedirect("login.jsp");
        return null;
    }

    @RequestMapping("/addUserAjax")
    @ResponseBody
    public Msg addUserAjax(User user) {
        System.out.println(user.getUserName() + "-----" + user.getPasswd() + "---" + user.getEmail());
        loginService.updatePw(user);

        return Msg.success();
    }

    @RequestMapping("/EmailServlet2")
    public void update(@RequestParam("uemail") String email1, HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println(email1);
         //EmailUtils.sendEamilCode(email1);

    }
}







