package com.trows.attendance.controller;


import com.alibaba.fastjson.JSON;
import com.trows.attendance.entity.Account;
import com.trows.attendance.entity.Punch;
import com.trows.attendance.entity.Salary;
import com.trows.attendance.service.AccountService;
import com.trows.attendance.service.PunchService;
import com.trows.attendance.service.SalaryService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * Created by Throws_exception on 2015/12/28.
 */
@Controller
public class AccountController {

    @Autowired
    private AccountService accountService;
    @Autowired
    private PunchService punchService;
    @Autowired
    private SalaryService salaryService;

    private void print(HttpServletResponse response, String value) {
        try {
            response.getWriter().print(value);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void print(HttpServletResponse response, int value) {
        try {
            response.getWriter().print(value);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/createAccount.do")
    public void createAccount(@RequestParam("account") String accountStr, HttpServletResponse response) {
        Account account = JSON.parseObject(accountStr, Account.class);

        int result = accountService.insert(account, "createAccount");
        account.setPassword(DigestUtils.md5Hex(DigestUtils.sha1Hex(account.getAccount_id() + "")));
        accountService.update(account, "setPassword");
        Punch punch = new Punch();
        punch.setAccount_id(account.getAccount_id());
        punchService.insert(punch,"initPunch");
        Salary salary = new Salary();
        salary.setAccount_id(account.getAccount_id());
        salary.setBase_wage(Float.parseFloat(JSON.parseObject(accountStr).getString("base_wage")));
        salaryService.insert(salary,"initSalary");
        this.print(response, result);
    }

    @RequestMapping("/checkLogin.do")
    public String checkLogin(HttpServletRequest request, @RequestParam("form-username") String user_name, @RequestParam("form-password") String password) {
        int account_id;
        if (user_name != null) {
            account_id = Integer.parseInt(user_name);
        } else {
            return "redirect:./index.html";
        }
        Account account = accountService.getEntityByKey(account_id, "getAccountById");
        if (account!=null && account.getPassword().equals(DigestUtils.md5Hex(DigestUtils.sha1Hex(password)))) {
            HttpSession session = request.getSession(true);
            session.setAttribute("account_id", account_id);
            session.setAttribute("user_name", account.getUser_name());
            session.setAttribute("department", account.getDepartment());

            switch (account.getLevel()) {
                case 3:
                    return "redirect:./manageInfo.html";
                default:
                    return "redirect:./toEmployeesPage.htm";
            }

        }
        return "redirect:./index.html?return_code=300";
    }

    @RequestMapping("/toEmployeesPage.htm")
    public String toEmployeesPage(HttpServletRequest request){
        int account_id = (Integer)request.getSession(true).getAttribute("account_id");
        Account account = accountService.getEntityByKey(account_id, "getAccountById");
        request.setAttribute("account",account);
        Punch punch = punchService.getEntityByKey(account_id,"getPunchById");
        Salary salary = salaryService.getEntityByKey(account_id,"getSalaryById");
        if(salary.getCount_wage() == null){
            salary.setCount_wage("0");
        }else {
            SimpleDateFormat df = new SimpleDateFormat("MM");
            int now = Integer.parseInt(df.format(new Date()));
            String month_wage = JSON.parseObject(salary.getCount_wage()).getString(String.valueOf(now-1));
            if(month_wage!=null){
                salary.setCount_wage(month_wage);
            }else {
                salary.setCount_wage("0");
            }
        }
        request.setAttribute("salary",salary);
        request.setAttribute("punch",punch);
        return "./employees_page";
    }

    @RequestMapping("/changePassword.do")
    public void changePassword(HttpServletRequest request,HttpServletResponse response){
        String origin = request.getParameter("origin");
        String change = request.getParameter("change");
        int account_id = (Integer)request.getSession(true).getAttribute("account_id");
        Account account = accountService.getEntityByKey(account_id, "getAccountById");
        if(account.getPassword().equals(DigestUtils.md5Hex(DigestUtils.sha1Hex(origin)))){
            account.setPassword(DigestUtils.md5Hex(DigestUtils.sha1Hex(change)));
            this.print(response,accountService.update(account, "setPassword"));
        }else {
            this.print(response,0);
        }

    }

}
