package companymember;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class MemberDTO {
	private String id;
    private String password;
    private String name;
    private String nameno;
    private String phone;
    private String address;
    private String email;
    private String bank;
    private String accname;
    private String bankno;
    private java.sql.Date regidate;
    
	public void setPhone(String phone1, String phone2, String phone3) {
        this.phone = phone1 + phone2 + phone3;
    }

    public void setAddress(String postcode, String address, String detailAddress, String extraAddress) {
        this.address = postcode + "," + address + "," + detailAddress + "," + extraAddress;
    }

    public void setEmail(String emailAccount, String emailDomain) {
        this.email = emailAccount + "@" + emailDomain;
    }
}
