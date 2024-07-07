package member;

import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/PwFind.do")
public class MemberPwFindController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/FindPw.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        MemberDAO dao = new MemberDAO();
        String userPw = dao.findPwByEmail(email);
        dao.close();

        String message;
        if (userPw != null) {
            try {
                sendEmail(email, userPw);
                message = "입력하신 이메일 주소로 비밀번호를 전송했습니다.";
            } catch (RuntimeException e) {
                message = "이메일 전송에 실패했습니다. 다시 시도해 주세요.";
            }
        } else {
            message = "입력하신 이메일로 등록된 비밀번호가 없습니다.";
        }

        req.setAttribute("message", message);
        req.getRequestDispatcher("/FindResult.jsp").forward(req, resp);
    }

    private void sendEmail(String to, String userPw) {
        final String username = "vkxkd100@naver.com"; // 네이버 이메일 주소
        final String password = "!@fkzkd123"; // 네이버 이메일 비밀번호 또는 앱 비밀번호

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.naver.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("교보문고 비밀번호 찾기");
            message.setText("회원님의 비밀번호는 " + userPw + " 입니다.");

            Transport.send(message);
            System.out.println("Sent message successfully...");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
