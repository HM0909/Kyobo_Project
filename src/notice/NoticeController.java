package notice;

import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Notice/notice.do")
public class NoticeController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NoticeDAO dao = new NoticeDAO(); // DAO 생성

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (action.equals("list")) {
            // 공지사항 목록을 가져옴
            String searchField = request.getParameter("searchField");
            String searchWord = request.getParameter("searchWord");

            Map<String, Object> param = new HashMap<>();
            
            if (searchWord != null) {
                param.put("searchField", searchField);
                param.put("searchWord", searchWord);
            }

            List<NoticeDTO> noticeList = dao.selectListPage(param);

            // 디버깅 메시지 추가
            if (noticeList == null || noticeList.isEmpty()) {
                System.out.println("No notices found or noticeList is null.");
            } else {
                System.out.println("Notices found: " + noticeList.size());
            }

            request.setAttribute("noticeList", noticeList);
            request.getRequestDispatcher("/NoticeList.jsp").forward(request, response);
        } else if (action.equals("view")) {
            // 공지사항 상세보기
            int num = Integer.parseInt(request.getParameter("num"));
            NoticeDTO notice = dao.selectView(num);
            request.setAttribute("notice", notice);
            request.getRequestDispatcher("/NoticeView.jsp").forward(request, response);
        }

        dao.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
