package priv.softPj.pojo;


public class City {

  private long cityId;
  private String cityName;
  private String countryCode;
  private long population;
  private String timeZone;


  public long getCityId() {
    return cityId;
  }

  public void setCityId(long cityId) {
    this.cityId = cityId;
  }


  public String getCityName() {
    return cityName;
  }

  public void setCityName(String cityName) {
    this.cityName = cityName;
  }


  public String getCountryCode() {
    return countryCode;
  }

  public void setCountryCode(String countryCode) {
    this.countryCode = countryCode;
  }


  public long getPopulation() {
    return population;
  }

  public void setPopulation(long population) {
    this.population = population;
  }


  public String getTimeZone() {
    return timeZone;
  }

  public void setTimeZone(String timeZone) {
    this.timeZone = timeZone;
  }

}
