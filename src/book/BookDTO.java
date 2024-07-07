package book;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookDTO {
	private String idx;
	private int isbn;
    private String categorym;
    private String booktitle;
    private String author;
    private String publish;
    private String age;
    private String pubdate;
    private int price;
    private String coninfo;
    private String contable;
    private String bookimg;
    private String bookcover;
    private String bookfile;
    private String sales;
    private String id;
    private int catagoryno;
    private String catagoryname;
    private java.sql.Date regidate;
    private String ofile;  // 원본 파일명
    private String sfile;  // 저장된 파일명
}