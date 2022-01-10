package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import vo.CommentVO;
public class CommentDAO {
	public List<CommentVO> listAll(int board_num){
		List<CommentVO> list = new ArrayList<>();
		Connection conn = NewsMySQL.connect();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select comment_num, comment_board, comment_writer, comment_content, date_format(comment_date, '%Y년 %m월 %d일 %H시 %i분') "
						+ "from comments"
						+ " where comment_board="+board_num);){
			CommentVO vo;
			while(rs.next()) {
				vo= new CommentVO();
				vo.setCommnet_num(Integer.parseInt(rs.getString(1)));
				vo.setNID(Integer.parseInt(rs.getString(2)));
				vo.setWriter(rs.getString(3));
				vo.setContent(rs.getString(4));
				vo.setDate(rs.getString(5));
				list.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return list;
	}
	public boolean insert(CommentVO vo) {
		boolean result = true;
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement("insert into comments "
				+ "( comment_writer, comment_date, comment_content, comment_board) values(?, ?, ?,?)");){
			
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getDate());
			pstmt.setString(3, vo.getContent());
			pstmt.setInt(4, vo.getNID());
			pstmt.executeUpdate();			
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}
	
	public boolean update(CommentVO vo) {
		boolean result = true;
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement(
				"update comments set "+
				"comment_num = ?, " + 
				"comment_writer = ?, " +
				"comment_date = ?, "+
				"comment_content = ? "+
				"where comment_board = ?");){
			pstmt.setInt(1, vo.getCommnet_num());
			pstmt.setString(2, vo.getWriter());
			pstmt.setString(3, vo.getDate());
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getNID());
			pstmt.executeUpdate();
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}
}
