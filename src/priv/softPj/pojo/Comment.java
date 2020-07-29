package priv.softPj.pojo;


import java.sql.Timestamp;

public class Comment {

    private long imageId;
    private long uid;
    private String comment;
    private String userName;
    private java.sql.Timestamp time;
    private long commentId;
    private long favorNum;


    public long getImageId() {
        return imageId;
    }

    public void setImageId(long imageId) {
        this.imageId = imageId;
    }


    public long getUid() {
        return uid;
    }

    public void setUid(long uid) {
        this.uid = uid;
    }


    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }





    public long getCommentId() {
        return commentId;
    }

    public void setCommentId(long commentId) {
        this.commentId = commentId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public long getFavorNum() {
        return favorNum;
    }

    public void setFavorNum(long favorNum) {
        this.favorNum = favorNum;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}
