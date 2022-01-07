package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.xdevapi.PreparableStatement.PreparableStatementFinalizer;

import vo.NewsVO;

public class NewsDAO {
	public List<NewsVO> listAll(){
		ArrayList<NewsVO> list = new ArrayList<>();
		Connection conn = NewsMySQL.connect();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select NID, writer, content, title, cnt, date_format(writedate, '%Y년 %m월 %d일 %H시 %i분') from contents");){	
			NewsVO vo;
			while(rs.next()) {
				vo = new NewsVO();
				vo.setNID(Integer.parseInt(rs.getString(1)));
				vo.setWriter(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setTitle(rs.getString(4));
				vo.setCnt(Integer.parseInt(rs.getString(5)));
				vo.setWritedate(rs.getString(6));
				
				list.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return list;
	}
	
	public ArrayList<NewsVO> search(String keyword){
		return null;
	}
	
	public boolean insert(NewsVO vo) {
		return false;
	}
	
	public boolean delete(int id) {
		return false;	
	}
	
	public boolean update(NewsVO vo) {
		return false;
	}
	
	public NewsVO listOne(int id) {
		Connection conn = NewsMySQL.connect();
		try(PreparedStatement pstmt = conn.prepareStatement("select NID, writer, content, title, cnt, date_format(writedate, '%Y년 %m월 %d일 %H시 %i분') from contents where `NID` = ?");
			){
			pstmt.setInt(1,id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				NewsVO vo = new NewsVO();
				vo.setNID(Integer.parseInt(rs.getString(1)));
				vo.setWriter(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setTitle(rs.getString(4));
				vo.setCnt(Integer.parseInt(rs.getString(5)));
				vo.setWritedate(rs.getString(6));
				System.out.println(vo.getNID() + " "+ vo.getTitle());
				return vo;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return null;
	}
	
}
