package com.trows.attendance.serviceImpl;

import com.trows.attendance.base.AbstractBaseDao;
import com.trows.attendance.entity.Punch;
import com.trows.attendance.service.PunchService;
import org.springframework.stereotype.Service;

/**
 * Created by Throws_exception on 2016/5/24.
 */
@Service
public class PunchServiceImpl extends AbstractBaseDao<Punch,Integer> implements PunchService {
}
