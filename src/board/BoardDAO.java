package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	//디비연결
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
	//게시판 글쓰기
	public void writeBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		int num=0;
		ResultSet rs=null;
		try {
			//1,2 디비연결 메서드호출
			con=getConnection();
			//num구하기
			//3 sql  board num 최대값 가져오기
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			//4 rs 실행 결과저장
			rs=pstmt.executeQuery();
			//5 rs 데이터 있으면 글있음 num=num최대값+1
			//          없으면 글없음 num=1
			if(rs.next()){
				num = rs.getInt(1)+1; //데이터있음 글있음  최대글번호+1
			}else{
				num=1;//데이터없음 글없음
			}
			//System.out.println("num="+num);
			//3 sql insert
			sql="insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //num  max(num)+1
			pstmt.setString(2, bb.getName());//name
			pstmt.setString(3, bb.getPasswd());//passwd
			pstmt.setString(4, bb.getSubject());//subject
			pstmt.setString(5, bb.getContent());//content
			pstmt.setInt(6, num);//re_ref 그룹번호 == num 일반글 번호
			pstmt.setInt(7, 0);//re_lev 일반글 들여쓰기 0
			pstmt.setInt(8, 0);//re_seq	일반글 순서 0
			pstmt.setInt(9, 0);//readcount 조회수
			pstmt.setTimestamp(10, bb.getDate());//date
			pstmt.setString(11, bb.getIp());//ip
			pstmt.setString(12,bb.getMi());
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
	}//writeBoard()
	
	//게시판 전체글개수
	public int getBoardCount(){
		int count=0;//글이 없음
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			//1,2 디비연결 메서드호출()
			con=getConnection();
			//3 게시판 모든 글에 개수 가져오기 count(*)
			sql="select count(*) from board";
			pstmt=con.prepareStatement(sql);
			//4 rs 실행 저장
			rs=pstmt.executeQuery();
			//5 rs데이터 있으면 글있으면 count=글개수 저장
			if(rs.next()){
				count=rs.getInt(1);//열번호,열이름
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			//객체 닫기
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return count;
	}//getBoardCount()

	//검색 게시판 전체글개수
		public int getBoardCount(String search){
			int count=0;//글이 없음
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql="";
			ResultSet rs=null;
			try {
				//1,2 디비연결 메서드호출()
				con=getConnection();
				//3 게시판 모든 글에 개수 가져오기 count(*)
				//sql="select count(*) from board where subject like '%안녕%' ";
				sql="select count(*) from board where subject like ? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				//4 rs 실행 저장
				rs=pstmt.executeQuery();
				//5 rs데이터 있으면 글있으면 count=글개수 저장
				if(rs.next()){
					count=rs.getInt(1);//열번호,열이름
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				//객체 닫기
				if(rs!=null)try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
				if(con!=null)try{con.close();}catch(SQLException ex){}
			}
			return count;
		}//getBoardCount()
	
	//게시판목록
	public List<BoardBean> getBoards(int startRow,int pageSize){
//		List boardList=new ArrayList();
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			//1,2 디비연결메서드
			con=getConnection();
			//3 sql select 전체 정렬 잘라주기 limit 시작,개수
			//sql  select * from board	
			//	         정렬 order by re_ref 내림,re_seq 오름
			//	             limit 시작행-1,개수
			sql="select * from board order by re_ref desc,re_seq asc limit ?,?";
			//sql="select * from board where subject like ?  order by re_ref desc,re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			//pstmt.setString(1, "%"+검색어+"%");
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			//4 rs 실행 저장
			rs=pstmt.executeQuery();
			//5 rs데이터있으면
			//  자바빈 객체생성 =>행 열 =>자바빈 저장 =>배열 한칸 저장
			while(rs.next()){
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setIp(rs.getString("ip"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setMi(rs.getString("mi"));
				boardList.add(bb);
				
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return boardList;
	}//getBoards(int startRow,int pageSize)
	
	//검색 게시판목록
		public List<BoardBean> getBoards(int startRow,int pageSize,String search){
//			List boardList=new ArrayList();
			List<BoardBean> boardList=new ArrayList<BoardBean>();
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql="";
			ResultSet rs=null;
			try {
				//1,2 디비연결메서드
				con=getConnection();
				//3 sql select 전체 정렬 잘라주기 limit 시작,개수
				//sql  select * from board	
				//	         정렬 order by re_ref 내림,re_seq 오름
				//	             limit 시작행-1,개수
				//sql="select * from board order by re_ref desc,re_seq asc limit ?,?";
				sql="select * from board where subject like ?  order by re_ref desc,re_seq asc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				//4 rs 실행 저장
				rs=pstmt.executeQuery();
				//5 rs데이터있으면
				//  자바빈 객체생성 =>행 열 =>자바빈 저장 =>배열 한칸 저장
				while(rs.next()){
					BoardBean bb=new BoardBean();
					bb.setNum(rs.getInt("num"));
					bb.setPasswd(rs.getString("passwd"));
					bb.setName(rs.getString("name"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setDate(rs.getTimestamp("date"));
					bb.setIp(rs.getString("ip"));
					bb.setRe_lev(rs.getInt("re_lev"));
					bb.setRe_ref(rs.getInt("re_ref"));
					bb.setRe_seq(rs.getInt("re_seq"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setMi(rs.getString("mi"));
					boardList.add(bb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				if(rs!=null)try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
				if(con!=null)try{con.close();}catch(SQLException ex){}
			}
			return boardList;
		}//getBoards(int startRow,int pageSize)
		
	//num 게시판글가져오기
	public BoardBean getBoard(int num){
		BoardBean bb=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 num에 해당하는 게시판글 하나 조회
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 rs 실행 저장
			rs=pstmt.executeQuery();
			//5 rs데이터있으면 bb 객체 생성
			//  rs => bb자바빈 변수 저장 
			if(rs.next()){
				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setIp(rs.getString("ip"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setMi("mi");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return bb;
	}//getBoard(int num)
	
	//조회수 1증가
	public void updateReadCount(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		try {
			//1,2디비연결
			con=getConnection();
			//3 num에 해당하는 readcount를 1증가
			sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
	}//updateReadCount(int num)
	
	//답글쓰기
	public void reWriteBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		int num=0;
		ResultSet rs=null;
		try{
			//1,2 디비연결
			con=getConnection();
			//num 구하기
			//3 sql  board num 최대값 가져오기
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			//4 rs 실행 결과저장
			rs=pstmt.executeQuery();
			//5 rs 데이터 있으면 글있음 num=num최대값+1
			//          없으면 글없음 num=1
			if(rs.next()){
				num = rs.getInt(1)+1; //데이터있음 글있음  최대글번호+1
			}else{
				num=1;//데이터없음 글없음
			}
			//답변글의 순서 재배치 
			// 같은 그룹 이고  답변글을 달고자하는 글의 re_seq값 큰값
			//  기존 re_seq 값 1증가
			//3 update re_seq 1증가 조건 같은 그룹,re_seq 큰값
			sql="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			//4실행
			pstmt.executeUpdate();
			//insert num  re_ref 그대로 re_lev , re_seq 1증가
			//3 sql insert
			sql="insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //num  max(num)+1
			pstmt.setString(2, bb.getName());//name
			pstmt.setString(3, bb.getPasswd());//passwd
			pstmt.setString(4, bb.getSubject());//subject
			pstmt.setString(5, bb.getContent());//content
			pstmt.setInt(6, bb.getRe_ref());//re_ref 그룹번호 
			pstmt.setInt(7, bb.getRe_lev()+1);//re_lev +1
			pstmt.setInt(8, bb.getRe_seq()+1);//re_seq	+1
			pstmt.setInt(9, 0);//readcount 조회수
			pstmt.setTimestamp(10, bb.getDate());//date
			pstmt.setString(11, bb.getIp());//ip
			pstmt.setString(12,bb.getMi());
			//4 실행
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
	}//reWriteBoard(BoardBean bb)
	
	
	public BoardBean updateGetBoard(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		BoardBean bb = null;
		
		try{
			//1,2 디비연결
			con=getConnection();
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()){
			bb = new BoardBean();
			bb.setNum(rs.getInt("num"));
			bb.setPasswd(rs.getString("passwd"));
			bb.setName(rs.getString("name"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setIp(rs.getString("ip"));
			bb.setRe_lev(rs.getInt("re_lev"));
			bb.setRe_ref(rs.getInt("re_ref"));
			bb.setRe_seq(rs.getInt("re_seq"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setMi(rs.getString("mi"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		
		return bb;
		
		
		
	}
	public int updateBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		String dbpasswd="";
		int check = -1;
		try{System.out.println("3");
			//1,2 디비연결
			con=getConnection();
			sql="select passwd from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs=pstmt.executeQuery();
			if(rs.next()){	System.out.println("1");
				dbpasswd=rs.getString("passwd");
				if(dbpasswd.equals(bb.getPasswd())){
					sql="update board set name=?,passwd=?,subject=?,content=?,mi=? where num=?";
				}
				pstmt = con.prepareStatement(sql);
				System.out.println("7");
				pstmt.setString(1, bb.getName());//name
				pstmt.setString(2, bb.getPasswd());
				pstmt.setString(3, bb.getSubject());//subject
				pstmt.setString(4, bb.getContent());//content
				pstmt.setString(5, bb.getMi());
				pstmt.setInt(6, bb.getNum());
				//4 실행
				System.out.println("2");
				pstmt.executeUpdate();
				
				check=1;
				
			}else{
				check=0;
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		
		}
		return check;
		
		
	}
	
	
	public int deleteBoard(int num, String passwd){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		int check=-1;
		ResultSet rs=null;
		String dbpasswd="";
		try{
			
				con = getConnection();
				
				pstmt = con.prepareStatement(
						"select passwd from board where num=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					dbpasswd = rs.getString("passwd");
					if(dbpasswd.equals(passwd)){
						pstmt = con.prepareStatement("delete from board where num=?");
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
						check=1;//글삭제 성공
						
						
					}else
						check=0;//비밀번호 틀림
				}
						
						
				
	}catch(Exception e){
		e.printStackTrace();
	}finally {
		if(rs!=null)try{rs.close();}catch(SQLException ex){}
		if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
		if(con!=null)try{con.close();}catch(SQLException ex){}
	}
		return check;
		
	}
	
	
	
	
	
	
}//클래스

