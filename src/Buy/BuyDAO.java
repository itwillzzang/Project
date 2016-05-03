package Buy;
import java.sql.*;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Cart.CartBean;
public class BuyDAO {

	//디비연결
		private Connection getConnection() throws Exception{
			Connection con=null;
//			String url="jdbc:mysql://localhost:3306/jspdb";
//			String dbuser="jspid";
//			String dbpass="jsppass";
			//1단계 드라이버로더
//			Class.forName("com.mysql.jdbc.Driver");
			//2단계 디비연결
//			con=DriverManager.getConnection(url,dbuser,dbpass);
			
			//커넥션풀 : 데이터베이스와 연결된 Connection 객체를 미리 생성하여
			//풀속에 저장해 두고 필요할때마다 이 풀에 접근하여 Connection객체 사용
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/yamyam");
			con=ds.getConnection();
			return con;
		}
	
		// bank테이블에 있는 전체 레코드를 얻어내는 메소드
	    public Vector getAccount(){
	    	Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Vector accountList = null;
	        try {
	            conn = getConnection();
	                        
	            pstmt = conn.prepareStatement("select * from bank");
	            rs = pstmt.executeQuery();
	            
	            accountList = new Vector();
	            
	            while (rs.next()) {
	           	 String account = new String(rs.getString("account")+" "+ rs.getString("bank")+" "+rs.getString("name"));
	           	 accountList.addElement(account);
				 }
	        }catch(Exception ex) {
	        	ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	        return accountList;
	    }
	    
	    //구매 테이블인 buy에 구매목록 등록
	    public void insertBuy( Vector lists,String id, String account, String deliveryName, String deliveryTel,String deliveryAddress) 
	    throws Exception {
	    	Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Timestamp reg_date = null;
	        String sql = "";
	        String maxDate =" ";
	        String number = "";
	        String todayDate = "";
	        String compareDate = "";
	        long buyId = 0;       
	        short nowCount ;
	        try {
	            conn = getConnection();
	            reg_date = new Timestamp(System.currentTimeMillis());
	            todayDate = reg_date.toString();
	            compareDate = todayDate.substring(0, 4) + todayDate.substring(5, 7) + todayDate.substring(8, 10);
	            
	            pstmt = conn.prepareStatement("select max(buy_id) from buy");
	            
	            rs = pstmt.executeQuery();
	            rs.next();
	            if (rs.getLong(1) > 0){         
	            	Long val = new Long(rs.getLong(1));
	                maxDate = val.toString().substring(0, 8);
	                number =  val.toString().substring(8);
	                if(compareDate.equals(maxDate)){
	                	if((Integer.parseInt(number)+1)<10000){
	                	    buyId = Long.parseLong(maxDate + (Integer.parseInt(number)+1+10000));
	                	}else{
	                		buyId = Long.parseLong(maxDate + (Integer.parseInt(number)+1));
	                	}
	                }else{
	                	compareDate += "00001";
	        		    buyId = Long.parseLong(compareDate);
	                }
	            }else {
	            	compareDate += "00001";
	    		    buyId = Long.parseLong(compareDate);
	            }
	            //94~139라인까지 하나의 트랜잭션으로 처리
	            conn.setAutoCommit(false);
	            for(int i=0; i<lists.size();i++){
	            	//해당 아이디에 대한 cart테이블 레코드를을 가져온후 buy테이블에 추가
	            	CartBean cart = (CartBean)lists.elementAt(i);
	            	
	            	sql = "insert into buy (buy_id,buyer,food_id,food_name,buy_price,buy_count,";
	                sql += "food_image,buy_date,account,deliveryName,deliveryTel,deliveryAddress)";
	                sql += " values (?,?,?,?,?,?,?,?,?,?,?,?)";
	                pstmt = conn.prepareStatement(sql);
	            
	                pstmt.setLong(1, buyId);
	                pstmt.setString(2, id);
	                pstmt.setInt(3, cart.getFood_id());
	                pstmt.setString(4, cart.getFood_name());
	                pstmt.setInt(5, cart.getBuy_price());
	                pstmt.setInt(6, cart.getBuy_count());
	                pstmt.setString(7, cart.getFood_image());
	                pstmt.setTimestamp(8, reg_date);
	                pstmt.setString(9, account);
	                pstmt.setString(10, deliveryName);
	                pstmt.setString(11, deliveryTel);
	                pstmt.setString(12, deliveryAddress);
	                pstmt.executeUpdate();
	                
	                //상품이 구매되었으므로 food테이블의 상품수량을 재조정함
	                pstmt = conn.prepareStatement("select food_count from food where food_id=?");
	                pstmt.setInt(1, cart.getFood_id());
	                rs = pstmt.executeQuery();
	                rs.next();
	                
	                nowCount = (short)(rs.getShort(1) - 1);
	                
	                sql = "update food set food_count=? where food_id=?";
	                pstmt = conn.prepareStatement(sql);
	           
	                pstmt.setShort(1, nowCount);
	    			pstmt.setInt(2, cart.getFood_id());
	                
	                pstmt.executeUpdate(); 
	            }
	            
	            pstmt = conn.prepareStatement(
	              "delete from cart where buyer=?");
	            pstmt.setString(1, id);
	          
	            pstmt.executeUpdate();
	            
	            conn.commit();
	            conn.setAutoCommit(true);
	        }catch(Exception ex) {
	        	ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }
	    
	    //id에 해당하는 buy테이블의 레코드수를 얻어내는 메소드
	    public int getListCount(String id)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        int x=0;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select count(*) from buy where buyer=?");
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
	    
	    //buy테이블의 전체 레코드수를 얻어내는 메소드
	    public int getListCount()
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        int x=0;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select count(*) from buy");
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
	    
	    //id에 해당하는 buy테이블의 구매목록을 얻어내는 메소드
	    public Vector getBuyList(String id) 
	    throws Exception {
	   	    Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        BuyBean buy=null;
	        String sql = "";
	        Vector lists = null;
	        
	        try {
	       	 conn = getConnection();
	       	 
	       	 sql = "select * from buy where buyer = ?";
	            pstmt = conn.prepareStatement(sql);
	            
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	            
	            lists = new Vector();

	            while (rs.next()) {
	            	 buy = new BuyBean();
	           	 
	           	     buy.setBuy_id(rs.getLong("buy_id"));    
	           	     buy.setFood_id(rs.getInt("food_id"));
	           	     buy.setFood_name(rs.getString("food_name"));
	           	     buy.setBuy_price(rs.getInt("buy_price"));
	           	     buy.setBuy_count(rs.getByte("buy_count")); 
	           	     buy.setFood_image(rs.getString("food_image"));
	           	     buy.setSanction(rs.getString("sanction"));
	           	 
	           	     lists.addElement(buy);
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
	    
	    //buy테이블의 전체 목록을 얻어내는 메소드
	    public Vector getBuyList() 
	    throws Exception {
	   	    Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        BuyBean buy=null;
	        String sql = "";
	        Vector lists = null;
	        
	        try {
	       	 conn = getConnection();
	       	 
	       	 sql = "select * from buy";
	            pstmt = conn.prepareStatement(sql);
	            rs = pstmt.executeQuery();
	            
	            lists = new Vector();

	            while (rs.next()) {
	            	 buy = new BuyBean();
	           	 
	           	     buy.setBuy_id(rs.getLong("buy_id"));
	           	     buy.setBuyer(rs.getString("buyer"));
	           	     buy.setFood_id(rs.getInt("food_id"));
	           	     buy.setFood_name(rs.getString("food_name"));
	           	     buy.setBuy_price(rs.getInt("buy_price"));
	           	     buy.setBuy_count(rs.getByte("buy_count")); 
	           	     buy.setFood_image(rs.getString("food_image"));
	           	     buy.setBuy_date(rs.getTimestamp("buy_date"));
	           	     buy.setAccount(rs.getString("account"));
	           	     buy.setDeliveryName(rs.getString("deliveryName"));
	           	     buy.setDeliveryTel(rs.getString("deliveryTel"));
	           	     buy.setDeliveryAddress(rs.getString("deliveryAddress"));
	           	     buy.setSanction(rs.getString("sanction"));
	           	 
	           	     lists.addElement(buy);
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

		
		
		
		
		
		
	
}
