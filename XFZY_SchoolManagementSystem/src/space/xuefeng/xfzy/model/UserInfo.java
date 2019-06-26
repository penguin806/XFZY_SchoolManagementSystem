package space.xuefeng.xfzy.model;

public class UserInfo {
    private String userinfo_Sex;
    private String userinfo_Idcard_number;
    private String userinfo_Department;
    private String userinfo_Class;
    private String userinfo_Home_address;
    private String userinfo_Train_station;

    public UserInfo() {
    }

    public UserInfo(String userinfo_Sex, String userinfo_Idcard_number, String userinfo_Department, String userinfo_Class, String userinfo_Home_address, String userinfo_Train_station) {
        this.userinfo_Sex = userinfo_Sex;
        this.userinfo_Idcard_number = userinfo_Idcard_number;
        this.userinfo_Department = userinfo_Department;
        this.userinfo_Class = userinfo_Class;
        this.userinfo_Home_address = userinfo_Home_address;
        this.userinfo_Train_station = userinfo_Train_station;
    }


    public String getUserinfo_Sex() {
        return userinfo_Sex;
    }

    public void setUserinfo_Sex(String userinfo_Sex) {
        this.userinfo_Sex = userinfo_Sex;
    }

    public String getUserinfo_Idcard_number() {
        return userinfo_Idcard_number;
    }

    public void setUserinfo_Idcard_number(String userinfo_Idcard_number) {
        this.userinfo_Idcard_number = userinfo_Idcard_number;
    }

    public String getUserinfo_Department() {
        return userinfo_Department;
    }

    public void setUserinfo_Department(String userinfo_Department) {
        this.userinfo_Department = userinfo_Department;
    }

    public String getUserinfo_Class() {
        return userinfo_Class;
    }

    public void setUserinfo_Class(String userinfo_Class) {
        this.userinfo_Class = userinfo_Class;
    }

    public String getUserinfo_Home_address() {
        return userinfo_Home_address;
    }

    public void setUserinfo_Home_address(String userinfo_Home_address) {
        this.userinfo_Home_address = userinfo_Home_address;
    }

    public String getUserinfo_Train_station() {
        return userinfo_Train_station;
    }

    public void setUserinfo_Train_station(String userinfo_Train_station) {
        this.userinfo_Train_station = userinfo_Train_station;
    }
}
