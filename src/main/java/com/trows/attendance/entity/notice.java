package com.trows.attendance.entity;

/**
 * Created by Throws_exception on 2016/5/24.
 */
public class Notice {
    private int notice_id;
    private int account_id;
    private String user_name;
    private String range_type;
    private String title;
    private String content;
    private String create_time;

    public int getNotice_id() {
        return notice_id;
    }

    public void setNotice_id(int notice_id) {
        this.notice_id = notice_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getRange_type() {
        return range_type;
    }

    public void setRange_type(String range_type) {
        this.range_type = range_type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "notice_id=" + notice_id +
                ", account_id=" + account_id +
                ", user_name='" + user_name + '\'' +
                ", range_type='" + range_type + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", create_time='" + create_time + '\'' +
                '}';
    }
}
