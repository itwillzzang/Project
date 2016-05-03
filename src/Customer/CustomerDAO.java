package Customer;

import java.sql.*;
import javax.sql.*; 
import javax.naming.*;

public class CustomerDAO {
	private Connection getConnection() throws Exception{
		Connection con=null;
//		String url="jdbc:mysql://localhost:3306/jspdb";
//		String dbuser="jspid";
//		String dbpass="jsppass";
		//1단계 드라이버로더
//		Class.forName("com.mysql.jdbc.Driver");
		//2단계 디비연결
//		con=DriverManager.getConnection(url,dbuser,dbpass);
		
		//커넥션풀 : 데이터베이스와 연결된 Connection 객체를 미리 생성하여
		//풀속에 저장해 두고 필요할때마다 이 풀에 접근하여 Connection객체 사용
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/yamyam");
		con=ds.getConnection();
		return con;
	}
	
	 //회원가입
    public void insertMember(CustomerBean member2) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        String sql="";
        
        try {
            conn = getConnection();
           
           
            pstmt = conn.prepareStatement(
           	 "insert into member values (?,?,?,?,?,?,?,?)");
            pstmt.setString(1, member2.getId());
            pstmt.setString(2, member2.getPasswd());
            pstmt.setString(3, member2.getName());
            pstmt.setTimestamp(4, member2.getReg_date());
            pstmt.setString(5, member2.getTel());
            pstmt.setString(6, member2.getAddress());
          
            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

	 public int userCheck(String id, String passwd) //사용자 인증처리
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
         String dbpasswd="";
		 int x=-1;
       
		 try {
			conn = getConnection();
           
            pstmt = conn.prepareStatement(
            	"select passwd from member where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd))
					x= 1; //인증 성공
				else
					x= 0; //비밀번호 틀림
			}else
				x= -1;//해당 아이디 없음
         }catch(Exception ex) {
        	 ex.printStackTrace();
         } finally {
			 if (rs != null) try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
	 }

	 public int confirmId(String id) //중복아이디 체크
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
		 int x=-1;
       
		 try {
			 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	  "select id from member where id = ?");
             pstmt.setString(1, id);
             rs= pstmt.executeQuery();

			 if(rs.next())
				 x= 1; //해당 아이디 있음
			 else
				 x= -1;//해당 아이디 없음		
         }catch(Exception ex) {
             ex.printStackTrace();
         } finally {
			 if (rs != null) try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
	 }

     public CustomerBean getMember(String id) //회원정보를 수정하기 위해 기존의 정보를 표시
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         CustomerBean member=null;
         
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	     "select * from member where id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();

             if (rs.next()) {
            	 member = new CustomerBean();
            	 
                 member.setId(rs.getString("id"));
                 member.setPasswd(rs.getString("passwd"));
				 member.setName(rs.getString("name"));
				 member.setReg_date(rs.getTimestamp("m_date")); 
                 member.setTel(rs.getString("mobile"));
                 member.setAddress(rs.getString("address"));     
			 }
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (rs != null) try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
		 return member;
     }
   
     public void updateMember(CustomerBean member) //회원의 정보수정
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
       
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
               "update member set passwd=?,name=?,tel=?,address=? "+
               "where id=?");
             pstmt.setString(1, member.getPasswd());
             pstmt.setString(2, member.getName());
             pstmt.setString(3, member.getTel());
             pstmt.setString(4, member.getAddress());
             pstmt.setString(5, member.getId());
           
             pstmt.executeUpdate();
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
     }
   
     public int deleteMember(String id, String passwd) //회원탈퇴
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs= null;
         String dbpasswd="";
         int x=-1;
         
         try {
			 conn = getConnection();

             pstmt = conn.prepareStatement(
           	  "select passwd from member where id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
           
			 if(rs.next()){
				 dbpasswd= rs.getString("passwd"); 
				 if(dbpasswd.equals(passwd)){
					 pstmt = conn.prepareStatement(
           	             "delete from member where id=?");
                     pstmt.setString(1, id);
                     pstmt.executeUpdate();
					 x= 1; //회원탈퇴 성공
				 }else
					 x= 0; //비밀번호 틀림
			 }
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (rs != null) try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
     }
	
	
	
	
}
