package kr.co.groovy.utils;

import com.google.gson.Gson;

import java.util.HashMap;

public class ParamMap extends HashMap<String, Object> {
    private static ParamMap param = null;

    private ParamMap() {
    }

    public static ParamMap init() {
        return new ParamMap();
    }

    public String getString(String key) {
        Object object = this.get(key);
        if (object == null) {
            return null;
        } else {
            return String.valueOf(object);
        }
    }

    public Integer getInt(String key) {
        Object object = this.get(key);
        if (object == null) {
            return null;
        } else {
            return Integer.parseInt(String.valueOf(object));
        }
    }

    public <T> T get(String key, Class<T> clazz) {
        Object object = this.get(key);
        return (T) object;
    }

    // ParamMap을 JSON 문자열로 직렬화
    public String toJson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

    // JSON 문자열을 ParamMap으로 역직렬화
    public static ParamMap fromJson(String json) {
        Gson gson = new Gson();
        return gson.fromJson(json, ParamMap.class);
    }
}
