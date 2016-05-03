package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class MemberDAO {
	private Connection getConnection() throws Exception {
		Connection con = null;

		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/yamyam");
		con = ds.getConnection();
		return con;
	}

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {

			con = getConnection();
			sql = "insert into member (id,passwd,name,m_date,gender,email,mobile) values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPasswd());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getM_date());
			pstmt.setString(5, mb.getGender());
			pstmt.setString(6, mb.getEmail());
			pstmt.setString(7, mb.getMobile());

			pstmt.executeUpdate();
			pstmt.clearParameters();

		} catch (Exception e) {
			System.out.println("��������");
			e.printStackTrace();

		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}

		}

	}// ȸ�����Ը޼���()

	// üũ
	public int checkId(String id, String passwd) {
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹� �δ� //2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� select id�� �ش��ϴ� passwd��������
			sql = "select passwd from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4�ܰ� rs ����
			rs = pstmt.executeQuery();
			// 5�ܰ� rs�� ������������ ��й�ȣ�� ������
			// �α�������(���ǰ�����)�̸�"id" �� id
			// main.jsp�̵�
			// Ʋ���� "��й�ȣƲ��" �ڷ��̵�
			// ������ "���̵����" �ڷ��̵�
			if (rs.next()) {
				// ���̵�����
				if (passwd.equals(rs.getString("passwd"))) {
					check = 1;// ��й�ȣ���� <= 1
				} else {
					check = 0;// ��й�ȣƲ�� <= 0
				}
			} else {
				check = -1;// ���̵���� <= -1
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �ݱ�
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return check;
	}// üũ()

	public int acheckId(String id2, String passwd) {
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹� �δ� //2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� select id�� �ش��ϴ� passwd��������
			sql = "select passwd from admin where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id2);
			// 4�ܰ� rs ����
			rs = pstmt.executeQuery();
			// 5�ܰ� rs�� ������������ ��й�ȣ�� ������
			// �α�������(���ǰ�����)�̸�"id" �� id
			// main.jsp�̵�
			// Ʋ���� "��й�ȣƲ��" �ڷ��̵�
			// ������ "���̵����" �ڷ��̵�
			if (rs.next()) {
				// ���̵�����
				if (passwd.equals(rs.getString("passwd"))) {
					check = 1;// ��й�ȣ���� <= 1
				} else {
					check = 0;// ��й�ȣƲ�� <= 0
				}
			} else {
				check = -1;// ���̵���� <= -1
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �ݱ�
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return check;
	}// üũ()

	// getMember()�޼���()
	public MemberBean getMember(String id) {
		MemberBean mb = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹��δ� //2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� sql id�� �ش��ϴ� ������� ��ȸ
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4�ܰ� rs ����������
			rs = pstmt.executeQuery();
			// 5�ܰ� rs�� �������ִ°�� ���̺� ���
			if (rs.next()) {
				// ������ �ִ� ��� �ڹٺ�ü���� �ڹٺ� ����
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPasswd(rs.getString("passwd"));
				mb.setName(rs.getString("name"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setM_date(rs.getTimestamp("m_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �ݱ�
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return mb;
	} // getMember()�޼���()

	// updateMember(mb)
	public int updateMember(MemberBean mb) {
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹��δ� //2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� id�� �ش��ϴ� passwd��������
			sql = "select passwd from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			// 4�ܰ� rs ��������
			rs = pstmt.executeQuery();
			// 5�ܰ� rs������ �ִ°�� ��й�ȣ �� ������
			// 3�ܰ� update id�� �ش��ϴ� name,age,gender,email���� 4�ܰ� ����
			// "��������" main.jsp�̵�
			// Ʋ���� "��й�ȣƲ��" �ڷ��̵�
			// ���°�� "���̵����" �ڷ��̵�
			if (rs.next()) {
				// rs������ �ִ°��
				if (mb.getPasswd().equals(rs.getString("passwd"))) {
					check = 1;// ��й�ȣ �� ������
					// 3�ܰ� update id�� �ش��ϴ� name,age,gender,email���� 4�ܰ�
					// ����
					// "��������" main.jsp�̵�
					sql = "update member set name=?,gender=?,email=?,mobile=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, mb.getName());
					pstmt.setString(2, mb.getGender());
					pstmt.setString(3, mb.getEmail());
					pstmt.setString(4, mb.getMobile());
					pstmt.setString(5, mb.getId());
					pstmt.executeUpdate();
				} else {
					check = 0;// Ʋ���� "��й�ȣƲ��" �ڷ��̵�
				}
			} else {
				check = -1;// ���°�� "���̵����" �ڷ��̵�
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �ݱ�
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}

		return check;
	}

	// deleteMember(id,passwd)
	public int deleteMember(String id, String passwd) {
		int check = -1;

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹��δ�
			// 2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� sql ������ id =�� ������ ������ passwd��������
			sql = "select passwd from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4�ܰ� ���� => rs�������
			rs = pstmt.executeQuery();
			// 5�ܰ� rs�� ù��°�� ������������ ���̵�����
			// �� ��� ��й�ȣ �� ������ delete "��������" main.jsp�̵�
			// Ʋ���� "��й�ȣƲ��"
			// �����;����� "���̵����"
			if (rs.next()) {
				// ���̵�����
				if (passwd.equals(rs.getString("passwd"))) {// ����й�ȣ ����й�ȣ
															// ��
					check = 1;// ��й�ȣ ���� //3 delete 4���� "��������"
					sql = "delete from member where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					// 4�ܰ� ����
					pstmt.executeUpdate();
				} else {
					check = 0;// "��й�ȣƲ��"
				}
			} else {
				check = -1;// ���̵����
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}

		return check;
	}

	// getMembers()
	public List getMembers() {
		List memberList = new ArrayList();

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1�ܰ� ����̹��δ�
			// 2�ܰ� ��񿬰�
			con = getConnection();
			// 3�ܰ� sql member���ȸ����������
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			// 4�ܰ� rs ����������
			rs = pstmt.executeQuery();
			// 5�ܰ� while rs������ ������ ���� �����ͼ� ���
			while (rs.next()) {
				// �ڹٺ� ��ü ���� MemberBean mb
				MemberBean mb = new MemberBean();
				// rs �� => �ڹٺ� ���� ����
				mb.setId(rs.getString("id"));
				mb.setPasswd(rs.getString("passwd"));
				mb.setName(rs.getString("name"));

				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setM_date(rs.getTimestamp("m_date"));
				// => �迭memberList��ĭ���� memberList.add(�ڹٺ�)
				memberList.add(mb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �ݱ�
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return memberList;
	}

	// join_IdCheck(id)
	public int join_IdCheck(String id) {
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try {
			// 1,2 �ܰ� ��񿬰� �޼��� ȣ��
			con = getConnection();
			// 3�ܰ� sql ���� id�� �ش��ϴ� ������ ��������
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4�ܰ� rs = ����
			rs = pstmt.executeQuery();
			// 5�ܰ� rs�� ������ ������ ���̵� �ߺ� check=1
			// ������ ���̵� �ߺ��ƴ� check=0
			if (rs.next()) {
				check = 1;
			} else {
				check = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return check;
	}

}// Ŭ����
