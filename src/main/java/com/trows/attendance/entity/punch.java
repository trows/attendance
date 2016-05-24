package com.trows.attendance.entity;

/**
 * Created by Throws_exception on 2016/5/24.
 */
public class Punch {

    private int account_id;
    private int day_time;
    private int month_time;
    private String year_count;
    private int flag;
    private int vacate_time;

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public int getDay_time() {
        return day_time;
    }

    public void setDay_time(int day_time) {
        this.day_time = day_time;
    }

    public int getMonth_time() {
        return month_time;
    }

    public void setMonth_time(int month_time) {
        this.month_time = month_time;
    }

    public String getYear_count() {
        return year_count;
    }

    public void setYear_count(String year_count) {
        this.year_count = year_count;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public int getVacate_time() {
        return vacate_time;
    }

    public void setVacate_time(int vacate_time) {
        this.vacate_time = vacate_time;
    }
}
