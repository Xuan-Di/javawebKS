package com.atguigu.crud.bean;

/**
 * @author wzx
 * @date 2019/6/6 - 13:58
 */
public class Xinzi {
    private  int idl;
    private String namel;
    private int jintie;
    private int jiaday;
    private int gongday;
    private int money;

    public Xinzi() {
    }

    public Xinzi(int idl, String namel, int jintie, int jiaday, int gongday, int money) {
        this.idl = idl;
        this.namel = namel;
        this.jintie = jintie;
        this.jiaday = jiaday;
        this.gongday = gongday;
        this.money = money;
    }

    public int getIdl() {
        return idl;
    }

    public void setIdl(int idl) {
        this.idl = idl;
    }

    public String getNamel() {
        return namel;
    }

    public void setNamel(String namel) {
        this.namel = namel;
    }

    public int getJintie() {
        return jintie;
    }

    public void setJintie(int jintie) {
        this.jintie = jintie;
    }

    public int getJiaday() {
        return jiaday;
    }

    public void setJiaday(int jiaday) {
        this.jiaday = jiaday;
    }

    public int getGongday() {
        return gongday;
    }

    public void setGongday(int gongday) {
        this.gongday = gongday;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }
}
