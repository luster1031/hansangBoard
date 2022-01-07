package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import vo.MemberVO;
import vo.NewsVO;

public class MemberDAO {
	public List<NewsVO> listAll(){
		return null;
	}
	
	public ArrayList<NewsVO> search(String keyword){
		return null;
	}
	
	public boolean insert(MemberVO vo) {
		boolean result = true;
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement("INSERT INTO `jdbcdb`.`member` (`ID`, `pw`, `name`, `phone`) VALUES (?, ?, ?, ?);");){

			pstmt.setString(1, vo.getID());
			pstmt.setString(2, vo.getPw());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getPhone());
			
			pstmt.executeUpdate();			
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}
	
	
	public boolean delete(int id) {
		return false;	
	}
	
	public boolean update(NewsVO vo) {
		return false;
	}
	
	public NewsVO listOne(int id) {
		return null;
	}
}
