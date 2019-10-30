package com.ac;

import java.time.LocalDate;
import java.time.chrono.IsoChronology;

/**
 * Description:
 * <p>
 * Created by aochong on 2019/10/24
 *
 * @author aochong
 * @version 1.0
 */
public class Person {
    enum Gender{
        MALE,FEMALE
    }

    private String name;
    private LocalDate birthday;
    private Gender gender;
    private String email;

    public Person(String name, LocalDate birthday, Gender gender, String email) {
        this.name = name;
        this.birthday = birthday;
        this.gender = gender;
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return birthday.until(IsoChronology.INSTANCE.dateNow()).getYears();
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                ", birthday=" + birthday +
                ", gender=" + gender +
                ", email='" + email + '\'' +
                '}';
    }
}
