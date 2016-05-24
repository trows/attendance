package com.trows.attendance.serviceImpl;

import com.trows.attendance.base.AbstractBaseDao;
import com.trows.attendance.entity.Notice;
import com.trows.attendance.service.NoticeService;
import org.springframework.stereotype.Service;

/**
 * Created by Throws_exception on 2016/5/24.
 */
@Service
public class NoticeServiceImpl extends AbstractBaseDao<Notice,Integer> implements NoticeService {
}
