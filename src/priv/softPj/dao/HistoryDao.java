package priv.softPj.dao;

import priv.softPj.pojo.History;

import java.util.List;

public interface HistoryDao {
    public void insertHistory(long UID,long imgId);

    public void deleteHistory(long UID,long imgId);

    public List<History> queryHistory(long UID);
}
