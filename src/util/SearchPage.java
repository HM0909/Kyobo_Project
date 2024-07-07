package util;

public class SearchPage {
    public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String reqUrl, String query) {
        StringBuilder pagingStr = new StringBuilder();

        int totalPages = (int) (Math.ceil((double) totalCount / pageSize));

        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
        if (pageTemp != 1) {
            pagingStr.append("<a href='").append(reqUrl).append("?query=").append(query)
                     .append("&pageSize=").append(pageSize).append("&pageNum=1'>&laquo;</a>");
            pagingStr.append("<a href='").append(reqUrl).append("?query=").append(query)
                     .append("&pageSize=").append(pageSize).append("&pageNum=").append(pageTemp - 1).append("'>&lsaquo;</a>");
        }

        int blockCount = 1;
        while (blockCount <= blockPage && pageTemp <= totalPages) {
            if (pageTemp == pageNum) {
                pagingStr.append("<a class='active'>").append(pageTemp).append("</a>");
            } else {
                pagingStr.append("<a href='").append(reqUrl).append("?query=").append(query)
                         .append("&pageSize=").append(pageSize).append("&pageNum=").append(pageTemp).append("'>").append(pageTemp).append("</a>");
            }
            pageTemp++;
            blockCount++;
        }

        if (pageTemp <= totalPages) {
            pagingStr.append("<a href='").append(reqUrl).append("?query=").append(query)
                     .append("&pageSize=").append(pageSize).append("&pageNum=").append(pageTemp).append("'>&rsaquo;</a>");
            pagingStr.append("<a href='").append(reqUrl).append("?query=").append(query)
                     .append("&pageSize=").append(pageSize).append("&pageNum=").append(totalPages).append("'>&raquo;</a>");
        }

        return pagingStr.toString();
    }
}
