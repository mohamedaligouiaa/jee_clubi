package club;

import java.sql.Date;

public class Evenement {
    private int id;
    private String titre;
    private String description;
    private String categorie;
    private Date date_event;
    private String lieu;
    private int capacite;
    private int club_id;

    public Evenement(int id, String titre, String description, String categorie, Date date_event, String lieu, int capacite, int club_id) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.categorie = categorie;
        this.date_event = date_event;
        this.lieu = lieu;
        this.capacite = capacite;
        this.club_id = club_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public Date getDate_event() {
        return date_event;
    }

    public void setDate_event(Date date_event) {
        this.date_event = date_event;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public int getClub_id() {
        return club_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }
}
