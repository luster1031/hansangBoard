package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;

import com.mysql.cj.xdevapi.PreparableStatement.PreparableStatementFinalizer;

import vo.NewsVO;

public class NewsDAO {
	public List<NewsVO> listAll(){
		List<NewsVO> list = new ArrayList<>();
		Connection conn = NewsMySQL.connect();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select NID, writer, content, title, cnt, date_format(writedate, '%Y년 %m월 %d일 %H시 %i분') "
						+ "from contents");){	
			NewsVO vo;
			while(rs.next()) {
				vo = new NewsVO();
				vo.setNID(Integer.parseInt(rs.getString(1)));
				vo.setWriter(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setTitle(rs.getString(4));
				vo.setCnt(Integer.parseInt(rs.getString(5)));
				vo.setWritedate(rs.getString(6));
				System.out.println("[listAll]"+ vo.getWriter() + " "+ vo.getTitle() + " "+ vo.getContent() + " "+ vo.getWritedate()+ " "+vo.getCnt());
				list.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return list;
	}
	
	public ArrayList<NewsVO> search(String keyword){
		ArrayList<NewsVO> list = new ArrayList<>();
		Connection conn = NewsMySQL.connect();
		System.out.println("[keyword : ] "+ keyword);
		try (Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select NID, writer, content, title,cnt, date_format(writedate, '%Y년 %m월 %d일 %H시 %i분') "
						+ "from jdbcdb.contents where content like '%"+keyword + "%' OR title like '%"+keyword + "%'");){	
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
				System.out.println("[search]:" + vo.getNID() + " "+ vo.getTitle() + " "+ vo.getContent());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return list;
	}
	
	public boolean insert(NewsVO vo) {
		boolean result = true;
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement("insert into contents (writer, content, title, writedate) values(? ,?, ?, ?)");){
			
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss")));
			
			pstmt.executeUpdate();			
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}

	public boolean delete(int NID) {
		boolean result = true;
		System.out.println("[DAO_delete] NID : " + NID);
		
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement("delete from jdbcdb.contents where NID = ?");){
			pstmt.setInt(1,NID);
			int deleteNum = pstmt.executeUpdate();
			if(deleteNum != 1)
				result = false;
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}
	
	public boolean update(NewsVO vo) {
		boolean result = true;
		Connection conn = NewsMySQL.connect();
		try (PreparedStatement pstmt = conn.prepareStatement(
				"update jdbcdb.contents set "+
				"writer = ?, " + 
				"content= ?, " + 
				"title = ?, " +
				"writedate = ?, "+
				"cnt = ? "+
				"where NID = ?");){
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getWritedate());
			pstmt.setInt(5, vo.getCnt());
			pstmt.setInt(6, vo.getNID());
			pstmt.executeUpdate();
			System.out.println("[update]"+ vo.getWriter() + " "+ vo.getTitle() + " "+ vo.getContent() + " "+ vo.getWritedate()+ " "+vo.getCnt());
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return result;
	}
	

	public NewsVO listOne(int id) {
		Connection conn = NewsMySQL.connect();
		try(PreparedStatement pstmt = conn.prepareStatement("select NID, writer, content, title, cnt, date_format(writedate, '%Y-%m-%d %H:%i') from contents where `NID` = ?");
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
				System.out.println("[list_One]" + vo.getNID() + " "+ vo.getTitle());
				return vo;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		NewsMySQL.close(conn);
		return null;
	}
	
}