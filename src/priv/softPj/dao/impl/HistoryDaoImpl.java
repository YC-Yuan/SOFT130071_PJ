package priv.softPj.dao.impl;

import priv.softPj.dao.HistoryDao;
import priv.softPj.pojo.History;

import java.util.List;

public class HistoryDaoImpl extends BaseDao implements HistoryDao {
    @Override
    public void insertHistory(long UID, long imgId) {
        deleteHistory(UID, imgId);
        String sql = "insert into history(UID,ImageID) values(?,?)";
        update(sql, UID, imgId);
    }

    @Override
    public void deleteHistory(long UID, long imgId) {
        String sql = "delete from history where UID=? and ImageID=?";
        update(sql, UID, imgId);
    }

    @Override
    public List<History> queryHistory(long UID) {
        String sql = "select * from history where UID=? order by HistoryID DESC limit 10";
        return queryForList(History.class, sql, UID);
    }
}
