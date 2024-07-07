package banner;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BannerDTO {
    private int id;
    private String imagePath;
    private String title;
    private String description;
}