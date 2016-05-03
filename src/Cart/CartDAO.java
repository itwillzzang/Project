package Cart;

import java.sql.*;
import java.util.Vector;
import javax.sql.*; 
import javax.naming.*;



public class CartDAO {


	//?��비연�?
		private Connection getConnection() throws Exception{
			Connection con=null;
//			String url="jdbc:mysql://localhost:3306/jspdb";
//			String dbuser="jspid";
//			String dbpass="jsppass";
			//1?���? ?��?��?��버로?��
//			Class.forName("com.mysql.jdbc.Driver");
			//2?���? ?��비연�?
//			con=DriverManager.getConnection(url,dbuser,dbpass);
			
			//커넥?��?? : ?��?��?��베이?��?? ?��결된 Connection 객체�? 미리 ?��?��?��?��
			//???��?�� ???��?�� ?���? ?��?��?��?��마다 ?�� ???�� ?��근하?�� Connection객체 ?��?��
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/yamyam");
			con=ds.getConnection();
			return con;
		}
		 
	    //[?��바구?��?�� ?���?]�? ?���??���? ?��?��?��?�� 것으�? cart ?��?��블에 ?��로운 ?��코드�? 추�?
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
	    
	    //id?�� ?��?��?��?�� ?��코드?�� ?���? ?��?��?��?�� 메소?��
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

		 
	     //id?�� ?��?��?��?�� ?��코드?�� 목록?�� ?��?��?��?�� 메소?��
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
	   
	     //?��바구?��?��?�� ?��?��?�� ?��?��?�� ?��?��?��?�� 메소?��
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
	   
	     //?��바구?��?��?�� cart_id?��???�� ?��코드�? ?��?��?��?�� 메소?��
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
	     
	     //id?�� ?��?��?��?�� 모든 ?��코드�? ?��?��?��?�� 메소?���? [?��바구?�� 비우�?]?��추�?? ?���??�� ?��?��?��?��.
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
