
package Model;


public class Notification {
    private int id;
    private String message;
    private String type;
    private String buttonText;
    private String buttonUrl;
    private int isActive;
    
    public Notification(){}

    public Notification(int id, String message, String type, String buttonText, String buttonUrl, int isActive) {
        this.id = id;
        this.message = message;
        this.type = type;
        this.buttonText = buttonText;
        this.buttonUrl = buttonUrl;
        this.isActive = isActive;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getButtonText() {
        return buttonText;
    }

    public void setButtonText(String buttonText) {
        this.buttonText = buttonText;
    }

    public String getButtonUrl() {
        return buttonUrl;
    }

    public void setButtonUrl(String buttonUrl) {
        this.buttonUrl = buttonUrl;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
    
    
}
