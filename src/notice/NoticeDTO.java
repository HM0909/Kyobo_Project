package notice;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
    private int num;
    private String title;
    private String content;
    private java.sql.Date regidate;


}