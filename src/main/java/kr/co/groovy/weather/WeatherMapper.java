package kr.co.groovy.weather;

public interface WeatherMapper {

    void saveWeather(String data);
    String loadWeather();

}
