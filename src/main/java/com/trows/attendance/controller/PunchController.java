package com.trows.attendance.controller;

import com.trows.attendance.entity.Punch;
import com.trows.attendance.service.PunchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Throws_exception on 2016/5/24.
 */
@Controller
public class PunchController {

    @Autowired
    private PunchService punchService;

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

    @RequestMapping("/punch.do")
    public void punch(HttpServletRequest request, HttpServletResponse response) {
        int account_id = (Integer) request.getSession(true).getAttribute("account_id");
        int flag = Integer.parseInt(request.getParameter("flag"));
        Punch punch = punchService.getEntityByKey(account_id, "getPunchById");
        int nowFlag = punch.getDay_time() + 1;

        if (flag > punch.getFlag()) {
            punch.setFlag(flag);
            if (nowFlag == flag) {
                punch.setDay_time(nowFlag);
                this.print(response,punchService.update(punch, "punch"));
            } else if (nowFlag == 1 && flag == 2) {
                punch.setDay_time(nowFlag);
                this.print(response,punchService.update(punch, "punch"));
            } else {
                this.print(response, 0);
            }
        } else {
            this.print(response, 0);
        }


    }


}
