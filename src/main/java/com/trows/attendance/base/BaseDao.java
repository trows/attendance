package com.trows.attendance.base;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Throws_exception on 2015/5/29.
 */
public interface BaseDao <Entity,Key extends Serializable>{
    /**
     * 增删改方法
     * @param entity
     * @param operate
     */
    public void insert(Entity entity, String operate);
    public void update(Entity entity, String operate);
    public void updateByKey(Key key, String operate);
    public void deleteByValue(Entity entity, String operate);
    public void deleteByKey(Key key, String operate);

    /**
     * 获得一列实体
     * @param key
     * @param operate
     * @return
     */
    public List<Entity> getListByKey(Key key, String operate);
    public  List<Entity> getListByValue(Entity entity, String operate);
    public List<Entity> getListByStr(String str, String operate);
    /**
     *ͨ获得一个实体
     * @param key
     * @param operate
     * @return
     */
    public Entity getEntityByKey(Key key, String operate);
    public Entity getEntityByValue(Entity entity, String operate);
    public Entity getEntityByStr(String str, String operate);


    public Long getKeyByValue(Entity entity, String operate);

    public Object getOneObjectByObject(Object obj, String operate);

    public List<Object> getObjectListByObject(Object obj, String operate);



}
