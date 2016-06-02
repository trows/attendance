package com.trows.attendance.common.task;

import com.trows.attendance.service.PunchService;
import com.trows.attendance.serviceImpl.PunchServiceImpl;

/**
 * Created by Throws_exception on 2016/6/2.
 */
public class resetPunch {

    public void reset(){
        PunchService punchService = new PunchServiceImpl();

        punchService.updateByKey(1,"resetPunch");

    }

}
