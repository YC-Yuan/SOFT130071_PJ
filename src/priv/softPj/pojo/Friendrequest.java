package priv.softPj.pojo;


public class Friendrequest {

    private long requestId;
    private long sendUid;
    private long receiveUid;
    private long status;


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

}
