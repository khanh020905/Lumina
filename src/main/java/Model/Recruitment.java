package Model;

import java.util.Date;

public class Recruitment {
    private int id;
    private String title, description;
    private Date openDate, closeDate;

    public Recruitment() {}

    public Recruitment(int id, String title, String description, Date openDate, Date closeDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.openDate = openDate;
        this.closeDate = closeDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        this.openDate = openDate;
    }

    public Date getCloseDate() {
        return closeDate;
    }

    public void setCloseDate(Date closeDate) {
        this.closeDate = closeDate;
    }
}
