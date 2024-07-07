package order;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDTO {
	   private long order_id;
	    private String user_id;
	    private Timestamp order_date;
	    private double total_amount;
}
