package shop;
import java.sql.*;
import java.util.Vector;
import javax.sql.*; 
import javax.naming.*;

public class ShopDAO {

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
	


	    
	    //책 등록 메소드
	    public void insertFood(ShopBean food) 
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        System.out.println("1");
	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement(
	            	"insert into food values (?,?,?,?,?,?,?,?)");
	            pstmt.setInt(1,food.getFood_id());
	            pstmt.setString(2, food.getFood_kind());
	            pstmt.setString(3, food.getFood_name());
	            pstmt.setInt(4, food.getFood_price());
	            pstmt.setInt(5,food.getFood_count());
				pstmt.setString(6, food.getFood_image());
	          
				pstmt.setString(7, food.getFood_content());
				
				pstmt.setTimestamp(8, food.getReg_date());
				
				
	            pstmt.executeUpdate();
	       
	        } catch(Exception ex) {
	           
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	        System.out.println("3");
	    }
	   
	    //이미등록된 책을 검증
		public int registedFoodconfirm(String kind, String FoodName) 
		throws Exception {
			Connection conn = null;
	        PreparedStatement pstmt = null;
			ResultSet rs= null;
			int x=-1;
	        
			try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement(
	            	"select book_name from book where food_kind = ? and food_name = ?");
	            pstmt.setString(1, kind);
	            pstmt.setString(2, FoodName);
	            
	            rs= pstmt.executeQuery();

				if(rs.next())
					x= 1; //해당 책이 이미 등록되어 있음
				else
					x= -1;//해당 책이 이미 등록되어 있지 않음	
				
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
		}
	    
		// 전체등록된 책의 수를 얻어내는 메소드
		public int getFoodCount()
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        int x=0;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select count(*) from food");
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
	
	

		// 분류별또는 전체등록된 책의 정보를 얻어내는 메소드
		public Vector getFoods(String food_kind)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Vector foodList=null;
	        
	        try {
	            conn = getConnection();
	           
	            if(food_kind.equals("all")){
	            	 pstmt = conn.prepareStatement("select * from food");
	            }else{
	                pstmt = conn.prepareStatement("select * from food where food_kind = ? order by reg_date desc");
	                pstmt.setString(1, food_kind);
	            }
	        	rs = pstmt.executeQuery();

	            if (rs.next()) {
	                foodList = new Vector();
	                do{
	                     ShopBean food= new ShopBean();
	                    food.setFood_id(rs.getInt("food_id"));
	                     food.setFood_kind(rs.getString("food_kind"));
	                     food.setFood_name(rs.getString("food_name"));
	                     food.setFood_price(rs.getInt("food_price"));
	                     food.setFood_count(rs.getShort("food_count"));
	                     food.setFood_image(rs.getString("food_image"));
	                     food.setReg_date(rs.getTimestamp("reg_date"));
	                     foodList.addElement(food);
				    }while(rs.next());
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return foodList;
	    }
	
		// 쇼핑몰 메인에 표시하기 위해서 사용하는 분류별 신간책목록을 얻어내는 메소드
		public ShopBean[] getFoods(String food_kind,int count)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        ShopBean foodList[]=null;
	        int i=0;
	        
	        try {
	            conn = getConnection();
	           
	            pstmt = conn.prepareStatement("select * from food where food_kind = ? order by reg_date desc limit ?,?");
	            pstmt.setString(1, food_kind);
	            pstmt.setInt(2, 0);
	            pstmt.setInt(3, count);
	        	rs = pstmt.executeQuery();

	            if (rs.next()) {
	                foodList = new ShopBean[count];
	                do{
	                     ShopBean food= new ShopBean();
	                     food.setFood_id(rs.getInt("food_id"));
	                     food.setFood_kind(rs.getString("food_kind"));
	                     food.setFood_name(rs.getString("food_name"));
	                     food.setFood_price(rs.getInt("food_price"));
	                     food.setFood_count(rs.getShort("food_count"));
	                     food.setFood_image(rs.getString("food_image"));
	                     food.setReg_date(rs.getTimestamp("reg_date"));
	                     foodList[i]=food;
	                     i++;
				    }while(rs.next());
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return foodList;
	    }
		
		// bookId에 해당하는 책의 정보를 얻어내는 메소드로 ,등록된 책을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
		public ShopBean getFood(int food_id)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        ShopBean food=null;
	        
	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement(
	            	"select * from food where food_id = ?");
	            pstmt.setInt(1, food_id);
	            
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                food = new ShopBean();
	                
                    food.setFood_id(rs.getInt("food_id"));
                    food.setFood_kind(rs.getString("food_kind"));
                    food.setFood_name(rs.getString("food_name"));
                    food.setFood_price(rs.getInt("food_price"));
                    food.setFood_count(rs.getInt("food_count"));
                    food.setFood_content(rs.getString("food_content"));
                    food.setFood_image(rs.getString("food_image"));
                    food.setReg_date(rs.getTimestamp("reg_date"));
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return food;
	    }
	    
	    // 등록된 책의 정보를 수정시 사용하는 메소드
	    public void updateFood(ShopBean food, int food_id)
	    
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        String sql;
	        try {
	            conn = getConnection();
	            
	            sql = "update food set food_kind=?,food_name=?,food_price=?,food_count=?";
	            sql += ",food_image=?,food_content=?,reg_date=?";
	            sql += "where food_id=?";
	            
	            pstmt = conn.prepareStatement(sql);
	         
	            pstmt.setString(1, food.getFood_kind());
	            pstmt.setString(2, food.getFood_name());
	            pstmt.setInt(3, food.getFood_price());
	            pstmt.setInt(4, food.getFood_count());
				pstmt.setString(5, food.getFood_image());
				pstmt.setString(6, food.getFood_content());
				pstmt.setTimestamp(7, food.getReg_date());
				pstmt.setInt(8,food.getFood_id());
	            pstmt.executeUpdate();
	            
	 
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }
	    
	    // bookId에 해당하는 책의 정보를 삭제시 사용하는 메소드
	    public void deleteFood(int food_id)
	    throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs= null;
	      
	        try {
				conn = getConnection();

	            pstmt = conn.prepareStatement(
	            	      "delete from food where food_id=?");
	            pstmt.setInt(1, food_id);
	            
	            pstmt.executeUpdate();
	          
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }
	}
	
	
	

