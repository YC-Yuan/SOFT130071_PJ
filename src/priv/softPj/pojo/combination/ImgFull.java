package priv.softPj.pojo.combination;

import priv.softPj.pojo.*;

public class ImgFull {
    private Img img;
    private User user;
    private Country country;
    private City city;
    private long favorNum;

    public Img getImg() {
        return img;
    }

    public void setImg(Img img) {
        this.img = img;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public long getFavorNum() {
        return favorNum;
    }

    public void setFavorNum(long favorNum) {
        this.favorNum = favorNum;
    }
}
