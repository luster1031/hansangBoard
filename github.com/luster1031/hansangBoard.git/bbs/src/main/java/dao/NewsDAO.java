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

import vo.NewsVO;

public class NewsDAO {
	public List<NewsVO> listAll(){
		return null;
	}
	
	  public ArrayList<NewsVO> search(String keyword){
	      ArrayList<NewsVO> list = new ArrayList<>();
	      Connection conn = NewsMySQL.connect();
	      System.out.println("[keyword : ] "+ keyword);
	      try (Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery("select NID, writer, content, title,cnt, date_format(writedate, '%Y년 %m월 %d일 %H시 %i분') "
	                  + "from jdbcdb.contents where writer like '%"+keyword + "%'");){   
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

			pstmt.setString(1, "asdf");
			pstmt.setString(2, "asdf");
			pstmt.setString(3, "asdf");
			pstmt.setString(4, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss")));
			
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
