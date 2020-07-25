package priv.softPj.service.impl;

import priv.softPj.dao.impl.HistoryDaoImpl;
import priv.softPj.dao.impl.ImgDaoImpl;
import priv.softPj.pojo.History;
import priv.softPj.pojo.Img;
import priv.softPj.pojo.combination.ImgHistory;
import priv.softPj.service.ImgHistoryService;

import java.util.ArrayList;
import java.util.List;

public class ImgHistoryImpl implements ImgHistoryService {
    @Override
    public List<ImgHistory> queryHistory(long UID) {
        HistoryDaoImpl historyDao = new HistoryDaoImpl();
        ImgDaoImpl imgDao = new ImgDaoImpl();

        List<History> histories = historyDao.queryHistory(UID);
        List<ImgHistory> imgHistoryList = new ArrayList<ImgHistory>();

        for (History history : histories) {
            ImgHistory imgHistory = new ImgHistory();
            Img img=imgDao.queryImgById(history.getImageId());

            imgHistory.setHistory(history);
            imgHistory.setImg(img);

            imgHistoryList.add(imgHistory);
        }

        return imgHistoryList;
    }
}
