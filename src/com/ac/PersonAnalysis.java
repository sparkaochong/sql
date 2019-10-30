package com.ac;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.chrono.IsoChronology;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Description:
 * <p>
 * Created by aochong on 2019/10/24
 *
 * @author aochong
 * @version 1.0
 */
public class PersonAnalysis {
    public static void main(String[] args) {
        // 1. 从 CSV 文件中读取每一个人的信息，转成 Person 集合
        List<Person> people = new ArrayList<>();
        try(BufferedReader reader =
                new BufferedReader(
                        new FileReader("." + File.separator + "data" + File.separator + "person.csv"))){
            // 读取并解析 CSV 文件
            Iterable<CSVRecord> records = CSVFormat.newFormat(',')
                    .withFirstRecordAsHeader()
                    .parse(reader);
            for(CSVRecord record:records){
                String name = record.get("name");
                int year = Integer.parseInt(record.get("year"));
                int month = Integer.parseInt(record.get("month"));
                int day = Integer.parseInt(record.get("day"));

                LocalDate birthday = IsoChronology.INSTANCE.date(year,month,day);
                Person.Gender gender = Person.Gender.valueOf(record.get("sex"));
                String email = record.get("email");
                Person person = new Person(name,birthday,gender,email);
                people.add(person);
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        // System.out.println(people);

        // 2. 数据分析
        // 2.1 年龄大于等于18岁，并且小于等于25岁的所有男性信息

        System.out.println("年龄大于等于18岁，并且小于等于25岁的所有男性信息：");
        people.stream()
                .filter(p -> p.getAge()>=18 && p.getAge()<=25 && Person.Gender.MALE == p.getGender())
                .forEach(System.out::println);

        // 2.2 男性有多少人，女性有多少人
        // MALE -> 10
        // FEMALE -> 20
        // KEY -> VALUE 类型
        // 用于存储最终的男女个数信息
        Map<String,Integer> map = new HashMap<>();
        for(Person person:people){
            String gender = person.getGender().toString();
            /*Integer count = map.getOrDefault(gender,0);
            count += 1;
            map.put(gender,count);*/
            map.put(gender,map.getOrDefault(gender,0) + 1);
        }
        System.out.println("分析男性有多少人，女性有多少人：");
        System.out.println(map);

        // JAVA 数据分析：
        // 1. 难
        // 2. 代码比较多

        // 做数据分析简单，代码量少的语言：SQL 语言
        // SQL 语言虽然简单，但是不够灵活
        // Java 非常灵活
    }
}
