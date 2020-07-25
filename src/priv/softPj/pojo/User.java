package priv.softPj.pojo;


public class User {

  private long uid;
  private String email;
  private String userName;
  private String password;
  private long showFavor;
  private java.sql.Timestamp dateJoined;
  private java.sql.Timestamp dateLastModified;
  private String salt;


  public long getUid() {
    return uid;
  }

  public void setUid(long uid) {
    this.uid = uid;
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


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public long getShowFavor() {
    return showFavor;
  }

  public void setShowFavor(long showFavor) {
    this.showFavor = showFavor;
  }


  public java.sql.Timestamp getDateJoined() {
    return dateJoined;
  }

  public void setDateJoined(java.sql.Timestamp dateJoined) {
    this.dateJoined = dateJoined;
  }


  public java.sql.Timestamp getDateLastModified() {
    return dateLastModified;
  }

  public void setDateLastModified(java.sql.Timestamp dateLastModified) {
    this.dateLastModified = dateLastModified;
  }


  public String getSalt() {
    return salt;
  }

  public void setSalt(String salt) {
    this.salt = salt;
  }

}
