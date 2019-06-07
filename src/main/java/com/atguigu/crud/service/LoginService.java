package com.atguigu.crud.service;

import com.atguigu.crud.bean.User;
import com.atguigu.crud.dao.LoginMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author wzx
 * @date 2019/6/1 - 19:50
 */
@Service
public class LoginService {
    @Autowired
    LoginMapper loginMapper;

    public int queryUser(User user){

        return  loginMapper.queryUser(user);
    }

    public void updatePw(User user) {
       loginMapper.updatePw(user);
    }

}
