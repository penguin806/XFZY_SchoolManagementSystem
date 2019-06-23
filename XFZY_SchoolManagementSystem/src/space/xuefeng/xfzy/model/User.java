package space.xuefeng.xfzy.model;

public class User {
    private String userId;
    private String userName;
    private String userPassword;
    private String userEmail;
    private String userRole;
    private String userRemarks;

    private UserInfo user_Info;

    public User() {
    }

    public User(String userName, String userPassword) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.user_Info = null;
    }

    public User(String userId, String userName, String userPassword, String userEmail, String userRole, String userRemarks, UserInfo user_Info) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userRole = userRole;
        this.userRemarks = userRemarks;

        this.user_Info = user_Info;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getUserRemarks() {
        return userRemarks;
    }

    public void setUserRemarks(String userRemarks) {
        this.userRemarks = userRemarks;
    }

    public UserInfo getUser_Info() {
        return user_Info;
    }

    public void setUser_Info(UserInfo user_Info) {
        this.user_Info = user_Info;
    }
}
