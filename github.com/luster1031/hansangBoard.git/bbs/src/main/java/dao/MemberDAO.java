package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import vo.MemberVO;
import vo.NewsVO;

public class MemberDAO {
	public ArrayList<MemberVO> listAll(){
		  
	      ArrayList<MemberVO> list = new ArrayList<>();
	      Connection conn = NewsMySQL.connect();
	      
	      try (Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery("select ID,  pw, name ,phone) "
	                  + "from jdbcdb.member ;");){   
	         
	         while(rs.next()) {
	            MemberVO member = new MemberVO();
	            member.setID(rs.getString(1));
	            member.setPw(rs.getString(2));
	            member.setName(rs.getString(3));
	            member.setPhone(rs.getString(4));
	            list.add(member);
	         }
	      
	      }catch(SQLException e) {
	         e.printStackTrace();
	      }
	      NewsMySQL.close(conn);
	      return list;
	}
	
	public MemberVO search(String keyword){
	      Connection conn = NewsMySQL.connect();
	      MemberVO member = new MemberVO();
	      try (Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery("select ID,  pw, name ,phone "
	                  + "from jdbcdb.member where ID = '"+keyword+"'");){   
	    	  	if (rs.next()) {
	            member.setID(rs.getString(1));
	            
	            member.setPw(rs.getString(2));
	            member.setName(rs.getString(3));
	            member.setPhone(rs.getString(4));
	    	  	}
	         
	      
	      }catch(SQLException e) {
	         e.printStackTrace();
	      }
	      NewsMySQL.close(conn);
	      return member;
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