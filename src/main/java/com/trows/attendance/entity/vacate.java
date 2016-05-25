package com.trows.attendance.entity;

/**
 * Created by Throws_exception on 2016/5/24.
 */
public class Vacate {

    private int id;
    private int account_id;
    private String user_name;
    private String department;
    private String start_time;
    private int day_num;
    private String reason;
    private int postil;
    private String postilReason;
    private String create_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public int getDay_num() {
        return day_num;
    }

    public void setDay_num(int day_num) {
        this.day_num = day_num;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getPostil() {
        return postil;
    }

    public void setPostil(int postil) {
        this.postil = postil;
    }

    public String getPostilReason() {
        return postilReason;
    }

    public void setPostilReason(String postilReason) {
        this.postilReason = postilReason;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    @Override
    public String toString() {
        return "Vacate{" +
                "id=" + id +
                ", account_id=" + account_id +
                ", user_name='" + user_name + '\'' +
                ", department='" + department + '\'' +
                ", start_time='" + start_time + '\'' +
                ", day_num=" + day_num +
                ", reason='" + reason + '\'' +
                ", postil=" + postil +
                ", create_time='" + create_time + '\'' +
                '}';
    }
}
