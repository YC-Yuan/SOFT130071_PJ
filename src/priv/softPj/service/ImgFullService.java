package priv.softPj.service;

import priv.softPj.pojo.Img;
import priv.softPj.pojo.combination.ImgFull;

import java.util.List;

public interface ImgFullService {
    public ImgFull queryImgFull(long imgId);

    public List<ImgFull> queryImgHot(long num);

    public List<ImgFull> queryImgNew(long num);
}
