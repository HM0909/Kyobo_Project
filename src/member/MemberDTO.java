package member;

import lombok.Getter;
import lombok.Setter;
import java.sql.Date;

@Getter
@Setter
public class MemberDTO {
	private String user_id;
	private String user_pw;
	private String name;
	private java.sql.Date age;
	private String email;
	private java.sql.Date postdate;
	
}
