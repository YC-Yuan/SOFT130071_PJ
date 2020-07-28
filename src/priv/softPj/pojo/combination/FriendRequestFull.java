package priv.softPj.pojo.combination;

import java.sql.Timestamp;

public class FriendRequestFull {
    private long requestId;
    private long sendUid;
    private long receiveUid;
    private long status;

    private String email;
    private String userName;
    private Timestamp dateJoined;
    private long showFavor;
    private long uid;


    public long getRequestId() {
        return requestId;
    }

    public void setRequestId(long requestId) {
        this.requestId = requestId;
    }


    public long getSendUid() {
        return sendUid;
    }

    public void setSendUid(long sendUid) {
        this.sendUid = sendUid;
    }


    public long getReceiveUid() {
        return receiveUid;
    }

    public void setReceiveUid(long receiveUid) {
        this.receiveUid = receiveUid;
    }


    public long getStatus() {
        return status;
    }

    public void setStatus(long status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Timestamp getDateJoined() {
        return dateJoined;
    }

    public void setDateJoined(Timestamp dateJoined) {
        this.dateJoined = dateJoined;
    }

    public long getShowFavor() {
        return showFavor;
    }

    public void setShowFavor(long showFavor) {
        this.showFavor = showFavor;
    }

    public long getUid() {
        return uid;
    }

    public void setUid(long uid) {
        this.uid = uid;
    }
}
