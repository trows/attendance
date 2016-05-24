package com.trows.attendance.serviceImpl;


import com.trows.attendance.base.AbstractBaseDao;
import com.trows.attendance.entity.Account;
import com.trows.attendance.service.AccountService;
import org.springframework.stereotype.Service;

/**
 * Created by Throws_exception on 2016/4/26.
 */
@Service("AccountService")
public class AccountServiceImpl extends AbstractBaseDao<Account,Integer> implements AccountService {
}
