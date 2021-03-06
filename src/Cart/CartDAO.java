package Cart;

import java.sql.*;
import java.util.Vector;
import javax.sql.*; 
import javax.naming.*;



public class CartDAO {


	//?λΉμ°κ²?
		private Connection getConnection() throws Exception{
			Connection con=null;
//			String url="jdbc:mysql://localhost:3306/jspdb";
//			String dbuser="jspid";
//			String dbpass="jsppass";
			//1?¨κ³? ??Ό?΄λ²λ‘?
//			Class.forName("com.mysql.jdbc.Driver");
			//2?¨κ³? ?λΉμ°κ²?
//			con=DriverManager.getConnection(url,dbuser,dbpass);
			
			//μ»€λ₯??? : ?°?΄?°λ² μ΄?€?? ?°κ²°λ Connection κ°μ²΄λ₯? λ―Έλ¦¬ ??±??¬
			//???? ???₯?΄ ?κ³? ??? ?λ§λ€ ?΄ ??? ? κ·Όν?¬ Connectionκ°μ²΄ ?¬?©
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/yamyam");
			con=ds.getConnection();
			return con;
		}
		 
	    //[?₯λ°κ΅¬?? ?΄κΈ?]λ₯? ?΄λ¦??λ©? ???? κ²μΌλ‘? cart ??΄λΈμ ?λ‘μ΄ ? μ½λλ₯? μΆκ?
	    public void insertCart(CartBean cart) 
	    throws Exception {
	    	Connection conn = null;
	        PreparedStatement pstmt = null;
	        String sql="";
	        
	        try {
	            conn = getConnection();
	            sql = "insert into cart (food_id, buyer,food_name,buy_price,buy_count,food_image) values (?,?,?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);
	            
	            pstmt.setInt(1, cart.getFood_id());
	            pstmt.setString(2, cart.getBuyer());
	            pstmt.setString(3, cart.getFood_name());
	            pstmt.setInt(4, cart.getBuy_price());
	            pstmt.setInt(5, cart.getBuy_count());
	            pstmt.setString(6, cart.getFood_image());
	            
	            pstmt.executeUpdate();
	        }catch(Exception ex) {
	        	ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }
	    
	    //id? ?΄?Ή?? ? μ½λ? ?λ₯? ?»?΄?΄? λ©μ?
	    public int getListCount(String id)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        int x=0;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select count(*) from cart where buyer=?");
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	               x= rs.getInt(1);
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	    }

		 
	     //id? ?΄?Ή?? ? μ½λ? λͺ©λ‘? ?»?΄?΄? λ©μ?
	     public Vector getCart(String id) 
	     throws Exception {
	    	 Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         CartBean cart=null;
	         String sql = "";
	         Vector lists = null;
	         
	         try {
	        	 conn = getConnection();
	        	 
	        	 sql = "select * from cart where buyer = ?";
	             pstmt = conn.prepareStatement(sql);
	             
	             pstmt.setString(1, id);
	             rs = pstmt.executeQuery();
	             
	             lists = new Vector();

	             while (rs.next()) {
	            	 cart = new CartBean();
	            	 
	            	 cart.setCart_id(rs.getInt("cart_id"));
	            	 cart.setFood_id(rs.getInt("food_id"));
	            	 cart.setFood_name(rs.getString("food_name"));
	            	 cart.setBuy_price(rs.getInt("buy_price"));
	            	 cart.setBuy_count(rs.getInt("buy_count")); 
	            	 cart.setFood_image(rs.getString("food_image"));
	            	 
	            	 lists.addElement(cart);
				 }
	         }catch(Exception ex) {
	             ex.printStackTrace();
	         }finally {
	             if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	         }
			 return lists;
	     }
	   
	     //?₯λ°κ΅¬??? ??? ?? ? ?€??? λ©μ?
	     public void updateCount(int cart_id, int count) 
	     throws Exception {
	    	 Connection conn = null;
	         PreparedStatement pstmt = null;
	       
	         try {
	        	 conn = getConnection();
	            
	             pstmt = conn.prepareStatement(
	               "update cart set buy_count=? where cart_id=?");
	             pstmt.setInt(1, count);
	             pstmt.setInt(2, cart_id);
	                        
	             pstmt.executeUpdate();
	         }catch(Exception ex) {
	             ex.printStackTrace();
	         }finally {
	             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	         }
	     }
	   
	     //?₯λ°κ΅¬??? cart_id???? ? μ½λλ₯? ?­? ?? λ©μ?
	     public void deleteList(int cart_id) 
	     throws Exception {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	               
	         try {
				 conn = getConnection();

	             pstmt = conn.prepareStatement(
	           	   "delete from  cart where cart_id=?");
	             pstmt.setInt(1, cart_id);
	             
	             pstmt.executeUpdate();
	         }catch(Exception ex) {
	             ex.printStackTrace();
	         }finally {
	             
	             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	         }
	     }
	     
	     //id? ?΄?Ή?? λͺ¨λ  ? μ½λλ₯? ?­? ?? λ©μ?λ‘? [?₯λ°κ΅¬? λΉμ°κΈ?]?¨μΆλ?? ?΄λ¦?? ?€???€.
	     public void deleteAll(String id)
	     throws Exception {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	                  
	         try {
				 conn = getConnection();

	             pstmt = conn.prepareStatement(
	               "delete from cart where buyer=?");
	             pstmt.setString(1, id);
	             
	             pstmt.executeUpdate();
	         }catch(Exception ex) {
	             ex.printStackTrace();
	         }finally {
	             if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	             if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	         }
	     }
	
		
		
	
	
}
