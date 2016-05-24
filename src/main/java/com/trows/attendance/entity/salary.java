package com.trows.attendance.entity;

/**
 * Created by Throws_exception on 2016/5/24.
 */
public class Salary {
    private int account_id;
    private float base_wage;
    private String count_wage;
    private String other_wage;

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public float getBase_wage() {
        return base_wage;
    }

    public void setBase_wage(float base_wage) {
        this.base_wage = base_wage;
    }

    public String getCount_wage() {
        return count_wage;
    }

    public void setCount_wage(String count_wage) {
        this.count_wage = count_wage;
    }

    public String getOther_wage() {
        return other_wage;
    }

    public void setOther_wage(String other_wage) {
        this.other_wage = other_wage;
    }
}
