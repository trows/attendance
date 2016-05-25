package com.trows.attendance.controller;

import com.trows.attendance.entity.Notice;
import com.trows.attendance.service.NoticeService;
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
public class NoticeController {

    @Autowired
    private NoticeService noticeService;


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

    @RequestMapping("/postNotice.do")
    public void postNotice(HttpServletRequest request, HttpServletResponse response){
        Notice notice = new Notice();
        HttpSession session = request.getSession(true);

        String range = request.getParameter("range");
        if (range.equals("department")) range = String.valueOf(session.getAttribute("department"));
        notice.setRange_type(range);
        notice.setAccount_id((Integer) session.getAttribute("account_id"));
        notice.setTitle(request.getParameter("title"));
        notice.setUser_name((String) session.getAttribute("user_name"));
        notice.setContent(request.getParameter("content"));
        System.out.println(notice);
        this.print(response,noticeService.insert(notice,"addNotice"));
    }
}


