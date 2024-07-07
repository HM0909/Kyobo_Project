package cart;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import product.ProductDTO;

@Getter
@Setter
public class CartDTO {
    private long cart_id;
    private String user_id;
    private String isbn;
    private int quantity;
    private Date added_at; // 추가된 필드
    private ProductDTO productDetail;

    
}
