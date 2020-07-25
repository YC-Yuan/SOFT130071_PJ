package priv.softPj.service;

import priv.softPj.pojo.combination.ImgHistory;

import java.util.List;

public interface ImgHistoryService {
    public List<ImgHistory> queryHistory(long UID);
}
