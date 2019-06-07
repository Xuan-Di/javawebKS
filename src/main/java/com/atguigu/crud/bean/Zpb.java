package com.atguigu.crud.bean;

/**
 * @author wzx
 * @date 2019/6/4 - 16:13
 */
public class Zpb {
    private int zpempid;
    private int zpempage;
    private String zpempname;
    private String zpgender;
    private int workingage;
    private String statu;



    public Zpb() {
    }

    public Zpb(int zpempid, int zpempage, String zpempname, String zpgender, int workingage,String statu) {
        this.zpempid = zpempid;
        this.zpempage = zpempage;
        this.zpempname = zpempname;
        this.zpgender = zpgender;
        this.workingage = workingage;
        this.statu=statu;
    }


    public String getStatu() {
        return statu;
    }

    public void setStatu(String statu) {
        this.statu = statu;
    }
    public int getZpempid() {
        return zpempid;
    }

    public void setZpempid(int zpempid) {
        this.zpempid = zpempid;
    }

    public int getZpempage() {
        return zpempage;
    }

    public void setZpempage(int zpempage) {
        this.zpempage = zpempage;
    }

    public String getZpempname() {
        return zpempname;
    }

    public void setZpempname(String zpempname) {
        this.zpempname = zpempname;
    }

    public String getZpgender() {
        return zpgender;
    }

    public void setZpgender(String zpgender) {
        this.zpgender = zpgender;
    }

    public int getWorkingage() {
        return workingage;
    }

    public void setWorkingage(int workingage) {
        this.workingage = workingage;
    }



}
