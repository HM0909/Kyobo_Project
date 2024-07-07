package product;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductDTO {
    private int isbn; // int로 수정
    private String categoryM;
    private String bookTitle;
    private String author;
    private String publish;
    private String age;
    private String pubDate;
    private int price; // int로 수정
    private String conInfo;
    private String conTable;
    private String bookImg;
    private String bookCover;
    private String bookFile;
    private String sales;
    private String id;
    private int categoryNo; // 카테고리 번호 (10, 20, 30, 40, 50)
}