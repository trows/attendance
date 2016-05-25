package com.trows.attendance.controller;

import com.trows.attendance.entity.Punch;
import com.trows.attendance.entity.Vacate;
import com.trows.attendance.service.PunchService;
import com.trows.attendance.service.VacateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Throws_exception on 2016/5/25.
 */
@Controller
public class VacateController {

    @Autowired
    private VacateService vacateService;
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


    @RequestMapping("/vacate.do")
    public void vacate(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        Vacate vacate = new Vacate();
        vacate.setAccount_id((Integer) session.getAttribute("account_id"));
        vacate.setUser_name((String) session.getAttribute("user_name"));
        vacate.setDepartment((String) session.getAttribute("department"));
        vacate.setStart_time(request.getParameter("start_time"));
        vacate.setDay_num(Integer.parseInt(request.getParameter("day_num")));
        vacate.setReason(request.getParameter("reason"));
        System.out.println(vacate);
        this.print(response,vacateService.insert(vacate,"vacate"));
    }

    @RequestMapping("/postil.do")
    public void postil(HttpServletRequest request,HttpServletResponse response){
        Vacate vacate = vacateService.getEntityByKey(Integer.parseInt(request.getParameter("id")),"getVacateById");

        if(vacate.getPostil() == 2){
            vacate.setPostil(Integer.parseInt(request.getParameter("postil")));
            vacate.setPostilReason(request.getParameter("postilReason"));
            vacate.setId(Integer.parseInt(request.getParameter("id")));
            this.print(response,vacateService.update(vacate,"postil"));
            Punch punch = new Punch();
            punch.setVacate_time(vacate.getDay_num());
            punch.setAccount_id(vacate.getAccount_id());
            punchService.update(punch,"setVacatePunch");
        }else {
            this.print(response,"400");
        }




    }

}
